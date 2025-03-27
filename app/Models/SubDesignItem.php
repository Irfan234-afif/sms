<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubDesignItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'sub_design_id',
        'title',
        'due_date',
        'description',
        'attachment',
    ];
}
