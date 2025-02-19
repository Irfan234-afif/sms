<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class StudentGuardian extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'student_id',
        'guardian_id'
    ];
}
