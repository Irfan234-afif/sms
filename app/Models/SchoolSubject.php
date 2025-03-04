<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolSubject extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_id',
        'school_subject_group_id',
        'title',
        'description',
    ];

    public function group()
    {
        return $this->belongsTo(SchoolSubjectGroup::class, 'school_subject_group_id');
    }
}
