<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Family extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'profile_id',
        'name',
        'avatar',
        'relation',
        'national_id',
        'birth_place',
        'birth_date',
        'religion',
        'languages',
        'phone',
        'address',
        'education',
        'occupation',
    ];
}
