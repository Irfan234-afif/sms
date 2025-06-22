<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityAssessment extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_assessments';

    protected $fillable = [
        'activity_module_id',
        'master_assessment_id',
        'title',
        'description',
        'calculation_method',
        'passing_score',
    ];

    /**
     * Get the activity module that owns this assessment.
     */
    public function activityModule(): BelongsTo
    {
        return $this->belongsTo(ActivityModule::class, 'activity_module_id');
    }

    /**
     * Get the master assessment (for reference).
     */
    public function masterAssessment(): BelongsTo
    {
        return $this->belongsTo(ModuleAssessment::class, 'master_assessment_id');
    }

    /**
     * Get the group indicators for this activity assessment.
     */
    public function groupIndicators(): HasMany
    {
        return $this->hasMany(ActivityAssessmentGroupIndicator::class, 'activity_assessment_id')->orderBy('order');
    }

    /**
     * Get the assessment results for this activity assessment.
     */
    public function assessmentResults(): HasMany
    {
        return $this->hasMany(TrainingProgramAssessmentResult::class, 'activity_assessment_id');
    }
} 