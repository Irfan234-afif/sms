<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'name',
        'code',
        'type',
        'price',
    ];
}
