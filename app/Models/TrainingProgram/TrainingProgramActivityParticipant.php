<?php

namespace App\Models\TrainingProgram;

use App\Models\Profile;
use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TrainingProgramActivityParticipant extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'activity_id',
        'profile_id',
        'enrollment_date',
        'completion_date',
        'overall_progress',
        'certificate_issued',
        'certificate_number',
    ];

    protected $casts = [
        'enrollment_date' => 'date',
        'completion_date' => 'date',
        'overall_progress' => 'decimal:2',
        'certificate_issued' => 'boolean',
    ];

    /**
     * Get the activity associated with the participant.
     */
    public function activity(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivity::class, 'activity_id');
    }

    /**
     * Get the profile (user) associated with the participant.
     */
    public function profile(): BelongsTo
    {
        return $this->belongsTo(Profile::class);
    }

    /**
     * Get the phase progress for this participant.
     */
    public function phaseProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramParticipantPhaseProgress::class, 'participant_id');
    }

    /**
     * Get the module progress for this participant.
     */
    public function moduleProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramParticipantModuleProgress::class, 'participant_id');
    }

    /**
     * Get the material progress for this participant.
     */
    public function materialProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramMaterialProgress::class, 'participant_id');
    }

    /**
     * Get the quiz attempts for this participant.
     */
    public function quizAttempts(): HasMany
    {
        return $this->hasMany(TrainingProgramQuizAttempt::class, 'participant_id');
    }

    /**
     * Get the assessment results for this participant.
     */
    public function assessmentResults(): HasMany
    {
        return $this->hasMany(TrainingProgramAssessmentResult::class, 'participant_id');
    }

    /**
     * Calculate and update overall progress.
     */
    public function calculateOverallProgress(): void
    {
        $trainingProgram = $this->activity->trainingProgram;
        
        if (!$trainingProgram) {
            return;
        }

        $totalPhases = $trainingProgram->phases()->count();
        
        if ($totalPhases === 0) {
            return;
        }

        $completedPhases = $this->phaseProgress()
            ->whereNotNull('completed_at')
            ->count();

        $progress = ($completedPhases / $totalPhases) * 100;
        
        $this->update(['overall_progress' => $progress]);

        // Mark as completed if 100%
        if ($progress >= 100 && !$this->completion_date) {
            $this->update(['completion_date' => now()]);
        }
    }

    /**
     * Issue certificate for the participant.
     */
    public function issueCertificate(): void
    {
        if ($this->overall_progress >= 100 && !$this->certificate_issued) {
            $certificateNumber = 'CERT-' . strtoupper(uniqid());
            
            $this->update([
                'certificate_issued' => true,
                'certificate_number' => $certificateNumber,
            ]);
        }
    }

    /**
     * Check if participant has completed the activity.
     */
    public function hasCompleted(): bool
    {
        return $this->overall_progress >= 100;
    }

    /**
     * Get progress for a specific phase.
     */
    public function getPhaseProgress($phaseId)
    {
        return $this->phaseProgress()
            ->where('phase_id', $phaseId)
            ->first();
    }

    /**
     * Get progress for a specific module.
     */
    public function getModuleProgress($moduleId)
    {
        return $this->moduleProgress()
            ->where('module_id', $moduleId)
            ->first();
    }
}