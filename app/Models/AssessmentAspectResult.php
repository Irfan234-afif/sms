<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentAspectResult extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'assessment_student_id',
        'aspect_id',
        'raw_score',
        'final_score',
        'final_predicate',
        'final_narrative',
    ];

    public function aspect()
    {
        return $this->belongsTo(AssessmentAspect::class, 'aspect_id');
    }

    public function sessions()
    {
        return $this->hasMany(AssessmentAspectSession::class, 'aspect_result_id');
    }
}
