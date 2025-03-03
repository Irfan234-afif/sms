<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolExtracurricularMember extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_extracurricular_id',
        'student_id',
        'school_classroom_id',
    ];
}
