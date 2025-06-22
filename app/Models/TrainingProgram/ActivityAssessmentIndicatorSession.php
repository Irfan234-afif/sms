<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityAssessmentIndicatorSession extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_assessment_indicator_sessions';

    protected $fillable = [
        'activity_indicator_id',
        'master_session_id',
        'name',
        'description',
        'order',
    ];

    protected $casts = [
        'order' => 'integer',
    ];

    /**
     * Get the activity indicator that owns this session.
     */
    public function activityIndicator(): BelongsTo
    {
        return $this->belongsTo(ActivityAssessmentIndicator::class, 'activity_indicator_id');
    }

    /**
     * Get the master session (for reference).
     */
    public function masterSession(): BelongsTo
    {
        return $this->belongsTo(AssessmentIndicatorSession::class, 'master_session_id');
    }

    /**
     * Get the rubrics for this activity session.
     */
    public function rubrics(): HasMany
    {
        return $this->hasMany(ActivityAssessmentRubric::class, 'activity_session_id')->orderBy('order');
    }
}