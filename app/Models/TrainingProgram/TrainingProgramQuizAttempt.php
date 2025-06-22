<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramQuizAttempt extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'tp_quiz_attempts';

    protected $fillable = [
        'participant_id',
        'activity_quiz_id',
        'master_quiz_id',
        'old_quiz_id',
        'quiz_id',
        'attempt_number',
        'score',
        'passed',
        'started_at',
        'completed_at',
        'answers',
        'graded_at',
        'grader_id',
        'grader_feedback',
        'manual_scores',
    ];

    protected $casts = [
        'attempt_number' => 'integer',
        'score' => 'decimal:2',
        'passed' => 'boolean',
        'started_at' => 'datetime',
        'completed_at' => 'datetime',
        'graded_at' => 'datetime',
        'answers' => 'array',
        'manual_scores' => 'array',
    ];

    /**
     * Get the participant.
     */
    public function participant(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivityParticipant::class, 'participant_id');
    }

    /**
     * Get the activity quiz (snapshot).
     */
    public function activityQuiz(): BelongsTo
    {
        return $this->belongsTo(ActivityQuiz::class, 'activity_quiz_id');
    }

    /**
     * Get the master quiz (for reference).
     */
    public function masterQuiz(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuiz::class, 'master_quiz_id');
    }

    /**
     * Get the quiz.
     * Prioritize activity quiz over master quiz for proper snapshot support
     */
    public function quiz(): BelongsTo
    {
        // Prioritize activity quiz over master quiz
        if ($this->activity_quiz_id) {
            return $this->belongsTo(ActivityQuiz::class, 'activity_quiz_id');
        }
        
        // Fallback for legacy data
        return $this->belongsTo(PhaseModuleQuiz::class, 'old_quiz_id');
    }

    /**
     * Get the grader profile.
     */
    public function grader(): BelongsTo
    {
        return $this->belongsTo(\App\Models\Profile::class, 'grader_id');
    }

    /**
     * Mark attempt as completed and awaiting manual grading.
     */
    public function completeAttempt(array $answers): void
    {
        $this->update([
            'completed_at' => now(),
            'answers' => $answers,
            'score' => null, // Will be set during manual grading
            'passed' => false, // Will be set during manual grading
        ]);

        // Don't update module progress until manual grading is complete
        // Progress will be updated when grading is saved
    }

    /**
     * Calculate score based on answers.
     */
    private function calculateScore(array $answers): float
    {
        $activityQuiz = $this->activityQuiz;
        
        if (!$activityQuiz) {
            return 0;
        }

        $totalQuestions = $activityQuiz->questions()->count();
        
        if ($totalQuestions === 0) {
            return 0;
        }

        $correctAnswers = 0;

        foreach ($answers as $questionId => $answerId) {
            $question = $activityQuiz->questions()->find($questionId);
            
            if (!$question) {
                continue;
            }

            $correctOption = $question->options()->where('is_correct', true)->first();
            
            if ($correctOption && $correctOption->id == $answerId) {
                $correctAnswers++;
            }
        }

        return ($correctAnswers / $totalQuestions) * 100;
    }

    /**
     * Get the next attempt number for a participant and quiz.
     */
    public static function getNextAttemptNumber(int $participantId, int $activityQuizId): int
    {
        $lastAttempt = self::where('participant_id', $participantId)
            ->where('activity_quiz_id', $activityQuizId)
            ->orderBy('attempt_number', 'desc')
            ->first();

        return $lastAttempt ? $lastAttempt->attempt_number + 1 : 1;
    }

    /**
     * Check if participant has passed this quiz.
     */
    public static function hasPassedQuiz(int $participantId, int $activityQuizId): bool
    {
        return self::where('participant_id', $participantId)
            ->where('activity_quiz_id', $activityQuizId)
            ->where('passed', true)
            ->exists();
    }

    /**
     * Get formatted duration.
     */
    public function getFormattedDuration(): string
    {
        if (!$this->started_at || !$this->completed_at) {
            return '-';
        }

        $duration = $this->completed_at->diffInSeconds($this->started_at);
        
        $hours = floor($duration / 3600);
        $minutes = floor(($duration % 3600) / 60);
        $seconds = $duration % 60;

        if ($hours > 0) {
            return sprintf('%d jam %d menit', $hours, $minutes);
        } elseif ($minutes > 0) {
            return sprintf('%d menit %d detik', $minutes, $seconds);
        } else {
            return sprintf('%d detik', $seconds);
        }
    }

    /**
     * Update module progress after quiz completion.
     */
    private function updateModuleProgress(): void
    {
        $activityQuiz = $this->activityQuiz;
        
        if (!$activityQuiz) {
            return;
        }

        $moduleProgress = $this->participant->moduleProgress()
            ->where('activity_module_id', $activityQuiz->activity_module_id)
            ->first();

        if ($moduleProgress) {
            $moduleProgress->calculateProgress();
        }
    }
}