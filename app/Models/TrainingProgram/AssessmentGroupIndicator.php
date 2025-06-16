<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AssessmentGroupIndicator extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'module_assessment_id',
        'name',
        'description',
        'order',
    ];

    public function assessment(): BelongsTo
    {
        return $this->belongsTo(ModuleAssessment::class);
    }

    public function indicators(): HasMany
    {
        return $this->hasMany(AssessmentIndicator::class);
    }
}
