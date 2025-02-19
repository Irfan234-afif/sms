<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TransactionPayment extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'transaction_id',
        'reference_number',
        'type',
        'amount',
        'options',
        'status',
    ];

    protected $casts = [
        'options' => 'json',
    ];

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }
}
