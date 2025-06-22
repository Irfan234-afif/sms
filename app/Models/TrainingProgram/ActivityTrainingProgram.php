<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityTrainingProgram extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_training_programs';

    protected $fillable = [
        'activity_id',
        'master_training_program_id',
        'name',
        'type',
        'level',
        'description',
        'status',
    ];

    /**
     * Get the activity that owns this snapshot.
     */
    public function activity(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivity::class, 'activity_id');
    }

    /**
     * Get the master training program (for reference).
     */
    public function masterTrainingProgram(): BelongsTo
    {
        return $this->belongsTo(TrainingProgram::class, 'master_training_program_id');
    }

    /**
     * Get the phases for this activity snapshot.
     */
    public function phases(): HasMany
    {
        return $this->hasMany(ActivityPhase::class, 'activity_training_program_id')->orderBy('order');
    }
} 