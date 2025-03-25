<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolAcademicProgram extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_id',
        'school_year_id',
        'school_curriculum_id',
        'name',
        'is_active',
    ];

    public function school()
    {
        return $this->belongsTo(School::class, 'school_id');
    }

    public function year()
    {
        return $this->belongsTo(SchoolYear::class, 'school_year_id');
    }

    public function curriculum()
    {
        return $this->belongsTo(SchoolCurriculum::class, 'school_curriculum_id');
    }
}
