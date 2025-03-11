<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Event extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'title',
        'start_datetime',
        'end_datetime',
        'location',
        'content',
    ];
}
