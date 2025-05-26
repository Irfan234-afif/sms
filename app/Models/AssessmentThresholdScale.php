<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentThresholdScale extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'threshold_id',
        'type',
        'score',
        'predicate',
        'narrative',
    ];
}
