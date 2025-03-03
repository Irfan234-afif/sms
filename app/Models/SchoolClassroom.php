<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolClassroom extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_id',
        'school_grade_id',
        'school_major_id',
        'homeroom_teacher_id',
        'title',
        'capacity',
    ];

    public function grade()
    {
        return $this->belongsTo(SchoolGrade::class, 'school_grade_id');
    }

    public function major()
    {
        return $this->belongsTo(SchoolMajor::class, 'school_major_id');
    }

    public function homeroom_teacher()
    {
        return $this->belongsTo(Employee::class, 'homeroom_teacher_id');
    }
}
