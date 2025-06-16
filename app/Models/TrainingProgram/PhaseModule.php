<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PhaseModule extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_phase_id',
        'name',
        'description',
        'order',
        'status',
    ];

    public function phase(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramPhase::class);
    }

    public function materials(): HasMany
    {
        return $this->hasMany(PhaseModuleMaterial::class);
    }

    public function quizzes(): HasMany
    {
        return $this->hasMany(PhaseModuleQuiz::class);
    }

    public function assessments(): HasMany
    {
        return $this->hasMany(ModuleAssessment::class);
    }
}
