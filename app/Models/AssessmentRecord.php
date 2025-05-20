<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentRecord extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'school_academic_program_id',
        'school_classroom_id',
        'school_subject_id',
        'module_id',
        'name',
    ];

    public function academic_program()
    {
        return $this->belongsTo(SchoolAcademicProgram::class, 'school_academic_program_id');
    }

    public function classroom()
    {
        return $this->belongsTo(SchoolClassroom::class, 'school_classroom_id');
    }

    public function subject()
    {
        return $this->belongsTo(SchoolSubject::class, 'school_subject_id');
    }

    public function module()
    {
        return $this->belongsTo(AssessmentModule::class, 'module_id');
    }

    public function sessions()
    {
        return $this->hasMany(AssessmentSession::class, 'record_id');
    }
}
