<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolLevel extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'title',
        'code',
        'sort_number'
    ];

    public function phases()
    {
        return $this->hasMany(SchoolPhase::class, 'school_level_id');
    }

    public function grades()
    {
        return $this->hasMany(SchoolGrade::class, 'school_level_id');
    }
}
