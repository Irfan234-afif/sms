<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentAspect extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'module_id',
        'name',
        'sort_order',
        'use_sessions',
        'use_final_score',
        'final_score_method',
        'use_learning_objective',
        'learning_objective_category_id',
    ];

    public function learning_objective_category()
    {
        return $this->belongsTo(LearningObjectiveCategory::class);
    }
}
