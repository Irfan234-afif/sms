<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentAspectSessionRubric extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'aspect_session_id',
        'session_rubric_id',
        'rubric_scale_id',
        'score',
        'predicate',
        'narrative',
    ];

    public function session_rubric()
    {
        return $this->belongsTo(AssessmentSessionRubric::class, 'session_rubric_id');
    }

    public function rubric_scale()
    {
        return $this->belongsTo(AssessmentRubricScale::class, 'rubric_scale_id');
    }
}
