<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEventObjective extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_event_id',
        'title',
        'description',
        'remark',
    ];
}
