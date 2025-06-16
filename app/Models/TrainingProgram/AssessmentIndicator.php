<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AssessmentIndicator extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'assessment_group_indicator_id',
        'name',
        'description',
        'order',
    ];

    public function groupIndicator(): BelongsTo
    {
        return $this->belongsTo(AssessmentGroupIndicator::class);
    }

    public function sessions(): HasMany
    {
        return $this->hasMany(AssessmentIndicatorSession::class);
    }
}
