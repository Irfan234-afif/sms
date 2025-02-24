<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdmissionStage extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'model_type',
        'model_id',
        'type',
        'title',
        'sort_number',
    ];

    public function model()
    {
        return $this->morphTo();
    }

    public function statuses()
    {
        return $this->hasMany(AdmissionStageStatus::class, 'admission_stage_id');
    }
}
