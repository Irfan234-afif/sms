<?php

namespace App\Models\TrainingProgram;

use App\Models\Profile;
use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramAssessmentResult extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'participant_id',
        'assessment_id',
        'assessor_id',
        'scores',
        'final_score',
        'feedback',
        'assessed_at',
    ];

    protected $casts = [
        'scores' => 'array',
        'final_score' => 'decimal:2',
        'assessed_at' => 'datetime',
    ];

    /**
     * Get the participant associated with this result.
     */
    public function participant(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivityParticipant::class, 'participant_id');
    }

    /**
     * Get the assessment associated with this result.
     */
    public function assessment(): BelongsTo
    {
        return $this->belongsTo(ModuleAssessment::class, 'assessment_id');
    }

    /**
     * Get the assessor who gave this result.
     */
    public function assessor(): BelongsTo
    {
        return $this->belongsTo(Profile::class, 'assessor_id');
    }

    /**
     * Calculate final score from indicator scores.
     */
    public function calculateFinalScore(): void
    {
        if (empty($this->scores)) {
            return;
        }

        $totalScore = 0;
        $totalWeight = 0;

        foreach ($this->scores as $indicatorId => $score) {
            $indicator = AssessmentIndicator::find($indicatorId);
            
            if (!$indicator) {
                continue;
            }

            $totalScore += $score * ($indicator->weight ?? 1);
            $totalWeight += ($indicator->weight ?? 1);
        }

        if ($totalWeight > 0) {
            $finalScore = $totalScore / $totalWeight;
            $this->update(['final_score' => $finalScore]);
        }
    }

    /**
     * Check if assessment passed based on threshold.
     */
    public function isPassed(): bool
    {
        $threshold = $this->assessment->passing_score ?? 70;
        return $this->final_score >= $threshold;
    }

    /**
     * Get score for specific indicator.
     */
    public function getIndicatorScore($indicatorId): ?float
    {
        return $this->scores[$indicatorId] ?? null;
    }

    /**
     * Set score for specific indicator.
     */
    public function setIndicatorScore($indicatorId, float $score): void
    {
        $scores = $this->scores ?? [];
        $scores[$indicatorId] = $score;
        
        $this->update(['scores' => $scores]);
        $this->calculateFinalScore();
    }

    /**
     * Get grade based on final score.
     */
    public function getGrade(): string
    {
        if ($this->final_score >= 90) {
            return 'A';
        } elseif ($this->final_score >= 80) {
            return 'B';
        } elseif ($this->final_score >= 70) {
            return 'C';
        } elseif ($this->final_score >= 60) {
            return 'D';
        } else {
            return 'E';
        }
    }

    /**
     * Update module progress after assessment completion.
     */
    public function updateModuleProgress(): void
    {
        $moduleProgress = $this->participant->moduleProgress()
            ->whereHas('module', function ($query) {
                $query->whereHas('assessments', function ($q) {
                    $q->where('id', $this->assessment_id);
                });
            })
            ->first();

        if ($moduleProgress) {
            $moduleProgress->calculateProgress();
        }
    }
}