<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolCurriculum extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $table = 'school_curriculums';

    protected $fillable = [
        'school_id',
        'title',
        'code',
    ];

    public function learning_objective_categories()
    {
        return $this->hasMany(LearningObjectiveCategory::class, 'school_curriculum_id');
    }


    public function learning_rubrics()
    {
        return $this->hasMany(LearningRubric::class, 'school_curriculum_id');
    }

    public function assessment_modules()
    {
        return $this->hasMany(AssessmentModule::class, 'school_curriculum_id');
    }
}
