<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEquipmentItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_equipment_id',
        'name',
        'quantity',
        'due_date',
        'description',
        'status',
    ];
}
