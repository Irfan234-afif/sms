<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class DiscountUsage extends Model
{
    protected $fillable = [
        'area_id',
        'discount_id',
    ];
}
