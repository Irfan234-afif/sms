<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityAssessmentGroupIndicator extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_assessment_group_indicators';

    protected $fillable = [
        'activity_assessment_id',
        'master_group_indicator_id',
        'name',
        'description',
        'order',
    ];

    protected $casts = [
        'order' => 'integer',
    ];

    /**
     * Get the activity assessment that owns this group indicator.
     */
    public function activityAssessment(): BelongsTo
    {
        return $this->belongsTo(ActivityAssessment::class, 'activity_assessment_id');
    }

    /**
     * Get the master group indicator (for reference).
     */
    public function masterGroupIndicator(): BelongsTo
    {
        return $this->belongsTo(AssessmentGroupIndicator::class, 'master_group_indicator_id');
    }

    /**
     * Get the indicators for this activity group indicator.
     */
    public function indicators(): HasMany
    {
        return $this->hasMany(ActivityAssessmentIndicator::class, 'activity_group_indicator_id')->orderBy('order');
    }
} 