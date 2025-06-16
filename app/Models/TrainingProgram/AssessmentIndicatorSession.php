<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AssessmentIndicatorSession extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'assessment_indicator_id',
        'name',
        'description',
        'order',
    ];

    public function indicator(): BelongsTo
    {
        return $this->belongsTo(AssessmentIndicator::class);
    }

    public function rubrics(): HasMany
    {
        return $this->hasMany(AssessmentIndicatorSessionRubric::class);
    }
}
