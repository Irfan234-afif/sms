<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentFinalRule extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'module_id',
        'name',
        'sort_order',
        'use_score',
        'score_method',
        'use_predicate',
        'predicate_method',
        'use_narrative',
        'narrative_method',
    ];

    public function module()
    {
        return $this->belongsTo(AssessmentModule::class, 'module_id');
    }

    public function scores()
    {
        return $this->hasMany(AssessmentRuleScore::class, 'final_rule_id');
    }

    public function narratives()
    {
        return $this->hasMany(AssessmentRuleNarrative::class, 'final_rule_id');
    }
}
