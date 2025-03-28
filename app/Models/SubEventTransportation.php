<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEventTransportation extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_event_id',
        'type',
        'quantity',
        'unit_cost',
    ];

    public function event()
    {
        return $this->belongsTo(SubEvent::class, 'sub_event_id');
    }
}
