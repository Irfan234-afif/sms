<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Attachment extends Model
{
    use GenerateUuid, SoftDeletes;
    //
    protected $fillable = [
        'model_id',
        'model_type',
        'title',
        'type',
        'file_name',
    ];
}
