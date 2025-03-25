<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExtracurricularObjective extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'extracurricular_id',
        'category_id',
        'parent_id',
        'school_year_id',
        'title',
        'code',
        'narrative',
    ];
}
