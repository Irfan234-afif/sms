<?php

namespace App\Models\TrainingProgram;

use App\Models\Profile;
use App\Models\Submission;
use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class TrainingProgramActivity extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'title',
        'description',
        'training_program_id',
        'submission_id',
        'start_date',
        'end_date',
        'status',
        'location',
        'external_provider',
        'created_by',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    /**
     * Get the training program associated with the activity.
     */
    public function trainingProgram(): BelongsTo
    {
        return $this->belongsTo(TrainingProgram::class);
    }

    /**
     * Get the submission associated with the activity.
     */
    public function submission(): BelongsTo
    {
        return $this->belongsTo(Submission::class);
    }

    /**
     * Get the creator of the activity.
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(Profile::class, 'created_by');
    }

    /**
     * Get the participants of the activity.
     */
    public function participants(): HasMany
    {
        return $this->hasMany(TrainingProgramActivityParticipant::class, 'activity_id');
    }

    /**
     * Get the activity training program (snapshot).
     */
    public function activityTrainingProgram(): HasOne
    {
        return $this->hasOne(ActivityTrainingProgram::class, 'activity_id');
    }

    /**
     * Check if activity is ongoing.
     */
    public function isOngoing(): bool
    {
        return $this->status === 'ONGOING';
    }

    /**
     * Check if activity is completed.
     */
    public function isCompleted(): bool
    {
        return $this->status === 'COMPLETED';
    }

    /**
     * Check if activity is planned.
     */
    public function isPlanned(): bool
    {
        return $this->status === 'PLANNED';
    }

    /**
     * Update status based on dates.
     */
    public function updateStatusBasedOnDates(): void
    {
        $today = now()->startOfDay();
        
        if ($this->start_date->isPast() && $this->end_date->isFuture()) {
            $this->update(['status' => 'ONGOING']);
        } elseif ($this->end_date->isPast()) {
            $this->update(['status' => 'COMPLETED']);
        }
    }
}