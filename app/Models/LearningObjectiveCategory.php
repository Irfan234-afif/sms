<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class LearningObjectiveCategory extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'school_curriculum_id',
        'parent_id',
        'title',
        'code',
        'options',
    ];

    protected $casts = [
        'options' => 'json',
    ];

    public function parent()
    {
        return $this->belongsTo(LearningObjectiveCategory::class, 'parent_id');
    }

    public function objectives()
    {
        return $this->hasMany(LearningObjective::class, 'category_id');
    }
}
