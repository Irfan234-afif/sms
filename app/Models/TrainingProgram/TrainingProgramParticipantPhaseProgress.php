<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramParticipantPhaseProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'training_program_participant_phase_progress';

    protected $fillable = [
        'participant_id',
        'phase_id',
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
     * Get the phase associated with this progress.
     */
    public function phase(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramPhase::class, 'phase_id');
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
        $totalModules = $this->phase->modules()->count();
        
        if ($totalModules === 0) {
            return;
        }

        $completedModules = $this->participant->moduleProgress()
            ->whereHas('module', function ($query) {
                $query->where('phase_id', $this->phase_id);
            })
            ->where('status', 'COMPLETED')
            ->count();

        $progress = ($completedModules / $totalModules) * 100;
        
        $this->update(['progress_percentage' => $progress]);

        // Mark as completed if all modules are done
        if ($progress >= 100 && !$this->completed_at) {
            $this->markAsCompleted();
        }
    }
}