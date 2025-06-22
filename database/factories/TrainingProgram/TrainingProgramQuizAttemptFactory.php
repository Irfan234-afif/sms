<?php

namespace Database\Factories\TrainingProgram;

use App\Models\TrainingProgram\TrainingProgramQuizAttempt;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\PhaseModuleQuiz;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TrainingProgram\TrainingProgramQuizAttempt>
 */
class TrainingProgramQuizAttemptFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = TrainingProgramQuizAttempt::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'participant_id' => TrainingProgramActivityParticipant::factory(),
            'old_quiz_id' => PhaseModuleQuiz::factory(),
            'master_quiz_id' => PhaseModuleQuiz::factory(),
            'attempt_number' => 1,
            'started_at' => now(),
            'submitted_at' => null,
            'score' => null,
            'passed' => false,
            'answers' => json_encode([]),
        ];
    }

    /**
     * Indicate that the quiz attempt is completed.
     */
    public function completed(): static
    {
        return $this->state(fn (array $attributes) => [
            'submitted_at' => now(),
            'score' => fake()->numberBetween(60, 100),
            'passed' => true,
            'answers' => json_encode([
                ['question_id' => 1, 'answer' => 'A'],
                ['question_id' => 2, 'answer' => 'B'],
            ]),
        ]);
    }
} 