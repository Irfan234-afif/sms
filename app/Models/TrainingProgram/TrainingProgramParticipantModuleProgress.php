<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramParticipantModuleProgress extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'training_program_participant_module_progress';

    protected $fillable = [
        'participant_id',
        'module_id',
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
     * Get the module associated with this progress.
     */
    public function module(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'module_id');
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
        $module = $this->module;
        $totalComponents = 0;
        $completedComponents = 0;

        // Count materials
        $totalMaterials = $module->materials()->count();
        if ($totalMaterials > 0) {
            $completedMaterials = $this->participant->materialProgress()
                ->whereHas('material', function ($query) use ($module) {
                    $query->where('module_id', $module->id);
                })
                ->whereNotNull('completed_at')
                ->count();
            
            $totalComponents++;
            if ($completedMaterials === $totalMaterials) {
                $completedComponents++;
            }
        }

        // Count quizzes
        $totalQuizzes = $module->quizzes()->count();
        if ($totalQuizzes > 0) {
            $passedQuizzes = $this->participant->quizAttempts()
                ->whereHas('quiz', function ($query) use ($module) {
                    $query->where('module_id', $module->id);
                })
                ->where('passed', true)
                ->distinct('quiz_id')
                ->count('quiz_id');
            
            $totalComponents++;
            if ($passedQuizzes === $totalQuizzes) {
                $completedComponents++;
            }
        }

        // Count assessments
        $totalAssessments = $module->assessments()->count();
        if ($totalAssessments > 0) {
            $completedAssessments = $this->participant->assessmentResults()
                ->whereHas('assessment', function ($query) use ($module) {
                    $query->where('module_id', $module->id);
                })
                ->count();
            
            $totalComponents++;
            if ($completedAssessments === $totalAssessments) {
                $completedComponents++;
            }
        }

        if ($totalComponents === 0) {
            return;
        }

        $progress = ($completedComponents / $totalComponents) * 100;
        
        $this->update(['progress_percentage' => $progress]);

        // Update status based on progress
        if ($progress >= 100 && $this->status !== 'COMPLETED') {
            $this->markAsCompleted();
        } elseif ($progress > 0 && $this->status === 'NOT_STARTED') {
            $this->markAsStarted();
        }
    }
}