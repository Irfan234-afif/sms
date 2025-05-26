<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentStudent extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'record_id',
        'student_id',
    ];

    public function student()
    {
        return $this->belongsTo(Student::class);
    }

    public function sessions()
    {
        return $this->hasMany(AssessmentAspectSession::class, 'assessment_student_id', 'id');
    }

    public function final_results()
    {
        return $this->hasMany(AssessmentFinalResult::class, 'assessment_student_id', 'id');
    }
}
