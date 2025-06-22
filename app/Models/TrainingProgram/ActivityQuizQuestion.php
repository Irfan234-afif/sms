<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityQuizQuestion extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_quiz_questions';

    protected $fillable = [
        'activity_quiz_id',
        'master_question_id',
        'question_text',
        'type',
        'points',
        'order',
        'explanation',
        'correct_answer',
        'status',
    ];

    protected $casts = [
        'order' => 'integer',
        'points' => 'integer',
    ];

    /**
     * Get the activity quiz that owns this question.
     */
    public function activityQuiz(): BelongsTo
    {
        return $this->belongsTo(ActivityQuiz::class, 'activity_quiz_id');
    }

    /**
     * Get the master question (for reference).
     */
    public function masterQuestion(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuizQuestion::class, 'master_question_id');
    }

    /**
     * Get the options for this activity quiz question.
     */
    public function options(): HasMany
    {
        return $this->hasMany(ActivityQuizQuestionOption::class, 'activity_quiz_question_id')->orderBy('order');
    }
} 