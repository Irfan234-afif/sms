<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentSessionRubric extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'session_id',
        'rubric_id',
        'deleted_at'
    ];

    public function rubric()
    {
        return $this->belongsTo(AssessmentRubric::class, 'rubric_id');
    }
}
