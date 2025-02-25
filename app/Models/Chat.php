<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;

class Chat extends Model
{
    use GenerateUuid;

    public function model()
    {
        return $this->morphTo();
    }
}
