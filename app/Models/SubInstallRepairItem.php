<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubInstallRepairItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
       'sub_install_repair_id',
       'name',
       'quantity',
       'unit',
       'due_date',
       'description',
       'status',
    ];
}
