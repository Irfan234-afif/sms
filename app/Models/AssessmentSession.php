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
        'learning_objective_id',
        'name',
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

    public function learning_objective()
    {
        return $this->belongsTo(LearningObjective::class, 'learning_objective_id');
    }

    public function rubric()
    {
        return $this->belongsTo(AssessmentRubric::class, 'rubric_id');
    }
}
