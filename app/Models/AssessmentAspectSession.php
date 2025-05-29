<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentAspectSession extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'aspect_result_id',
        'session_id',
        'rubric_scale_id',
        'raw_score',
        'final_score',
        'final_predicate',
        'final_narrative',
    ];

    public function session()
    {
        return $this->belongsTo(AssessmentSession::class, 'session_id');
    }

    public function rubric_scale()
    {
        return $this->belongsTo(AssessmentRubricScale::class, 'rubric_scale_id');
    }
}
