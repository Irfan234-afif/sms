<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Position extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'area_id',
        'name',
    ];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }
}
