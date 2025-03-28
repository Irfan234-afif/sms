<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEventItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_event_id',
        'name',
        'quantity',
        'unit',
        'price',
        'bill_amount',
        'description',
    ];

    public function event()
    {
        return $this->belongsTo(SubEvent::class, 'sub_event_id');
    }
}
