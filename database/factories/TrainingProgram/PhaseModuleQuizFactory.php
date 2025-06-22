<?php

namespace Database\Factories\TrainingProgram;

use App\Models\TrainingProgram\PhaseModuleQuiz;
use App\Models\TrainingProgram\PhaseModule;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TrainingProgram\PhaseModuleQuiz>
 */
class PhaseModuleQuizFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = PhaseModuleQuiz::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'phase_module_id' => 1, // Simple integer instead of factory
            'title' => fake()->sentence(),
            'description' => fake()->paragraph(),
            'passing_score' => 70,
            'status' => 'active',
        ];
    }
} 