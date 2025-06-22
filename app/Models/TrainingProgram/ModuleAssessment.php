<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ModuleAssessment extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'phase_module_id',
        'title',
        'description',
        'calculation_method',
        'passing_score',
        'status',
        'order',
    ];

    protected $casts = [
        'passing_score' => 'integer',
        'order' => 'integer',
    ];

    public function module(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'phase_module_id');
    }

    public function groupIndicators(): HasMany
    {
        return $this->hasMany(AssessmentGroupIndicator::class);
    }

    /**
     * Calculate final score based on session scores and calculation method.
     */
    public function calculateFinalScore(array $sessionScores): float
    {
        if (empty($sessionScores)) {
            return 0;
        }

        $scores = array_values($sessionScores);
        
        switch ($this->calculation_method) {
            case 'SUM':
                return array_sum($scores);
            case 'AVERAGE':
            default:
                return array_sum($scores) / count($scores);
        }
    }

    /**
     * Check if a score passes the assessment.
     */
    public function isPassing(float $score): bool
    {
        return $score >= $this->passing_score;
    }
}
