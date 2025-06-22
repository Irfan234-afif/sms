<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityModule extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_modules';

    protected $fillable = [
        'activity_phase_id',
        'master_module_id',
        'name',
        'description',
        'order',
        'status',
    ];

    /**
     * Get the activity phase that owns this module.
     */
    public function activityPhase(): BelongsTo
    {
        return $this->belongsTo(ActivityPhase::class, 'activity_phase_id');
    }

    /**
     * Get the master module (for reference).
     */
    public function masterModule(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'master_module_id');
    }

    /**
     * Get the materials for this activity module.
     */
    public function materials(): HasMany
    {
        return $this->hasMany(ActivityMaterial::class, 'activity_module_id')->orderBy('order');
    }

    /**
     * Get the quizzes for this activity module.
     */
    public function quizzes(): HasMany
    {
        return $this->hasMany(ActivityQuiz::class, 'activity_module_id')->orderBy('order');
    }

    /**
     * Get the assessments for this activity module.
     */
    public function assessments(): HasMany
    {
        return $this->hasMany(ActivityAssessment::class, 'activity_module_id');
    }

    /**
     * Get the participant progress for this module.
     */
    public function participantProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramParticipantModuleProgress::class, 'activity_module_id');
    }
} 