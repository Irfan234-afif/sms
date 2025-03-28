<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Experience extends Model
{
    use GenerateUuid, SoftDeletes;
    //
    protected $fillable = [
        'profile_id',
        'position',
        'institution',
        'reason_out',
        'start_date',
        'end_date'
    ];
}
