<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubLeave extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'start_date',
        'end_date',
        'description',
    ];
}
