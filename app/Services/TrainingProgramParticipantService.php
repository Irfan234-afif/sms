<?php

namespace App\Services;

use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\TrainingProgramMaterialProgress;
use App\Models\TrainingProgram\TrainingProgramQuizAttempt;
use App\Models\TrainingProgram\TrainingProgramAssessmentResult;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TrainingProgramParticipantService
{
    /**
     * Mark material as viewed for participant.
     */
    public function markMaterialViewed(string $activityUuid, int $materialId, int $profileId): bool
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with('activityTrainingProgram.phases.modules.materials')
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Find the activity material from snapshot
        $activityMaterial = $this->findActivityMaterial($activity, $materialId);

        if (!$activityMaterial) {
            throw new \InvalidArgumentException('Material tidak ditemukan dalam aktivitas ini.');
        }

        // Get or create material progress using snapshot
        $materialProgress = $participant->materialProgress()
            ->where('activity_material_id', $activityMaterial->id)
            ->first();

        if (!$materialProgress) {
            $materialProgress = TrainingProgramMaterialProgress::create([
                'participant_id' => $participant->id,
                'activity_material_id' => $activityMaterial->id,
                'master_material_id' => $materialId,
                'time_spent' => 0,
            ]);
        }

        // Mark as viewed
        $materialProgress->markAsViewed();

        return true;
    }

    /**
     * Mark material as completed for participant.
     */
    public function markMaterialCompleted(string $activityUuid, int $materialId, int $profileId, ?int $timeSpent = null): bool
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with('activityTrainingProgram.phases.modules.materials')
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        

        // Find the activity material from snapshot
        $activityMaterial = $this->findActivityMaterial($activity, $materialId);

        if (!$activityMaterial) {
            throw new \InvalidArgumentException('Material tidak ditemukan dalam aktivitas ini.');
        }

        DB::beginTransaction();
        try {
            // Get or create material progress using snapshot
            $materialProgress = $participant->materialProgress()
                ->where('activity_material_id', $activityMaterial->id)
                ->first();

            if (!$materialProgress) {
                $materialProgress = TrainingProgramMaterialProgress::create([
                    'participant_id' => $participant->id,
                    'activity_material_id' => $activityMaterial->id,
                    'master_material_id' => $materialId,
                    'time_spent' => 0,
                ]);
            }

            // Update time spent if provided
            if ($timeSpent !== null) {
                $materialProgress->addTimeSpent($timeSpent);
            }

            // Mark as completed
            $materialProgress->markAsCompleted();

            // Update progress calculations
            $this->updateProgressCalculations($participant);

            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Start quiz attempt for participant.
     */
    public function startQuizAttempt(string $activityUuid, int $quizId, int $profileId): TrainingProgramQuizAttempt
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with(['activityTrainingProgram.phases.modules.quizzes'])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Find the activity quiz through the activity snapshot structure
        if (!$activity->activityTrainingProgram) {
            throw new \RuntimeException('Activity tidak memiliki snapshot data. Silakan hubungi administrator.');
        }

        $activityQuiz = $this->findActivityQuiz($activity, $quizId);

        if (!$activityQuiz) {
            throw new \InvalidArgumentException('Quiz tidak ditemukan dalam activity ini');
        }

        // Check if there's an existing incomplete attempt for this quiz
        $existingAttempt = $participant->quizAttempts()
            ->where('activity_quiz_id', $activityQuiz->id)
            ->whereNull('completed_at')
            ->orderBy('id', 'desc')
            ->first();

        if ($existingAttempt) {
            return $existingAttempt;
        }

        // Check if participant can take quiz (max attempts, etc.)
        $attemptNumber = TrainingProgramQuizAttempt::getNextAttemptNumber($participant->id, $activityQuiz->id);
        
        // Create new quiz attempt with proper snapshot references
        $attempt = TrainingProgramQuizAttempt::create([
            'participant_id' => $participant->id,
            'activity_quiz_id' => $activityQuiz->id,
            'master_quiz_id' => $activityQuiz->master_quiz_id,
            'old_quiz_id' => $activityQuiz->master_quiz_id, // For backward compatibility
            'attempt_number' => $attemptNumber,
            'started_at' => now(),
        ]);

        return $attempt;
    }

    /**
     * Submit quiz answers for participant.
     */
    public function submitQuizAnswers(string $activityUuid, int $quizId, int $profileId, int $attemptId, array $answers): TrainingProgramQuizAttempt
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        DB::beginTransaction();
        try {
            $attempt = $participant->quizAttempts()
                ->where('id', $attemptId)
                ->where(function ($query) use ($quizId) {
                    $query->where('activity_quiz_id', $quizId)
                          ->orWhere('master_quiz_id', $quizId)
                          ->orWhere('old_quiz_id', $quizId);
                })
                ->whereNull('completed_at')
                ->firstOrFail();

            // Complete the attempt and calculate score
            $attempt->completeAttempt($answers);

            // Update progress calculations
            $this->updateProgressCalculations($participant);

            DB::commit();
            return $attempt;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Get material progress for participant.
     */
    public function getMaterialProgress(string $activityUuid, int $materialId, int $profileId): ?TrainingProgramMaterialProgress
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Get material progress using both snapshot and legacy field for compatibility
        $materialProgress = $participant->materialProgress()
            ->where(function ($query) use ($materialId) {
                $query->where('activity_material_id', $materialId)
                      ->orWhere('master_material_id', $materialId)
                      ->orWhere('old_material_id', $materialId);
            })
            ->first();

        if (!$materialProgress) {
            // Create fallback for legacy data
            $materialProgress = TrainingProgramMaterialProgress::create([
                'participant_id' => $participant->id,
                'old_material_id' => $materialId,
                'master_material_id' => $materialId,
                'time_spent' => 0,
            ]);
        }

        return $materialProgress;
    }

    /**
     * Update progress calculations for participant.
     */
    public function updateProgressCalculations(TrainingProgramActivityParticipant $participant): void
    {
        try {
            // Update module progress
            foreach ($participant->moduleProgress as $moduleProgress) {
                try {
                    $moduleProgress->calculateProgress();
                } catch (\Exception $e) {
                    // Log error but continue with other modules
                    \Log::warning('Error calculating module progress', [
                        'module_progress_id' => $moduleProgress->id,
                        'participant_id' => $participant->id,
                        'error' => $e->getMessage()
                    ]);
                }
            }

            // Update phase progress
            foreach ($participant->phaseProgress as $phaseProgress) {
                try {
                    $phaseProgress->calculateProgress();
                } catch (\Exception $e) {
                    // Log error but continue with other phases
                    \Log::warning('Error calculating phase progress', [
                        'phase_progress_id' => $phaseProgress->id,
                        'participant_id' => $participant->id,
                        'error' => $e->getMessage()
                    ]);
                }
            }

            // Update overall progress
            $participant->calculateOverallProgress();

            // Check if certificate should be issued
            if ($participant->hasCompleted()) {
                $participant->issueCertificate();
            }
        } catch (\Exception $e) {
            // Log error but don't throw to prevent blocking material completion
            \Log::error('Error in updateProgressCalculations', [
                'participant_id' => $participant->id,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
        }
    }

    /**
     * Issue certificate for completed participant.
     */
    public function issueCertificate(TrainingProgramActivityParticipant $participant): bool
    {
        if (!$participant->hasCompleted()) {
            return false;
        }

        $participant->update([
            'certificate_issued' => true,
            'certificate_issued_at' => now(),
        ]);

        return true;
    }

    /**
     * Find activity material from snapshot.
     */
    private function findActivityMaterial(TrainingProgramActivity $activity, int $materialId): ?object
    {
        if (!$activity->activityTrainingProgram) {
            return null;
        }

        foreach ($activity->activityTrainingProgram->phases as $phase) {
            foreach ($phase->modules as $module) {
                foreach ($module->materials as $material) {
                    if ($material->master_material_id == $materialId) {
                        return $material;
                    }
                }
            }
        }

        return null;
    }

    /**
     * Find activity quiz from snapshot.
     */
    private function findActivityQuiz(TrainingProgramActivity $activity, int $quizId): ?object
    {
        foreach ($activity->activityTrainingProgram->phases as $phase) {
            foreach ($phase->modules as $module) {
                foreach ($module->quizzes as $quiz) {
                    if ($quiz->id == $quizId || $quiz->master_quiz_id == $quizId) {
                        return $quiz;
                    }
                }
            }
        }

        return null;
    }

    /**
     * Get participant quiz attempts.
     */
    public function getQuizAttempts(string $activityUuid, int $quizId, int $profileId): \Illuminate\Database\Eloquent\Collection
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        return $participant->quizAttempts()
            ->where(function ($query) use ($quizId) {
                $query->where('activity_quiz_id', $quizId)
                      ->orWhere('master_quiz_id', $quizId)
                      ->orWhere('old_quiz_id', $quizId);
            })
            ->with('quiz.questions.options')
            ->get();
    }

    /**
     * Get assessment results for participant.
     */
    public function getAssessmentResults(string $activityUuid, int $assessmentId, int $profileId): ?\Illuminate\Database\Eloquent\Collection
    {
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        return $participant->assessmentResults()
            ->where(function ($query) use ($assessmentId) {
                $query->where('activity_assessment_id', $assessmentId)
                      ->orWhere('master_assessment_id', $assessmentId)
                      ->orWhere('old_assessment_id', $assessmentId);
            })
            ->get();
    }
} 