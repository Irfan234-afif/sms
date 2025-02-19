<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolPhase extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_level_id',
        'title',
        'sort_number'
    ];

    public function level()
    {
        return $this->belongsTo(SchoolLevel::class, 'school_level_id');
    }

    public function grades()
    {
        return $this->hasMany(SchoolGrade::class, 'school_phase_id');
    }
}
