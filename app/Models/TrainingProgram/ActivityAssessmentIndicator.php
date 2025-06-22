<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityAssessmentIndicator extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_assessment_indicators';

    protected $fillable = [
        'activity_group_indicator_id',
        'master_indicator_id',
        'name',
        'description',
        'order',
    ];

    protected $casts = [
        'order' => 'integer',
    ];

    /**
     * Get the activity group indicator that owns this indicator.
     */
    public function activityGroupIndicator(): BelongsTo
    {
        return $this->belongsTo(ActivityAssessmentGroupIndicator::class, 'activity_group_indicator_id');
    }

    /**
     * Get the master indicator (for reference).
     */
    public function masterIndicator(): BelongsTo
    {
        return $this->belongsTo(AssessmentIndicator::class, 'master_indicator_id');
    }

    /**
     * Get the sessions for this activity indicator.
     */
    public function sessions(): HasMany
    {
        return $this->hasMany(ActivityAssessmentIndicatorSession::class, 'activity_indicator_id')->orderBy('order');
    }
} 