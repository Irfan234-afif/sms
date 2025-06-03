<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentSession extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'record_id',
        'aspect_id',
        'name',
        'description',
        'sort_order',
        'type',
        'rubric_id',
        'date',
        'portion_score',
    ];

    public function record()
    {
        return $this->belongsTo(AssessmentRecord::class, 'record_id');
    }

    public function aspect()
    {
        return $this->belongsTo(AssessmentAspect::class, 'aspect_id');
    }

    public function learning_objectives()
    {
        return $this->belongsToMany(LearningObjective::class, 'assessment_session_objectives', 'session_id', 'learning_objective_id')
            ->withPivot('uuid');
    }

    public function rubric()
    {
        return $this->belongsTo(AssessmentRubric::class, 'rubric_id',);
    }
}
