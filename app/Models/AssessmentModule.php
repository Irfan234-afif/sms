<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentModule extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'school_curriculum_id',
        'name',
        'description',
    ];

    public function aspects()
    {
        return $this->hasMany(AssessmentAspect::class, 'module_id');
    }

    public function rubrics()
    {
        return $this->hasMany(AssessmentRubric::class, 'module_id');
    }

    public function final_rules()
    {
        return $this->hasMany(AssessmentFinalRule::class, 'module_id');
    }
}
