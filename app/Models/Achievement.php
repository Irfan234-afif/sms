<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Achievement extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'title',
        'slug',
        'description',
        'category',
        'status',
    ];
}