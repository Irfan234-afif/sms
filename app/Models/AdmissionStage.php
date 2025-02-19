<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdmissionStage extends Model
{
    use GenerateUuid, SoftDeletes;

    public function model()
    {
        return $this->morphTo();
    }

    public function statuses()
    {
        return $this->hasMany(AdmissionStageStatus::class, 'admission_stage_id');
    }
}
