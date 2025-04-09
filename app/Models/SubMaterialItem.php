<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubMaterialItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_material_id',
        'name',
        'reference_number',
        'quantity',
        'unit',
        'purchase_reference',
        'price',
        'bill_amount',
        'due_date',
        'description',
        'attachment',
        'status',
    ];
}
