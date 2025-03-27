<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubResignationItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_resignation_id',
        'title',
        'description',
        'checker_id',
    ];
}
