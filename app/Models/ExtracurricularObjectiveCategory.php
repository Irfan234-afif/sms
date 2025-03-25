<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExtracurricularObjectiveCategory extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'extracurricular_id',
        'parent_id',
        'title',
        'code',
    ];
}
