<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramParticipantModuleProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'tp_participant_module_progress';

    protected $fillable = [
        'participant_id',
        'activity_module_id',
        'master_module_id',
        'old_module_id',
        'started_at',
        'completed_at',
        'status',
        'progress_percentage',
    ];

    protected $casts = [
        'started_at' => 'datetime',
        'completed_at' => 'datetime',
        'progress_percentage' => 'decimal:2',
    ];

    /**
     * Get the participant associated with this progress.
     */
    public function participant(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivityParticipant::class, 'participant_id');
    }

    /**
     * Get the activity module associated with this progress.
     */
    public function activityModule(): BelongsTo
    {
        return $this->belongsTo(ActivityModule::class, 'activity_module_id');
    }

    /**
     * Get the master module (for reference).
     */
    public function masterModule(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'master_module_id');
    }

    /**
     * Legacy module relationship (for migration compatibility).
     */
    public function module(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'old_module_id');
    }

    /**
     * Mark module as started.
     */
    public function markAsStarted(): void
    {
        if ($this->status === 'NOT_STARTED') {
            $this->update([
                'started_at' => now(),
                'status' => 'IN_PROGRESS',
            ]);
        }
    }

    /**
     * Mark module as completed.
     */
    public function markAsCompleted(): void
    {
        $this->update([
            'completed_at' => now(),
            'status' => 'COMPLETED',
            'progress_percentage' => 100,
        ]);
    }

    /**
     * Check if module is completed.
     */
    public function isCompleted(): bool
    {
        return $this->status === 'COMPLETED';
    }

    /**
     * Check if module is in progress.
     */
    public function isInProgress(): bool
    {
        return $this->status === 'IN_PROGRESS';
    }

    /**
     * Check if module is not started.
     */
    public function isNotStarted(): bool
    {
        return $this->status === 'NOT_STARTED';
    }

    /**
     * Calculate progress based on material, quiz, and assessment completion.
     */
    public function calculateProgress(): void
    {
        $activityModule = $this->activityModule;
        $totalProgress = 0;
        $totalWeight = 0;

        if (!$activityModule) {
            $this->calculateProgressFromLegacyModule();
            return;
        }

        // Materials progress
        $totalMaterials = $activityModule->materials()->count();
        if ($totalMaterials > 0) {
            $completedMaterials = $this->participant->materialProgress()
                ->where('activity_material_id', '!=', null)
                ->whereHas('activityMaterial', function ($query) use ($activityModule) {
                    $query->where('activity_module_id', $activityModule->id);
                })
                ->whereNotNull('completed_at')
                ->count();

            $materialProgress = ($completedMaterials / $totalMaterials) * 100;
            $totalProgress += $materialProgress * 0.7;
            $totalWeight += 0.7;
        }

        // Quizzes progress
        $totalQuizzes = $activityModule->quizzes()->count();
        if ($totalQuizzes > 0) {
            $completedQuizzes = $this->participant->quizAttempts()
                ->where('activity_quiz_id', '!=', null)
                ->whereHas('activityQuiz', function ($query) use ($activityModule) {
                    $query->where('activity_module_id', $activityModule->id);
                })
                ->whereNotNull('completed_at')
                ->distinct('activity_quiz_id')
                ->count('activity_quiz_id');

            $quizProgress = ($completedQuizzes / $totalQuizzes) * 100;
            $totalProgress += $quizProgress * 0.2;
            $totalWeight += 0.2;
        }

        // Assessments progress
        $totalAssessments = $activityModule->assessments()->count();
        if ($totalAssessments > 0) {
            $completedAssessments = $this->participant->assessmentResults()
                ->where('activity_assessment_id', '!=', null)
                ->whereHas('activityAssessment', function ($query) use ($activityModule) {
                    $query->where('activity_module_id', $activityModule->id);
                })
                ->count();

            $assessmentProgress = ($completedAssessments / $totalAssessments) * 100;
            $totalProgress += $assessmentProgress * 0.1;
            $totalWeight += 0.1;
        }

        $progress = 0;
        if ($totalWeight > 0) {
            $progress = $totalProgress / $totalWeight;
        } elseif ($totalMaterials === 0 && $totalQuizzes === 0 && $totalAssessments === 0) {
            // If no components, module is 100% complete.
            $progress = 100;
        }

        $progress = min($progress, 100);
        
        // Save the progress
        $this->progress_percentage = $progress;

        // Update status based on progress
        if ($this->progress_percentage >= 100) {
            if ($this->status !== 'COMPLETED') {
                $this->completed_at = now();
                $this->status = 'COMPLETED';
            }
        } elseif ($this->progress_percentage > 0 && $this->status === 'NOT_STARTED') {
            $this->started_at = $this->started_at ?? now();
            $this->status = 'IN_PROGRESS';
        }

        // Save all changes and check if progress was updated
        if ($this->isDirty()) {
            $progressChanged = $this->isDirty('progress_percentage');
            $this->save();
            
            if ($progressChanged) {
                $this->updatePhaseProgress();
            }
        }
    }

    /**
     * Calculate progress using legacy module data (fallback).
     */
    private function calculateProgressFromLegacyModule(): void
    {
        if (!$this->old_module_id) {
            return;
        }

        $module = \App\Models\TrainingProgram\PhaseModule::find($this->old_module_id);
        if (!$module) {
            return;
        }

        $totalProgress = 0;
        $componentCount = 0;

        // Materials progress
        $totalMaterials = $module->materials()->count();
        if ($totalMaterials > 0) {
            $completedMaterials = $this->participant->materialProgress()
                ->where('old_material_id', '!=', null)
                ->whereHas('legacyMaterial', function ($query) use ($module) {
                    $query->where('module_id', $module->id);
                })
                ->whereNotNull('completed_at')
                ->count();
            
            $materialProgress = ($completedMaterials / $totalMaterials) * 100;
            $totalProgress += $materialProgress * 0.7;
            $componentCount++;
        }

        // Calculate final progress
        $progress = $componentCount > 0 ? ($totalProgress / ($componentCount * 0.7)) : 0;
        $progress = min($progress, 100);
        
        $this->update(['progress_percentage' => $progress]);

        // Update status
        if ($progress >= 100 && $this->status !== 'COMPLETED') {
            $this->markAsCompleted();
        } elseif ($progress > 0 && $this->status === 'NOT_STARTED') {
            $this->markAsStarted();
        }
    }

    /**
     * Update phase progress after module completion.
     */
    private function updatePhaseProgress(): void
    {
        $activityModule = $this->activityModule;
        
        if (!$activityModule) {
            // Fallback: try to find phase progress using old_module_id
            if ($this->old_module_id) {
                $module = \App\Models\TrainingProgram\PhaseModule::find($this->old_module_id);
                if ($module && $module->training_program_phase_id) {
                    $phaseProgress = $this->participant->phaseProgress()
                        ->where('old_phase_id', $module->training_program_phase_id)
                        ->first();

                    if ($phaseProgress) {
                        $phaseProgress->calculateProgress();
                    }
                }
            }
            return;
        }

        // Try to find phase progress using activity_phase_id first
        $phaseProgress = null;
        
        if ($activityModule->activity_phase_id) {
            $phaseProgress = $this->participant->phaseProgress()
                ->where('activity_phase_id', $activityModule->activity_phase_id)
                ->first();
        }

        // Fallback: try using master_phase_id if activity_phase_id doesn't work
        if (!$phaseProgress && $activityModule->activityPhase && $activityModule->activityPhase->master_phase_id) {
            $phaseProgress = $this->participant->phaseProgress()
                ->where('master_phase_id', $activityModule->activityPhase->master_phase_id)
                ->first();
        }

        // Final fallback: try using old_phase_id through module relationship
        if (!$phaseProgress && $this->old_module_id) {
            $module = \App\Models\TrainingProgram\PhaseModule::find($this->old_module_id);
            if ($module && $module->training_program_phase_id) {
                $phaseProgress = $this->participant->phaseProgress()
                    ->where('old_phase_id', $module->training_program_phase_id)
                    ->first();
            }
        }

        if ($phaseProgress) {
            $phaseProgress->calculateProgress();
        }
    }
}