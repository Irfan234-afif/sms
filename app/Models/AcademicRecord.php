<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AcademicRecord extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'profile_id',
        'title',
        'institution',
        'attachment',
        'graduation_date'
    ];
}
