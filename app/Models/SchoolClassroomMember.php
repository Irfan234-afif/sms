<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SchoolClassroomMember extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_classroom_id',
        'member_id',
    ];
}
