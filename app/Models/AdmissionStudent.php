<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdmissionStudent extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'transaction_id',
        'student_id',
        'school_id',
        'school_year_id',
        'school_grade_id',
        'registration_number',
        'submitted_at',
        'name',
        'avatar',
        'birth_place',
        'birth_date',
        'gender',
        'blood_type',
        'religion',
        'languages',
        'phone',
        'address',
        'postal_code',
        'previous_school',
        'father_name',
        'father_avatar',
        'father_birth_place',
        'father_birth_date',
        'father_religion',
        'father_languages',
        'father_phone',
        'father_email',
        'father_address',
        'father_occupation',
        'father_company',
        'father_position',
        'father_national_id',
        'mother_avatar',
        'mother_name',
        'mother_birth_place',
        'mother_birth_date',
        'mother_religion',
        'mother_languages',
        'mother_phone',
        'mother_email',
        'mother_address',
        'mother_occupation',
        'mother_company',
        'mother_position',
        'mother_national_id',
        'emergency_name',
        'emergency_phone',
        'emergency_home_phone',
        'emergency_relation',
        'need_vehicle',
        'responsible_fee',
        'payer_name',
        'payer_home_phone',
        'payer_phone',
        'payer_email',
        'payer_relation',
        'payer_address',
        'payer_company',
        'payer_company_letter',
        'health_info_remark',
        'health_relate_family',
        'use_insurance',
        'insurance_name',
        'insurance_network',
        'recomended_hospital',
        'doctor_name',
        'families',
        'questionnaires',
        'family_card_attachment',
        'father_id_card_attachment',
        'mother_id_card_attachment',
        'birth_certificate_attachment',
        'last_report_attachment',
        'previous_school_letter_attachment',
        'school_info_sources',
        'status',
    ];

    protected $casts = [
        'languages' => 'json',
        'father_languages' => 'json',
        'mother_languages' => 'json',
        'school_info_sources' => 'json',
        'families' => 'json',
        'questionnaires' => 'json',
    ];

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function school()
    {
        return $this->belongsTo(School::class, 'school_id');
    }

    public function school_year()
    {
        return $this->belongsTo(SchoolYear::class, 'school_year_id');
    }

    public function school_grade()
    {
        return $this->belongsTo(SchoolGrade::class, 'school_grade_id');
    }

    public function stages()
    {
        return $this->hasMany(AdmissionStudentStage::class, 'admission_student_id', 'id');
    }
}
