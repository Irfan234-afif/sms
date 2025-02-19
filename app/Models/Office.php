<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Office extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'name',
    ];

    public function area()
    {
        return $this->morphOne(Area::class, 'model');
    }
}
