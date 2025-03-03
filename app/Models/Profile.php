<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Profile extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'national_id',
        'name',
        'birth_place',
        'birth_date',
        'gender',
        'blood_type',
        'religion',
        'marital_status',
        'phone',
        'email',
        'address',
        'postal_code',
        'avatar',
    ];

    public function user()
    {
        return $this->hasOne(User::class, 'profile_id');
    }

    public function employee()
    {
        return $this->hasOne(Employee::class, 'profile_id');
    }
}
