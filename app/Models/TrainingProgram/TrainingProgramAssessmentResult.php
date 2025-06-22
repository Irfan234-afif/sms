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

    protected $table = 'tp_assessment_results';

    protected $fillable = [
        'participant_id',
        'activity_assessment_id',
        'master_assessment_id',
        'old_assessment_id',
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
     * Get the activity assessment associated with this result.
     */
    public function activityAssessment(): BelongsTo
    {
        return $this->belongsTo(ActivityAssessment::class, 'activity_assessment_id');
    }

    /**
     * Get the master assessment (for reference).
     */
    public function masterAssessment(): BelongsTo
    {
        return $this->belongsTo(ModuleAssessment::class, 'master_assessment_id');
    }

    /**
     * Legacy assessment relationship (for migration compatibility).
     * This should now point to ActivityAssessment for proper snapshot support
     */
    public function assessment(): BelongsTo
    {
        // Prioritize activity assessment over master assessment
        if ($this->activity_assessment_id) {
            return $this->belongsTo(ActivityAssessment::class, 'activity_assessment_id');
        }
        
        // Fallback to master assessment for legacy data
        return $this->belongsTo(ModuleAssessment::class, 'old_assessment_id');
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
     * Check if participant passed the assessment.
     */
    public function isPassed(): bool
    {
        $passingScore = $this->activityAssessment->passing_score ?? 
                       $this->masterAssessment->passing_score ?? 
                       70;
        
        return $this->final_score >= $passingScore;
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
        if ($this->final_score >= 90) return 'A';
        if ($this->final_score >= 80) return 'B';
        if ($this->final_score >= 70) return 'C';
        if ($this->final_score >= 60) return 'D';
        
        return 'E';
    }

    /**
     * Get valid scores by filtering out invalid session/rubric references.
     * This helps handle cases where master data has changed.
     */
    public function getValidScores(): array
    {
        $scores = $this->scores ?? [];
        $validScores = [];
        
        foreach ($scores as $sessionId => $rubricId) {
            // Check if the rubric still exists and belongs to the correct session
            $rubric = \App\Models\TrainingProgram\ActivityAssessmentRubric::where('id', $rubricId)
                ->where('activity_session_id', $sessionId)
                ->first();
            
            if ($rubric) {
                $validScores[$sessionId] = $rubricId;
            }
        }
        
        return $validScores;
    }

    /**
     * Recalculate and update final score based on current valid scores.
     */
    public function recalculateFinalScore(): void
    {
        $validScores = $this->getValidScores();
        $sessionScores = [];
        
        foreach ($validScores as $sessionId => $rubricId) {
            $rubric = \App\Models\TrainingProgram\ActivityAssessmentRubric::find($rubricId);
            if ($rubric) {
                $sessionScores[$sessionId] = floatval($rubric->score);
            }
        }
        
        $finalScore = 0;
        if (!empty($sessionScores)) {
            $calculationMethod = $this->activityAssessment->calculation_method ?? 'AVERAGE';
            
            switch ($calculationMethod) {
                case 'SUM':
                    $finalScore = array_sum($sessionScores);
                    break;
                case 'AVERAGE':
                default:
                    $finalScore = array_sum($sessionScores) / count($sessionScores);
                    break;
            }
        }
        
        $this->update([
            'scores' => $validScores,
            'final_score' => $finalScore
        ]);
    }

    /**
     * Update related module progress after assessment changes.
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