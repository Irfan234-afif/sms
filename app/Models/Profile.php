<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Profile extends Model
{
    use HasFactory, GenerateUuid, SoftDeletes;

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

    public function families()
    {
        return $this->hasMany(Family::class, 'profile_id');
    }

    public function academic_records()
    {
        return $this->hasMany(AcademicRecord::class, 'profile_id');
    }

    public function training_records()
    {
        return $this->hasMany(TrainingRecord::class, 'profile_id');
    }

    public function specializations()
    {
        return $this->hasMany(Specialization::class, 'profile_id');
    }

    public function experiences()
    {
        return $this->hasMany(Experience::class, 'profile_id');
    }

    public function certifications()
    {
        return $this->hasMany(Certification::class, 'profile_id');
    }

    public function community_involvements()
    {
        return $this->hasMany(CommunityInvolvement::class, 'profile_id');
    }

    public function honor_prizes()
    {
        return $this->hasMany(HonorPrize::class, 'profile_id');
    }

    public function language_skills()
    {
        return $this->hasMany(LanguageSkill::class, 'profile_id');
    }

    public function attachments()
    {
        return $this->morphMany(Attachment::class, 'model');
    }
}
