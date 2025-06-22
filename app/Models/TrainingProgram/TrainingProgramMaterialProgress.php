<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramMaterialProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'tp_material_progress';

    protected $fillable = [
        'participant_id',
        'activity_material_id',
        'master_material_id',
        'old_material_id',
        'viewed_at',
        'completed_at',
        'time_spent',
    ];

    protected $casts = [
        'viewed_at' => 'datetime',
        'completed_at' => 'datetime',
        'time_spent' => 'integer',
    ];

    /**
     * Get the participant associated with this progress.
     */
    public function participant(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivityParticipant::class, 'participant_id');
    }

    /**
     * Get the activity material associated with this progress.
     */
    public function activityMaterial(): BelongsTo
    {
        return $this->belongsTo(ActivityMaterial::class, 'activity_material_id');
    }

    /**
     * Get the master material (for reference).
     */
    public function masterMaterial(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleMaterial::class, 'master_material_id');
    }

    /**
     * Legacy material relationship (for migration compatibility).
     */
    public function material(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleMaterial::class, 'old_material_id');
    }

    /**
     * Legacy material relationship alias (for fallback queries).
     */
    public function legacyMaterial(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleMaterial::class, 'old_material_id');
    }

    /**
     * Mark material as viewed.
     */
    public function markAsViewed(): void
    {
        if (!$this->viewed_at) {
            $this->update(['viewed_at' => now()]);
        }
    }

    /**
     * Mark material as completed.
     */
    public function markAsCompleted(): void
    {
        $this->update([
            'completed_at' => now(),
        ]);

        // Update module progress after material completion
        $this->updateModuleProgress();
    }

    /**
     * Check if material is completed.
     */
    public function isCompleted(): bool
    {
        return $this->completed_at !== null;
    }

    /**
     * Check if material has been viewed.
     */
    public function isViewed(): bool
    {
        return $this->viewed_at !== null;
    }

    /**
     * Add time spent on material.
     */
    public function addTimeSpent(int $seconds): void
    {
        $this->increment('time_spent', $seconds);
    }

    /**
     * Get formatted time spent.
     */
    public function getFormattedTimeSpent(): string
    {
        $hours = floor($this->time_spent / 3600);
        $minutes = floor(($this->time_spent % 3600) / 60);
        $seconds = $this->time_spent % 60;

        if ($hours > 0) {
            return sprintf('%d jam %d menit', $hours, $minutes);
        } elseif ($minutes > 0) {
            return sprintf('%d menit %d detik', $minutes, $seconds);
        } else {
            return sprintf('%d detik', $seconds);
        }
    }

    /**
     * Update module progress after material completion.
     */
    private function updateModuleProgress(): void
    {
        $activityMaterial = $this->activityMaterial;
        
        if (!$activityMaterial) {
            return;
        }

        $moduleProgress = $this->participant->moduleProgress()
            ->where('activity_module_id', $activityMaterial->activity_module_id)
            ->first();

        if ($moduleProgress) {
            $moduleProgress->calculateProgress();
        }
    }
}