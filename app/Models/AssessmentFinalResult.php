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
        'score',
        'predicate',
        'narrative',
    ];

    public function final_rule()
    {
        return $this->belongsTo(AssessmentFinalRule::class, 'final_rule_id');
    }
}
