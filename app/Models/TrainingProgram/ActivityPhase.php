<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityPhase extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_phases';

    protected $fillable = [
        'activity_training_program_id',
        'master_phase_id',
        'name',
        'description',
        'order',
        'status',
    ];

    /**
     * Get the activity training program that owns this phase.
     */
    public function activityTrainingProgram(): BelongsTo
    {
        return $this->belongsTo(ActivityTrainingProgram::class, 'activity_training_program_id');
    }

    /**
     * Get the master phase (for reference).
     */
    public function masterPhase(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramPhase::class, 'master_phase_id');
    }

    /**
     * Get the modules for this activity phase.
     */
    public function modules(): HasMany
    {
        return $this->hasMany(ActivityModule::class, 'activity_phase_id')->orderBy('order');
    }

    /**
     * Get the participant progress for this phase.
     */
    public function participantProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramParticipantPhaseProgress::class, 'activity_phase_id');
    }
} 