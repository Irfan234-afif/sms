<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramMaterialProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'training_program_material_progress';

    protected $fillable = [
        'participant_id',
        'material_id',
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
     * Get the material associated with this progress.
     */
    public function material(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleMaterial::class, 'material_id');
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
        $moduleProgress = $this->participant->moduleProgress()
            ->where('module_id', $this->material->module_id)
            ->first();

        if ($moduleProgress) {
            $moduleProgress->calculateProgress();
        }
    }
}