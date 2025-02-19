<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TransactionItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'transaction_id',
        'product_id',
        'price',
        'quantity',
        'total_amount',
        'bill_amount',
        'options',
    ];

    protected $casts = [
        'options' => 'json'
    ];
}
