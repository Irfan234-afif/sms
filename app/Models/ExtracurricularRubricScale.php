<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExtracurricularRubricScale extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'rubric_id',
        'title',
        'value',
        'narrative',
    ];
}
