<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubEquipment extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $table = 'sub_equipments';

    protected $fillable = [
        'submission_id',
        'description',
    ];

    public function items()
    {
        return $this->hasMany(SubEquipmentItem::class, 'sub_equipment_id');
    }
}
