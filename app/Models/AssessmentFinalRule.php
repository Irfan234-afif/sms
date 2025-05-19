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
        'sort_number',
        'use_score',
        'score_type',
        'use_predicate',
        'predicate_type',
        'use_narrative',
        'narrative_type',
    ];

    public function scores()
    {
        return $this->hasMany(AssessmentRuleScore::class, 'final_rule_id');
    }

    public function narratives()
    {
        return $this->hasMany(AssessmentRuleNarrative::class, 'final_rule_id');
    }
}
