<?php

namespace Database\Seeders;

use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramPhase;
use App\Models\TrainingProgram\PhaseModule;
use App\Models\TrainingProgram\PhaseModuleMaterial;
use App\Models\TrainingProgram\PhaseModuleQuiz;
use App\Models\TrainingProgram\PhaseModuleQuizQuestion;
use App\Models\TrainingProgram\PhaseModuleQuizQuestionOption;
use App\Models\TrainingProgram\ModuleAssessment;
use App\Models\TrainingProgram\AssessmentGroupIndicator;
use App\Models\TrainingProgram\AssessmentIndicator;
use App\Models\TrainingProgram\AssessmentIndicatorSession;
use App\Models\TrainingProgram\AssessmentIndicatorSessionRubric;
use Illuminate\Database\Seeder;

class TrainingProgramSeeder extends Seeder
{
    public function run()
    {
        // Create Training Program
        $program = TrainingProgram::create([
            'name' => 'Leadership Development Program',
            'type' => 'professional',
            'level' => 'intermediate',
            'description' => 'Comprehensive leadership training for mid-level managers',
            'status' => 'active'
        ]);

        // Create Phases
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Foundational Leadership',
            'description' => 'Core leadership principles and self-awareness',
            'order' => 1,
            'status' => 'active'
        ]);

        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Team Management',
            'description' => 'Building and leading effective teams',
            'order' => 2,
            'status' => 'active'
        ]);

        // Create Modules for Phase 1
        $module1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Leadership Fundamentals',
            'description' => 'Introduction to core leadership concepts',
            'order' => 1,
            'status' => 'active'
        ]);

        $module2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Emotional Intelligence',
            'description' => 'Developing self-awareness and empathy',
            'order' => 2,
            'status' => 'active'
        ]);

        // Add Materials to Module 1
        PhaseModuleMaterial::create([
            'phase_module_id' => $module1->id,
            'title' => 'What is Leadership?',
            'type' => 'text',
            'content' => 'Leadership is the art of motivating a group of people to act toward achieving a common goal.',
            'order' => 1,
            'status' => 'active'
        ]);

        // Add Quiz to Module 1
        $quiz1 = PhaseModuleQuiz::create([
            'phase_module_id' => $module1->id,
            'title' => 'Leadership Fundamentals Quiz',
            'description' => 'Test your understanding of basic leadership concepts',
            'passing_score' => 70,
            'time_limit' => 30,
            'status' => 'active'
        ]);

        // Add Questions to Quiz 1
        $question1 = PhaseModuleQuizQuestion::create([
            'phase_module_quiz_id' => $quiz1->id,
            'question' => 'Which of these is NOT a key leadership trait?',
            'type' => 'multiple_choice',
            'points' => 1,
            'order' => 1
        ]);

        // Add Options to Question 1
        PhaseModuleQuizQuestionOption::create([
            'phase_module_quiz_question_id' => $question1->id,
            'option_text' => 'Empathy',
            'is_correct' => false,
            'order' => 1
        ]);
        PhaseModuleQuizQuestionOption::create([
            'phase_module_quiz_question_id' => $question1->id,
            'option_text' => 'Micromanagement',
            'is_correct' => true,
            'order' => 2
        ]);

        // Add Assessment to Module 1
        $assessment1 = ModuleAssessment::create([
            'phase_module_id' => $module1->id,
            'title' => 'Leadership Self-Assessment',
            'description' => 'Evaluate your current leadership skills'
        ]);

        // Add Assessment Components
        $group1 = AssessmentGroupIndicator::create([
            'module_assessment_id' => $assessment1->id,
            'name' => 'Communication Skills',
            'description' => 'Ability to communicate effectively',
            'order' => 1
        ]);

        $indicator1 = AssessmentIndicator::create([
            'assessment_group_indicator_id' => $group1->id,
            'name' => 'Active Listening',
            'description' => 'Demonstrates attentive listening skills',
            'order' => 1
        ]);

        $session1 = AssessmentIndicatorSession::create([
            'assessment_indicator_id' => $indicator1->id,
            'name' => 'Team Meetings',
            'description' => 'Observation during team meetings',
            'order' => 1
        ]);

        AssessmentIndicatorSessionRubric::create([
            'assessment_indicator_session_id' => $session1->id,
            'level' => 'A+',
            'description' => 'Consistently demonstrates active listening',
            'score' => 10,
            'order' => 1
        ]);
        AssessmentIndicatorSessionRubric::create([
            'assessment_indicator_session_id' => $session1->id,
            'level' => 'A',
            'description' => 'Consistently demonstrates active listening',
            'score' => 8,
            'order' => 1
        ]);
        AssessmentIndicatorSessionRubric::create([
            'assessment_indicator_session_id' => $session1->id,
            'level' => 'B+',
            'description' => 'Consistently demonstrates active listening',
            'score' => 6,
            'order' => 1
        ]);

        // Repeat similar structure for other modules/phases as needed
    }
}
