<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubDocumentation extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'title',
        'place',
        'start_date',
        'end_date',
        'description',
    ];
}
