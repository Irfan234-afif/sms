<?php

namespace Database\Factories\TrainingProgram;

use App\Models\TrainingProgram\TrainingProgram;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TrainingProgram\TrainingProgram>
 */
class TrainingProgramFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = TrainingProgram::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => fake()->sentence(3),
            'description' => fake()->paragraph(),
            'type' => fake()->randomElement(['course', 'workshop', 'certification']),
            'level' => fake()->randomElement(['beginner', 'intermediate', 'advanced']),
            'status' => 'ACTIVE',
        ];
    }
} 