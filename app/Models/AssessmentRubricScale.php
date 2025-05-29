<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentRubricScale extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'rubric_id',
        'score',
        'predicate',
        'narrative',
    ];
}
