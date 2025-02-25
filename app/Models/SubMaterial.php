<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubMaterial extends Model
{
    use GenerateUuid, SoftDeletes;

    public function items()
    {
        return $this->hasMany(SubMaterialItem::class, 'sub_material_id');
    }
}
