<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AssessmentIndicatorSessionRubric extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'assessment_indicator_session_id',
        'level',
        'score',
        'description',
        'order',
    ];

    public function assessmentIndicatorSession(): BelongsTo
    {
        return $this->belongsTo(AssessmentIndicatorSession::class);
    }
}
