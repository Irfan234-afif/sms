<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OperationalHour extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'operational_area_id',
        'day',
        'open_time',
        'closed_time',
    ];

    public function area()
    {
        return $this->belongsTo(OperationalArea::class, 'operational_area_id');
    }
}
