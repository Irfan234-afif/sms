<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class LearningRubric extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_curriculum_id',
        'title',
        'code',
    ];
}
