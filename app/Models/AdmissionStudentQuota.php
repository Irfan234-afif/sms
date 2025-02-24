<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdmissionStudentQuota extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_id',
        'school_year_id',
        'school_grade_id',
        'max_quota',
        'used_quota',
    ];

    public function school_grade()
    {
        return $this->belongsTo(SchoolGrade::class, 'school_grade_id');
    }
}
