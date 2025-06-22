<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityQuiz extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_quizzes';

    protected $fillable = [
        'activity_module_id',
        'master_quiz_id',
        'title',
        'description',
        'passing_score',
        'max_attempts',
        'show_results',
        'order',
        'status',
    ];

    protected $casts = [
        'passing_score' => 'decimal:2',
        'max_attempts' => 'integer',
        'show_results' => 'boolean',
        'order' => 'integer',
    ];

    /**
     * Get the activity module that owns this quiz.
     */
    public function activityModule(): BelongsTo
    {
        return $this->belongsTo(ActivityModule::class, 'activity_module_id');
    }

    /**
     * Get the master quiz (for reference).
     */
    public function masterQuiz(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuiz::class, 'master_quiz_id');
    }

    /**
     * Get the questions for this activity quiz.
     */
    public function questions(): HasMany
    {
        return $this->hasMany(ActivityQuizQuestion::class, 'activity_quiz_id')->orderBy('order');
    }

    /**
     * Get the quiz attempts for this activity quiz.
     */
    public function quizAttempts(): HasMany
    {
        return $this->hasMany(TrainingProgramQuizAttempt::class, 'activity_quiz_id');
    }
} 