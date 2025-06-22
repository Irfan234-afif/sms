<?php

namespace App\Services;

use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\ActivityTrainingProgram;
use App\Models\TrainingProgram\ActivityPhase;
use App\Models\TrainingProgram\ActivityModule;
use App\Models\TrainingProgram\ActivityMaterial;
use App\Models\TrainingProgram\ActivityQuiz;
use App\Models\TrainingProgram\ActivityQuizQuestion;
use App\Models\TrainingProgram\ActivityQuizQuestionOption;
use App\Models\TrainingProgram\ActivityAssessment;
use App\Models\TrainingProgram\ActivityAssessmentGroupIndicator;
use App\Models\TrainingProgram\ActivityAssessmentIndicator;
use App\Models\TrainingProgram\ActivityAssessmentIndicatorSession;
use App\Models\TrainingProgram\ActivityAssessmentRubric;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ActivitySnapshotService
{
    /**
     * Create activity snapshot from training program.
     */
    public function createSnapshot(TrainingProgramActivity $activity): bool
    {
        if (!$activity->training_program_id) {
            Log::warning("Activity {$activity->id} has no training_program_id - skipping snapshot creation");
            return true; // Not an error for external training
        }

        try {
            DB::beginTransaction();

            $trainingProgram = $activity->trainingProgram;
            
            if (!$trainingProgram) {
                throw new \Exception("Training program not found for activity {$activity->id}");
            }

            // Create activity training program snapshot
            $activityTrainingProgram = $this->createActivityTrainingProgramSnapshot($activity, $trainingProgram);

            // Create phases snapshots
            $this->createPhasesSnapshots($activityTrainingProgram, $trainingProgram);

            DB::commit();
            
            Log::info("Successfully created snapshot for activity {$activity->id}");
            return true;

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Failed to create snapshot for activity {$activity->id}: " . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Create activity training program snapshot.
     */
    private function createActivityTrainingProgramSnapshot(
        TrainingProgramActivity $activity, 
        TrainingProgram $trainingProgram
    ): ActivityTrainingProgram {
        return ActivityTrainingProgram::create([
            'activity_id' => $activity->id,
            'master_training_program_id' => $trainingProgram->id,
            'name' => $trainingProgram->name,
            'type' => $trainingProgram->type,
            'level' => $trainingProgram->level,
            'description' => $trainingProgram->description,
            'status' => 'active', // Always active for activity snapshots
        ]);
    }

    /**
     * Create phases snapshots.
     */
    private function createPhasesSnapshots(
        ActivityTrainingProgram $activityTrainingProgram, 
        TrainingProgram $trainingProgram
    ): void {
        $phases = $trainingProgram->phases()
            ->where('status', 'active')
            ->orderBy('order')
            ->get();

        foreach ($phases as $phase) {
            $activityPhase = ActivityPhase::create([
                'activity_training_program_id' => $activityTrainingProgram->id,
                'master_phase_id' => $phase->id,
                'name' => $phase->name,
                'description' => $phase->description,
                'order' => $phase->order,
                'status' => 'active',
            ]);

            // Create modules snapshots
            $this->createModulesSnapshots($activityPhase, $phase);
        }
    }

    /**
     * Create modules snapshots.
     */
    private function createModulesSnapshots(ActivityPhase $activityPhase, $phase): void
    {
        $modules = $phase->modules()
            ->where('status', 'active')
            ->orderBy('order')
            ->get();

        foreach ($modules as $module) {
            $activityModule = ActivityModule::create([
                'activity_phase_id' => $activityPhase->id,
                'master_module_id' => $module->id,
                'name' => $module->name,
                'description' => $module->description,
                'order' => $module->order,
                'status' => 'active',
            ]);

            // Create materials snapshots
            $this->createMaterialsSnapshots($activityModule, $module);

            // Create quizzes snapshots
            $this->createQuizzesSnapshots($activityModule, $module);

            // Create assessments snapshots
            $this->createAssessmentsSnapshots($activityModule, $module);
        }
    }

    /**
     * Create materials snapshots.
     */
    private function createMaterialsSnapshots(ActivityModule $activityModule, $module): void
    {
        $materials = $module->materials()
            ->where('status', 'active')
            ->orderBy('order')
            ->get();

        foreach ($materials as $material) {
            ActivityMaterial::create([
                'activity_module_id' => $activityModule->id,
                'master_material_id' => $material->id,
                'title' => $material->title,
                'description' => $material->description,
                'type' => $material->type,
                'content' => $material->content,
                'url' => $material->url,
                'file_path' => $material->file_path,
                'order' => $material->order,
                'status' => 'active',
            ]);
        }
    }

    /**
     * Create quizzes snapshots.
     */
    private function createQuizzesSnapshots(ActivityModule $activityModule, $module): void
    {
        $quizzes = $module->quizzes()
            ->where('status', 'active')
            ->get();

        foreach ($quizzes as $quiz) {
            $activityQuiz = ActivityQuiz::create([
                'activity_module_id' => $activityModule->id,
                'master_quiz_id' => $quiz->id,
                'title' => $quiz->title,
                'description' => $quiz->description,
                'passing_score' => $quiz->passing_score,
                'max_attempts' => 3, // Default value since it doesn't exist in master
                'show_results' => true, // Default value since it doesn't exist in master
                'order' => 0, // Default value since it doesn't exist in master
                'status' => 'active',
            ]);

            // Create questions snapshots
            $this->createQuestionsSnapshots($activityQuiz, $quiz);
        }
    }

    /**
     * Create questions snapshots.
     */
    private function createQuestionsSnapshots(ActivityQuiz $activityQuiz, $quiz): void
    {
        $questions = $quiz->questions()
            ->orderBy('order')
            ->get();

        foreach ($questions as $question) {
            $activityQuestion = ActivityQuizQuestion::create([
                'activity_quiz_id' => $activityQuiz->id,
                'master_question_id' => $question->id,
                'question_text' => $question->question, // Column name is 'question' not 'question_text'
                'type' => $question->type,
                'points' => $question->points ?? 1,
                'order' => $question->order,
                'explanation' => $question->explanation,
                'correct_answer' => $question->correct_answer,
                'status' => $question->status ?? 'active',
            ]);

            // Create options snapshots
            $this->createOptionsSnapshots($activityQuestion, $question);
        }
    }

    /**
     * Create options snapshots.
     */
    private function createOptionsSnapshots(ActivityQuizQuestion $activityQuestion, $question): void
    {
        $options = $question->options()
            ->orderBy('order')
            ->get();

        foreach ($options as $option) {
            ActivityQuizQuestionOption::create([
                'activity_quiz_question_id' => $activityQuestion->id,
                'master_option_id' => $option->id,
                'option_text' => $option->option_text,
                'is_correct' => $option->is_correct,
                'order' => $option->order,
                'explanation' => $option->explanation,
            ]);
        }
    }

    /**
     * Create assessments snapshots.
     */
    private function createAssessmentsSnapshots(ActivityModule $activityModule, $module): void
    {
        $assessments = $module->assessments()->get();

        foreach ($assessments as $assessment) {
            $activityAssessment = ActivityAssessment::create([
                'activity_module_id' => $activityModule->id,
                'master_assessment_id' => $assessment->id,
                'title' => $assessment->title,
                'description' => $assessment->description,
                'calculation_method' => $assessment->calculation_method ?? 'AVERAGE',
                'passing_score' => $assessment->passing_score ?? 70,
            ]);

            // Create group indicators snapshots
            $this->createGroupIndicatorsSnapshots($activityAssessment, $assessment);
        }
    }

    /**
     * Create group indicators snapshots.
     */
    private function createGroupIndicatorsSnapshots(ActivityAssessment $activityAssessment, $assessment): void
    {
        $groupIndicators = $assessment->groupIndicators()
            ->orderBy('order')
            ->get();

        foreach ($groupIndicators as $groupIndicator) {
            $activityGroupIndicator = ActivityAssessmentGroupIndicator::create([
                'activity_assessment_id' => $activityAssessment->id,
                'master_group_indicator_id' => $groupIndicator->id,
                'name' => $groupIndicator->name,
                'description' => $groupIndicator->description,
                'order' => $groupIndicator->order,
            ]);

            // Create indicators snapshots
            $this->createIndicatorsSnapshots($activityGroupIndicator, $groupIndicator);
        }
    }

    /**
     * Create indicators snapshots.
     */
    private function createIndicatorsSnapshots(ActivityAssessmentGroupIndicator $activityGroupIndicator, $groupIndicator): void
    {
        $indicators = $groupIndicator->indicators()
            ->orderBy('order')
            ->get();

        foreach ($indicators as $indicator) {
            $activityIndicator = ActivityAssessmentIndicator::create([
                'activity_group_indicator_id' => $activityGroupIndicator->id,
                'master_indicator_id' => $indicator->id,
                'name' => $indicator->name,
                'description' => $indicator->description,
                'order' => $indicator->order,
            ]);

            // Create sessions snapshots
            $this->createSessionsSnapshots($activityIndicator, $indicator);
        }
    }

    /**
     * Create sessions snapshots.
     */
    private function createSessionsSnapshots(ActivityAssessmentIndicator $activityIndicator, $indicator): void
    {
        $sessions = $indicator->sessions()
            ->orderBy('order')
            ->get();

        foreach ($sessions as $session) {
            $activitySession = ActivityAssessmentIndicatorSession::create([
                'activity_indicator_id' => $activityIndicator->id,
                'master_session_id' => $session->id,
                'name' => $session->name,
                'description' => $session->description,
                'order' => $session->order,
            ]);

            // Create rubrics snapshots
            $this->createRubricsSnapshots($activitySession, $session);
        }
    }

    /**
     * Create rubrics snapshots.
     */
    private function createRubricsSnapshots(ActivityAssessmentIndicatorSession $activitySession, $session): void
    {
        $rubrics = $session->rubrics()
            ->orderBy('order')
            ->get();

        foreach ($rubrics as $rubric) {
            ActivityAssessmentRubric::create([
                'activity_session_id' => $activitySession->id,
                'master_rubric_id' => $rubric->id,
                'level' => $rubric->level,
                'description' => $rubric->description,
                'score' => $rubric->score,
                'order' => $rubric->order,
            ]);
        }
    }
}