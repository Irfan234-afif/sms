<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Transaction extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'customer_id',
        'type',
        'sub_type',
        'reference_number',
        'due_date',
        'total_amount',
        'discount_amount',
        'bill_amount',
        'paid_amount',
    ];


    public function customer()
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function payments()
    {
        return $this->hasMany(TransactionPayment::class, 'transaction_id');
    }

    public function items()
    {
        return $this->hasMany(TransactionItem::class, 'transaction_id');
    }
}
