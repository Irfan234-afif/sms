<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class DiscountUsage extends Model
{
    use GenerateUuid;

    protected $fillable = [
        'area_id',
        'discount_id',
    ];
}
