<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentThreshold extends Model
{
    use SoftDeletes, GenerateUuid;


    protected $fillable = [
        'module_id',
        'name',
        'description',
    ];

    public function module()
    {
        return $this->belongsTo(AssessmentModule::class, 'module_id');
    }

    public function scales()
    {
        return $this->hasMany(AssessmentThresholdScale::class, 'threshold_id');
    }
}
