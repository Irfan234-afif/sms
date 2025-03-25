<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class LearningObjective extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_curriculum_id',
        'category_id',
        'parent_id',
        'school_year_id',
        'school_phase_id',
        'school_grade_id',
        'school_subject_id',
        'title',
        'code',
        'narrative',
    ];

    public function parent()
    {
        return $this->belongsTo(LearningObjective::class, 'parent_id');
    }
}
