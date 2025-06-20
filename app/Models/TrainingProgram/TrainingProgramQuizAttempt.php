<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramQuizAttempt extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'participant_id',
        'quiz_id',
        'attempt_number',
        'score',
        'passed',
        'started_at',
        'completed_at',
        'answers',
    ];

    protected $casts = [
        'attempt_number' => 'integer',
        'score' => 'decimal:2',
        'passed' => 'boolean',
        'started_at' => 'datetime',
        'completed_at' => 'datetime',
        'answers' => 'array',
    ];

    /**
     * Get the participant associated with this attempt.
     */
    public function participant(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramActivityParticipant::class, 'participant_id');
    }

    /**
     * Get the quiz associated with this attempt.
     */
    public function quiz(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuiz::class, 'quiz_id');
    }

    /**
     * Mark attempt as completed with score.
     */
    public function completeAttempt(array $answers): void
    {
        $score = $this->calculateScore($answers);
        $passed = $score >= $this->quiz->passing_score;

        $this->update([
            'completed_at' => now(),
            'answers' => $answers,
            'score' => $score,
            'passed' => $passed,
        ]);

        // Update module progress after quiz completion
        $this->updateModuleProgress();
    }

    /**
     * Calculate score based on answers.
     */
    private function calculateScore(array $answers): float
    {
        $totalQuestions = $this->quiz->questions()->count();
        
        if ($totalQuestions === 0) {
            return 0;
        }

        $correctAnswers = 0;

        foreach ($answers as $questionId => $answerId) {
            $question = $this->quiz->questions()->find($questionId);
            
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
    public static function getNextAttemptNumber(int $participantId, int $quizId): int
    {
        $lastAttempt = self::where('participant_id', $participantId)
            ->where('quiz_id', $quizId)
            ->orderBy('attempt_number', 'desc')
            ->first();

        return $lastAttempt ? $lastAttempt->attempt_number + 1 : 1;
    }

    /**
     * Check if participant has passed this quiz.
     */
    public static function hasPassedQuiz(int $participantId, int $quizId): bool
    {
        return self::where('participant_id', $participantId)
            ->where('quiz_id', $quizId)
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
        $moduleProgress = $this->participant->moduleProgress()
            ->whereHas('module', function ($query) {
                $query->whereHas('quizzes', function ($q) {
                    $q->where('id', $this->quiz_id);
                });
            })
            ->first();

        if ($moduleProgress) {
            $moduleProgress->calculateProgress();
        }
    }
}