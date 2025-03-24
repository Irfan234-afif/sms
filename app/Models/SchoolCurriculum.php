<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolCurriculum extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $table = 'school_curriculums';

    protected $fillable = [
        'school_id',
        'title',
        'code',
    ];
}
