<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Discount extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'name',
        'code',
        'type',
        'description',
        'value',
        'starts_at',
        'ends_at',
        'quota',
        'used_quota',
        'is_active',
    ];
}
