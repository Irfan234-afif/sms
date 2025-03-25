<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class School extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_level_id',
        'headmaster_id',
        'use_major',
        'use_subject',
    ];

    public function area()
    {
        return $this->morphOne(Area::class, 'model');
    }

    public function academic_program_active()
    {
        return $this->hasOne(SchoolAcademicProgram::class, 'school_id')->where('is_active', true);
    }

    public function academic_programs()
    {
        return $this->hasMany(SchoolAcademicProgram::class, 'school_id');
    }

    public function level()
    {
        return $this->belongsTo(SchoolLevel::class, 'school_level_id');
    }

    public function grades()
    {
        return $this->hasMany(SchoolGrade::class, 'school_level_id', 'school_level_id');
    }

    public function majors()
    {
        return $this->hasMany(SchoolMajor::class, 'school_id');
    }

    public function subject_groups()
    {
        return $this->hasMany(SchoolSubjectGroup::class, 'school_id');
    }

    public function subjects()
    {
        return $this->hasMany(SchoolSubject::class, 'school_id');
    }

    public function classrooms()
    {
        return $this->hasMany(SchoolClassroom::class, 'school_id');
    }

    public function extracurriculars()
    {
        return $this->hasMany(SchoolExtracurricular::class, 'school_id');
    }

    public function clubs()
    {
        return $this->hasMany(SchoolClub::class, 'school_id');
    }

    public function admission_stages()
    {
        return $this->morphMany(AdmissionStage::class, 'model');
    }

    public function admission_student_quotas()
    {
        return $this->hasMany(AdmissionStudentQuota::class, 'school_id', 'school_id');
    }
}
