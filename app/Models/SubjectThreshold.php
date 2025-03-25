<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubjectThreshold extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_subject_id',
        'school_year_id',
        'school_grade_id',
        'minimum_value',
    ];

    public function scales()
    {
        return $this->hasMany(SubjectThresholdScale::class, 'threshold_id');
    }

    public function narratives()
    {
        return $this->hasMany(SubjectThresholdNarrative::class, 'threshold_id');
    }
}
