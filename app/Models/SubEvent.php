<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEvent extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'title',
        'place',
        'start_datetime',
        'end_datetime',
        'description',
        'bill_amount',
    ];

    public function submission()
    {
        return $this->belongsTo(Submission::class, 'submission_id');
    }

    public function items()
    {
        return $this->hasMany(SubEventItem::class, 'sub_event_id');
    }

    public function objectives()
    {
        return $this->hasMany(SubEventObjective::class, 'sub_event_id');
    }

    public function participants()
    {
        return $this->hasMany(SubEventParticipant::class, 'sub_event_id');
    }

    public function transportations()
    {
        return $this->hasMany(SubEventTransportation::class, 'sub_event_id');
    }
}
