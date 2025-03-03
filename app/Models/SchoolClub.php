<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolClub extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_id',
        'mentor_id',
        'title',
    ];

    public function mentor()
    {
        return $this->belongsTo(Employee::class, 'mentor_id');
    }
}
