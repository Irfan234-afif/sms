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

    public function level()
    {
        return $this->belongsTo(SchoolLevel::class, 'school_level_id');
    }

    public function grades()
    {
        return $this->hasMany(SchoolGrade::class, 'school_level_id', 'school_level_id');
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
