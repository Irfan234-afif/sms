<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentSessionObjective extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'session_id',
        'learning_objective_id',
    ];
}
