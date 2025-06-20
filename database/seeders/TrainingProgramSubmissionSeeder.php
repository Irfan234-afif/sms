<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\SubmissionGroup;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramSubmission;
use App\Models\TrainingProgram\TrainingProgramSubmissionGoal;
use App\Models\TrainingProgram\TrainingProgramSubmissionBudgetItem;
use App\Models\TrainingProgram\TrainingProgramSubmissionParticipant;
use App\Models\Employee;
use App\Models\Profile;
use App\Models\Area;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TrainingProgramSubmissionSeeder extends Seeder
{
    public function run()
    {
        DB::transaction(function () {
            // Create submission group for training program
            $submissionGroup = SubmissionGroup::firstOrCreate([
                'code' => 'TRAINING_PROGRAM'
            ], [
                'name' => 'Training Program Submission',
                'reference_code' => 'TRP',
                'reference_number' => 1,
            ]);

            $this->command->info('Created submission group: ' . $submissionGroup->name);

            // Get sample data
            $employees = Employee::whereHas('profile.user')->with('profile', 'assignments.area')->limit(5)->get();
            $profiles = Profile::whereHas('user')->limit(10)->get();
            $trainingPrograms = TrainingProgram::where('status', 'active')->limit(3)->get();
            
            if ($employees->isEmpty() || $profiles->isEmpty()) {
                $this->command->warn('No employees or profiles found. Skipping sample submissions.');
                return;
            }

            // Create sample submissions
            foreach ($employees->take(3) as $index => $employee) {
                $area = $employee->assignments()->first()?->area;
                
                if (!$area) {
                    continue;
                }

                // Internal training submission
                if ($trainingPrograms->isNotEmpty() && $index < 2) {
                    $this->createInternalTrainingSubmission(
                        $submissionGroup,
                        $employee,
                        $area,
                        $trainingPrograms->random(),
                        $profiles->random(rand(2, 4))
                    );
                }

                // External training submission
                if ($index >= 1) {
                    $this->createExternalTrainingSubmission(
                        $submissionGroup,
                        $employee,
                        $area,
                        $profiles->random(rand(1, 3))
                    );
                }
            }

            $this->command->info('Created sample training program submissions');
        });
    }

    private function createInternalTrainingSubmission(
        SubmissionGroup $submissionGroup,
        Employee $employee,
        Area $area,
        TrainingProgram $trainingProgram,
        $participants
    ) {
        $referenceNumber = sprintf(
            "SUB/%s/%011d",
            $submissionGroup->reference_code,
            $submissionGroup->reference_number
        );

        $submission = TrainingProgramSubmission::create([
            'submitter_id' => $employee->id,
            'reference_number' => $referenceNumber,
            'training_type' => 'internal',
            'training_program_id' => $trainingProgram->id,
            'start_date' => now()->addDays(30),
            'end_date' => now()->addDays(35),
            'daily_start_time' => '08:00',
            'daily_end_time' => '17:00',
            'training_days' => ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
            'justification' => 'Pengembangan kompetensi karyawan sesuai dengan program internal yang tersedia.',
            'expected_outcomes' => 'Meningkatkan kemampuan dan keterampilan peserta sesuai dengan kurikulum training program.',
            'datetime' => now(),
            'status' => collect(['draft', 'submitted', 'approved'])->random(),
        ]);

        $submissionGroup->increment('reference_number');

        // Add goals
        $this->createSampleGoals($submission);

        // Add budget items
        $this->createSampleBudgetItems($submission, 'internal');

        // Add participants
        $this->createSampleParticipants($submission, $participants);

        $this->command->info("Created internal training submission: {$submission->reference_number}");
    }

    private function createExternalTrainingSubmission(
        SubmissionGroup $submissionGroup,
        Employee $employee,
        Area $area,
        $participants
    ) {
        $referenceNumber = sprintf(
            "SUB/%s/%011d",
            $submissionGroup->reference_code,
            $submissionGroup->reference_number
        );

        $submission = TrainingProgramSubmission::create([
            'submitter_id' => $employee->id,
            'reference_number' => $referenceNumber,
            'training_type' => 'external',
            'external_training_title' => 'Digital Marketing Certification Program',
            'external_training_provider' => 'PT. Digital Academy Indonesia',
            'external_training_description' => 'Program sertifikasi digital marketing yang mencakup SEO, SEM, Social Media Marketing, dan Analytics.',
            'external_training_location' => 'Jakarta Convention Center',
            'external_training_method' => 'hybrid',
            'start_date' => now()->addDays(45),
            'end_date' => now()->addDays(47),
            'daily_start_time' => '09:00',
            'daily_end_time' => '16:00',
            'training_days' => ['monday', 'tuesday', 'wednesday'],
            'justification' => 'Mengikuti perkembangan tren digital marketing terbaru dan mendapatkan sertifikasi profesional.',
            'expected_outcomes' => 'Peserta memperoleh sertifikasi digital marketing dan dapat mengimplementasikan strategi pemasaran digital.',
            'datetime' => now(),
            'status' => collect(['draft', 'submitted'])->random(),
        ]);

        $submissionGroup->increment('reference_number');

        // Add goals
        $this->createSampleGoals($submission, 'external');

        // Add budget items
        $this->createSampleBudgetItems($submission, 'external');

        // Add participants
        $this->createSampleParticipants($submission, $participants);

        $this->command->info("Created external training submission: {$submission->reference_number}");
    }

    private function createSampleGoals(TrainingProgramSubmission $submission, string $type = 'internal')
    {
        $goals = $type === 'internal' ? [
            [
                'goal_type' => 'knowledge',
                'description' => 'Memahami konsep dan teori dasar yang diajarkan dalam program training',
                'success_indicator' => 'Peserta dapat menjelaskan konsep utama dengan benar',
                'order' => 1,
            ],
            [
                'goal_type' => 'skill',
                'description' => 'Menguasai keterampilan praktis sesuai materi training',
                'success_indicator' => 'Peserta dapat melakukan praktik dengan tingkat akurasi minimal 80%',
                'order' => 2,
            ],
            [
                'goal_type' => 'attitude',
                'description' => 'Mengembangkan sikap profesional dalam menerapkan ilmu yang didapat',
                'success_indicator' => 'Peserta menunjukkan perubahan perilaku positif di tempat kerja',
                'order' => 3,
            ],
        ] : [
            [
                'goal_type' => 'knowledge',
                'description' => 'Memahami strategi digital marketing terkini dan best practices',
                'success_indicator' => 'Peserta dapat mengidentifikasi berbagai channel digital marketing',
                'order' => 1,
            ],
            [
                'goal_type' => 'skill',
                'description' => 'Mampu membuat dan mengelola campaign digital marketing',
                'success_indicator' => 'Peserta dapat membuat campaign dengan ROI yang terukur',
                'order' => 2,
            ],
        ];

        foreach ($goals as $goalData) {
            $goal = new TrainingProgramSubmissionGoal([
                'training_program_submission_id' => $submission->id,
                ...$goalData,
            ]);
            $goal->save();
        }
    }

    private function createSampleBudgetItems(TrainingProgramSubmission $submission, string $type = 'internal')
    {
        $budgetItems = $type === 'internal' ? [
            [
                'category' => 'venue',
                'item_name' => 'Sewa Ruang Training',
                'description' => 'Sewa ruang training untuk 5 hari',
                'quantity' => 5,
                'unit_price' => 500000,
            ],
            [
                'category' => 'material',
                'item_name' => 'Modul dan ATK',
                'description' => 'Modul training dan alat tulis',
                'quantity' => 4,
                'unit_price' => 150000,
            ],
            [
                'category' => 'meal',
                'item_name' => 'Konsumsi',
                'description' => 'Makan siang dan coffee break',
                'quantity' => 5,
                'unit_price' => 200000,
            ],
        ] : [
            [
                'category' => 'instructor_fee',
                'item_name' => 'Biaya Training',
                'description' => 'Biaya training digital marketing per peserta',
                'quantity' => 2,
                'unit_price' => 3500000,
            ],
            [
                'category' => 'transportation',
                'item_name' => 'Transportasi',
                'description' => 'Transportasi PP Jakarta',
                'quantity' => 2,
                'unit_price' => 750000,
            ],
            [
                'category' => 'accommodation',
                'item_name' => 'Hotel',
                'description' => 'Akomodasi hotel 2 malam',
                'quantity' => 2,
                'unit_price' => 600000,
            ],
            [
                'category' => 'certification',
                'item_name' => 'Biaya Sertifikasi',
                'description' => 'Biaya ujian dan sertifikat',
                'quantity' => 2,
                'unit_price' => 500000,
            ],
        ];

        foreach ($budgetItems as $budgetData) {
            $budgetItem = new TrainingProgramSubmissionBudgetItem([
                'training_program_submission_id' => $submission->id,
                ...$budgetData,
            ]);
            $budgetItem->save();
        }

        // Update total budget
        $totalBudget = $submission->budgetItems()->sum('total_price');
        $submission->update(['total_budget' => $totalBudget]);
    }

    private function createSampleParticipants(TrainingProgramSubmission $submission, $participants)
    {
        foreach ($participants as $index => $profile) {
            $participant = new TrainingProgramSubmissionParticipant([
                'training_program_submission_id' => $submission->id,
                'profile_id' => $profile->id,
                'role_description' => $index === 0 ? 'Peserta utama yang akan mengikuti seluruh program' : 'Peserta pendamping',
                'selection_reason' => 'Dipilih berdasarkan kebutuhan pengembangan kompetensi dan relevansi dengan tugas',
                'is_primary_participant' => $index === 0,
                'order' => $index + 1,
            ]);
            $participant->save();
        }
    }
} 