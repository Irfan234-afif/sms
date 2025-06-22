<?php

namespace Database\Factories\TrainingProgram;

use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\Profile;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TrainingProgram\TrainingProgramActivityParticipant>
 */
class TrainingProgramActivityParticipantFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = TrainingProgramActivityParticipant::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'activity_id' => TrainingProgramActivity::factory(),
            'profile_id' => Profile::factory(),
            'enrollment_date' => fake()->dateTimeBetween('-1 month', 'now'),
            'overall_progress' => 0,
            'certificate_issued' => false,
            'certificate_number' => null,
        ];
    }
} 