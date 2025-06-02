<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentRuleNarrative extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'final_rule_id',
        'aspect_id',
    ];

    public function aspect()
    {
        return $this->belongsTo(AssessmentAspect::class)->withTrashed();
    }
}
