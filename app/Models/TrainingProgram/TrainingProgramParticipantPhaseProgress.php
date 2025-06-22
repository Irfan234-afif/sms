<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramParticipantPhaseProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'tp_participant_phase_progress';

    protected $fillable = [
        'participant_id',
        'activity_phase_id',
        'master_phase_id',
        'old_phase_id',
        'started_at',
        'completed_at',
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
     * Get the activity phase associated with this progress.
     */
    public function activityPhase(): BelongsTo
    {
        return $this->belongsTo(ActivityPhase::class, 'activity_phase_id');
    }

    /**
     * Get the master phase (for reference).
     */
    public function masterPhase(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramPhase::class, 'master_phase_id');
    }

    /**
     * Legacy phase relationship (for migration compatibility).
     */
    public function phase(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramPhase::class, 'old_phase_id');
    }

    /**
     * Mark phase as started.
     */
    public function markAsStarted(): void
    {
        if (!$this->started_at) {
            $this->update(['started_at' => now()]);
        }
    }

    /**
     * Mark phase as completed.
     */
    public function markAsCompleted(): void
    {
        $this->update([
            'completed_at' => now(),
            'progress_percentage' => 100,
        ]);
    }

    /**
     * Check if phase is completed.
     */
    public function isCompleted(): bool
    {
        return $this->completed_at !== null;
    }

    /**
     * Calculate progress based on module completion.
     */
    public function calculateProgress(): void
    {
        $totalModules = 0;
        $moduleProgressData = collect();
        
        // Try to get modules count and progress using activity_phase_id first
        if ($this->activity_phase_id) {
            $activityPhase = $this->activityPhase;
            if ($activityPhase) {
                $totalModules = $activityPhase->modules()->count();
                
                $moduleProgressData = $this->participant->moduleProgress()
                    ->where('activity_module_id', '!=', null)
                    ->whereHas('activityModule', function ($query) {
                        $query->where('activity_phase_id', $this->activity_phase_id);
                    })
                    ->get();
            }
        }
        
        // Fallback: try using master_phase_id
        if ($totalModules === 0 && $this->master_phase_id) {
            $masterPhase = $this->masterPhase;
            if ($masterPhase) {
                $totalModules = $masterPhase->modules()->count();
                
                $moduleProgressData = $this->participant->moduleProgress()
                    ->where('master_module_id', '!=', null)
                    ->whereHas('masterModule', function ($query) {
                        $query->where('training_program_phase_id', $this->master_phase_id);
                    })
                    ->get();
            }
        }
        
        // Final fallback: try using old_phase_id
        if ($totalModules === 0 && $this->old_phase_id) {
            $oldPhase = $this->phase;
            if ($oldPhase) {
                $totalModules = $oldPhase->modules()->count();
                
                $moduleProgressData = $this->participant->moduleProgress()
                    ->where('old_module_id', '!=', null)
                    ->whereHas('module', function ($query) {
                        $query->where('training_program_phase_id', $this->old_phase_id);
                    })
                    ->get();
            }
        }
        
        if ($totalModules === 0) {
            return;
        }

        if ($moduleProgressData->isEmpty()) {
            return;
        }

        // Calculate average progress across all modules
        $totalProgress = $moduleProgressData->sum('progress_percentage');
        $progress = $totalProgress / $totalModules;
        
        $this->progress_percentage = $progress;

        // Mark as completed if all modules are done
        if ($this->progress_percentage >= 100 && !$this->completed_at) {
            $this->completed_at = now();
        } elseif ($this->progress_percentage > 0 && !$this->started_at) {
            $this->started_at = $this->started_at ?? now();
        }

        if($this->isDirty()) {
            $progressChanged = $this->isDirty('progress_percentage');
            $this->save();

            if ($progressChanged) {
                $this->participant->calculateOverallProgress();
            }
        }
    }
}