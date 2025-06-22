<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ActivityAssessmentRubric extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_assessment_rubrics';

    protected $fillable = [
        'activity_session_id',
        'master_rubric_id',
        'level',
        'description',
        'score',
        'order',
    ];

    protected $casts = [
        'score' => 'decimal:2',
        'order' => 'integer',
    ];

    /**
     * Get the activity session that owns this rubric.
     */
    public function activitySession(): BelongsTo
    {
        return $this->belongsTo(ActivityAssessmentIndicatorSession::class, 'activity_session_id');
    }

    /**
     * Get the master rubric (for reference).
     */
    public function masterRubric(): BelongsTo
    {
        return $this->belongsTo(AssessmentIndicatorSessionRubric::class, 'master_rubric_id');
    }
} 