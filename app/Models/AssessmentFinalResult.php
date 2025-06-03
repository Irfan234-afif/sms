<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentFinalResult extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'assessment_student_id',
        'final_rule_id',
        'raw_score',
        'final_score',
        'threshold_scale_passed_id',
        'threshold_scale_failed_id',
        'learning_objective_passed_id',
        'learning_objective_failed_id',
        'predicate_passed',
        'predicate_failed',
        'final_predicate',
        'narrative_passed',
        'narrative_failed',
        'final_narrative',
    ];

    public function final_rule()
    {
        return $this->belongsTo(AssessmentFinalRule::class, 'final_rule_id');
    }

    public function threshold_scale_passed()
    {
        return $this->belongsTo(AssessmentThresholdScale::class, 'threshold_scale_passed_id');
    }

    public function threshold_scale_failed()
    {
        return $this->belongsTo(AssessmentThresholdScale::class, 'threshold_scale_failed_id');
    }

    public function learning_objective_passed()
    {
        return $this->belongsTo(LearningObjective::class, 'learning_objective_passed_id');
    }

    public function learning_objective_failed()
    {
        return $this->belongsTo(LearningObjective::class, 'learning_objective_failed_id');
    }
}
