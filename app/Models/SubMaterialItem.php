<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubMaterialItem extends Model
{
    use GenerateUuid, SoftDeletes;

    public function chats()
    {
        return $this->morphMany(Chat::class, 'model');
    }
}
