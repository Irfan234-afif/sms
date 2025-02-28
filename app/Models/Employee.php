<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Employee extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'profile_id',
        'identity_number',
        'start_date',
        'end_date',
        'status',
    ];

    public function profile()
    {
        return $this->belongsTo(Profile::class, 'profile_id');
    }

    public function assignment()
    {
        return $this->hasOne(EmployeeAssignment::class, 'employee_id', 'id');
    }

    public function assignments()
    {
        return $this->hasMany(EmployeeAssignment::class, 'employee_id', 'id');
    }
}
