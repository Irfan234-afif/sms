<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TransactionDiscount extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'transaction_id',
        'discount_id',
        'type',
        'value',
        'total_amount',
    ];
}
