<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Student extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'profile_id',
        'school_id',
        'school_grade_id',
        'school_national_id',
    ];

    public function profile()
    {
        return $this->belongsTo(Profile::class, 'profile_id');
    }

    public function school()
    {
        return $this->belongsTo(School::class, 'school_id');
    }

    public function school_grade()
    {
        return $this->belongsTo(SchoolGrade::class, 'school_grade_id');
    }
}
