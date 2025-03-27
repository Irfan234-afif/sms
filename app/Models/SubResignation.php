<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubResignation extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'entry_date',
        'out_date',
    ];
}
