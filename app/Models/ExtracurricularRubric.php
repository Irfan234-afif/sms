<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExtracurricularRubric extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'extracurricular_id',
        'title',
        'code',
    ];
}
