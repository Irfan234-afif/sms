<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Area extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'model_id',
        'model_type',
        'name',
        'phone',
        'email',
        'hotline',
        'address',
        'logo',
    ];

    public function model()
    {
        return $this->morphTo();
    }

    public function positions()
    {
        return $this->hasMany(Position::class, 'position_id');
    }
}
