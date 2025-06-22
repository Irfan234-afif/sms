<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramQuizAttemptResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // Determine which quiz to use based on available relationships
        $quiz = null;
        $quizData = null;

        // Priority: activityQuiz > masterQuiz > quiz (legacy)
        if ($this->relationLoaded('activityQuiz') && $this->activityQuiz) {
            $quiz = $this->activityQuiz;
            $quizData = [
                'id' => $quiz->id,
                'uuid' => $quiz->uuid,
                'title' => $quiz->title,
                'description' => $quiz->description,
                'passing_score' => (float) $quiz->passing_score,
                'max_attempts' => $quiz->max_attempts,
                'status' => $quiz->status,
                'source' => 'activity_snapshot',
                'questions' => $quiz->relationLoaded('questions') ? $quiz->questions->map(function ($question) {
                    return [
                        'id' => $question->id,
                        'question_text' => $question->question_text,
                        'question' => $question->question_text, // Alias for compatibility
                        'type' => $question->type,
                        'correct_answer' => $question->correct_answer,
                        'explanation' => $question->explanation,
                        'points' => $question->points,
                        'options' => $question->relationLoaded('options') ? $question->options->map(function ($option) {
                            return [
                                'id' => $option->id,
                                'option_text' => $option->option_text,
                                'text' => $option->option_text, // Alias for compatibility
                                'is_correct' => (bool) $option->is_correct,
                            ];
                        })->toArray() : [],
                    ];
                })->toArray() : []
            ];
        } elseif ($this->relationLoaded('masterQuiz') && $this->masterQuiz) {
            $quiz = $this->masterQuiz;
            $quizData = [
                'id' => $quiz->id,
                'uuid' => $quiz->uuid,
                'title' => $quiz->title,
                'description' => $quiz->description,
                'passing_score' => (float) $quiz->passing_score,
                'max_attempts' => $quiz->max_attempts,
                'status' => $quiz->status,
                'source' => 'master_data',
                'questions' => $quiz->relationLoaded('questions') ? $quiz->questions->map(function ($question) {
                    return [
                        'id' => $question->id,
                        'question_text' => $question->question_text,
                        'question' => $question->question_text, // Alias for compatibility
                        'type' => $question->type,
                        'correct_answer' => $question->correct_answer,
                        'explanation' => $question->explanation,
                        'points' => $question->points,
                        'options' => $question->relationLoaded('options') ? $question->options->map(function ($option) {
                            return [
                                'id' => $option->id,
                                'option_text' => $option->option_text,
                                'text' => $option->option_text, // Alias for compatibility
                                'is_correct' => (bool) $option->is_correct,
                            ];
                        })->toArray() : [],
                    ];
                })->toArray() : []
            ];
        } elseif ($this->relationLoaded('quiz') && $this->quiz) {
            $quiz = $this->quiz;
            $quizData = [
                'id' => $quiz->id,
                'uuid' => $quiz->uuid,
                'title' => $quiz->title,
                'description' => $quiz->description,
                'passing_score' => (float) $quiz->passing_score,
                'max_attempts' => $quiz->max_attempts,
                'status' => $quiz->status,
                'source' => 'legacy',
                'questions' => $quiz->relationLoaded('questions') ? $quiz->questions->map(function ($question) {
                    return [
                        'id' => $question->id,
                        'question_text' => $question->question_text,
                        'question' => $question->question_text, // Alias for compatibility
                        'type' => $question->type,
                        'correct_answer' => $question->correct_answer,
                        'explanation' => $question->explanation,
                        'points' => $question->points,
                        'options' => $question->relationLoaded('options') ? $question->options->map(function ($option) {
                            return [
                                'id' => $option->id,
                                'option_text' => $option->option_text,
                                'text' => $option->option_text, // Alias for compatibility
                                'is_correct' => (bool) $option->is_correct,
                            ];
                        })->toArray() : [],
                    ];
                })->toArray() : []
            ];
        } else {
            // Fallback if no relationships loaded
            $quizData = [
                'id' => $this->activity_quiz_id ?: $this->master_quiz_id ?: $this->old_quiz_id,
                'title' => 'Loading Quiz...',
                'description' => null,
                'passing_score' => 70.0,
                'max_attempts' => null,
                'status' => 'active',
                'source' => 'fallback',
                'questions' => []
            ];
        }

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'participant_id' => $this->participant_id,
            'activity_quiz_id' => $this->activity_quiz_id,
            'master_quiz_id' => $this->master_quiz_id,
            'old_quiz_id' => $this->old_quiz_id,
            'attempt_number' => $this->attempt_number,
            'score' => $this->score !== null ? (float) $this->score : null,
            'passed' => $this->passed,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'answers' => $this->answers,
            
            // Manual grading data
            'graded_at' => $this->graded_at?->format('Y-m-d H:i:s'),
            'grader_feedback' => $this->grader_feedback,
            'manual_scores' => $this->manual_scores,
            'grader' => $this->whenLoaded('grader', function () {
                return [
                    'id' => $this->grader->id,
                    'uuid' => $this->grader->uuid,
                    'name' => $this->grader->name,
                    'email' => $this->grader->email,
                ];
            }),
            
            // Quiz data with priority system
            'quiz' => $quizData,
            
            // Computed properties
            'is_completed' => $this->completed_at !== null,
            'is_in_progress' => $this->started_at !== null && $this->completed_at === null,
            'is_awaiting_grading' => $this->completed_at !== null && 
                                   ($this->score === null || $this->score === '') &&
                                   $this->graded_at === null,
            'formatted_duration' => method_exists($this, 'getFormattedDuration') ? $this->getFormattedDuration() : null,
        ];
    }
}