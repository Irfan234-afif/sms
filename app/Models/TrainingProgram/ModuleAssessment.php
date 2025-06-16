<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ModuleAssessment extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'phase_module_id',
        'title',
        'description',
    ];

    public function module(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class);
    }

    public function groupIndicators(): HasMany
    {
        return $this->hasMany(AssessmentGroupIndicator::class);
    }
}
