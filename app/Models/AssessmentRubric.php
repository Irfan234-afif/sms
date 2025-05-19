<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AssessmentRubric extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'module_id',
        'name',
        'description',
    ];

    public function scales()
    {
        return $this->hasMany(AssessmentRubricScale::class, 'rubric_id');
    }
}
