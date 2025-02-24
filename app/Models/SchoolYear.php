<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolYear extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'name',
        'start_year',
        'end_year',
        'is_active',
    ];

    public function admission_student_quotas()
    {
        return $this->hasMany(AdmissionStudentQuota::class, 'school_year_id', 'school_year_id');
    }
}
