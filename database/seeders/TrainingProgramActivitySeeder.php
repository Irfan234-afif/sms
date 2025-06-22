<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\TrainingProgramParticipantPhaseProgress;
use App\Models\TrainingProgram\TrainingProgramParticipantModuleProgress;
use App\Models\TrainingProgram\TrainingProgramMaterialProgress;
use App\Models\TrainingProgram\TrainingProgramQuizAttempt;
use App\Models\Profile;
use App\Services\ActivitySnapshotService;

class TrainingProgramActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->clearExistingData();
        $this->createComprehensiveActivities();
    }
    
    private function clearExistingData()
    {
        // Clear in reverse dependency order
        DB::table('tp_assessment_results')->delete();
        DB::table('tp_quiz_attempts')->delete();
        DB::table('tp_material_progress')->delete();
        DB::table('tp_participant_module_progress')->delete();
        DB::table('tp_participant_phase_progress')->delete();
        DB::table('tp_activity_participants')->delete();
        DB::table('training_program_activities')->delete();
        
        // Clear activity snapshot tables
        DB::table('activity_assessment_rubrics')->delete();
        DB::table('activity_assessment_indicator_sessions')->delete();
        DB::table('activity_assessment_indicators')->delete();
        DB::table('activity_assessment_group_indicators')->delete();
        DB::table('activity_assessments')->delete();
        DB::table('activity_quiz_question_options')->delete();
        DB::table('activity_quiz_questions')->delete();
        DB::table('activity_quizzes')->delete();
        DB::table('activity_materials')->delete();
        DB::table('activity_modules')->delete();
        DB::table('activity_phases')->delete();
        DB::table('activity_training_programs')->delete();
        
        $this->command->info('Cleared existing activity data');
    }
    
    private function createComprehensiveActivities()
    {
        // Get existing training programs
        $programs = TrainingProgram::where('status', 'active')->get();

        if ($programs->isEmpty()) {
            $this->command->warn('No training programs found. Please run TrainingProgramSeeder first.');
            return;
        }

        // Get profiles for participants
        $profiles = Profile::limit(50)->get(); // Increase to 50 for more realistic data
        if ($profiles->isEmpty()) {
            $this->command->warn('No profiles found. Cannot create participants.');
            return;
        }

        $snapshotService = new ActivitySnapshotService();

        foreach ($programs as $index => $program) {
            // Create multiple batches per program
            $batchCount = rand(2, 4); // 2-4 batches per program
            
            for ($batch = 1; $batch <= $batchCount; $batch++) {
                $this->createActivityForProgram($program, $batch, $profiles, $snapshotService);
            }
        }

        $this->command->info('Training Program Activities created successfully!');
    }
    
    private function createActivityForProgram($program, $batchNumber, $profiles, $snapshotService)
    {
        $this->command->info("Creating activity for program: {$program->name} - Batch {$batchNumber}");
        
        // Create activity with varied dates
        $startDate = Carbon::now()->subDays(rand(60, 180)); // Started 2-6 months ago
        $duration = rand(30, 90); // 1-3 months duration
        $endDate = $startDate->copy()->addDays($duration);
        
        $status = $this->getRealisticActivityStatus($startDate, $endDate);
        
        $activity = TrainingProgramActivity::create([
            'title' => "Batch {$batchNumber}: {$program->name}",
            'description' => "Pelaksanaan program pelatihan {$program->name} batch {$batchNumber} dengan target peserta dari berbagai divisi untuk meningkatkan kompetensi sesuai kebutuhan organisasi.",
            'training_program_id' => $program->id,
            'submission_id' => null,
            'start_date' => $startDate->format('Y-m-d'),
            'end_date' => $endDate->format('Y-m-d'),
            'status' => strtoupper($status),
            'location' => $this->getRandomLocation($batchNumber),
            'created_by' => $profiles->first()->id,
        ]);

        // Create activity snapshots
        try {
            $snapshotService->createSnapshot($activity);
            $this->command->info("Created snapshots for activity: {$activity->title}");
        } catch (\Exception $e) {
            $this->command->error("Failed to create snapshots for activity {$activity->id}: " . $e->getMessage());
            return;
        }

        // Add participants with realistic distribution
        $participantCount = $this->getParticipantCount($program->level);
        $selectedProfiles = $profiles->random($participantCount);
        
        foreach ($selectedProfiles as $profile) {
            $enrollmentDate = $startDate->copy()->addDays(rand(-7, 3)); // Enrolled around start date
            
            $participant = TrainingProgramActivityParticipant::create([
                'activity_id' => $activity->id,
                'profile_id' => $profile->id,
                'enrollment_date' => $enrollmentDate->format('Y-m-d'),
                'completion_date' => $this->getCompletionDate($activity, $status),
                'overall_progress' => $this->getRealisticProgress($status),
                'certificate_issued' => $status === 'completed' && rand(1, 100) <= 80, // 80% get certificates
            ]);
            
            // Create realistic progress data
            $this->createParticipantProgress($activity, $participant, $status);
        }

        $this->command->info("Created activity: {$activity->title} with {$selectedProfiles->count()} participants");
    }
    
    private function createParticipantProgress($activity, $participant, $activityStatus)
    {
        // Get activity snapshots
        $activityProgram = $activity->activityTrainingProgram;
        if (!$activityProgram) {
            $this->command->warn("No activity program found for activity {$activity->id}");
            return;
        }

        $phases = $activityProgram->phases()->orderBy('order')->get();
        
        foreach ($phases as $phaseIndex => $phase) {
            $phaseProgress = $this->calculatePhaseProgress($phaseIndex, $phases->count(), $activityStatus);
            
            // Create phase progress
            $phaseProgressRecord = TrainingProgramParticipantPhaseProgress::create([
                'participant_id' => $participant->id,
                'activity_phase_id' => $phase->id,
                'old_phase_id' => $phase->master_phase_id,
                'progress_percentage' => $phaseProgress,
                'started_at' => $this->getPhaseStartDate($participant, $phaseIndex),
                'completed_at' => $phaseProgress >= 100 ? $this->getPhaseCompletionDate($participant, $phaseIndex) : null,
            ]);

            // Create module progress for this phase
            $modules = $phase->modules()->orderBy('order')->get();
            
            foreach ($modules as $moduleIndex => $module) {
                $moduleProgress = $this->calculateModuleProgress($phaseProgress, $moduleIndex, $modules->count());
                
                $moduleProgressRecord = TrainingProgramParticipantModuleProgress::create([
                    'participant_id' => $participant->id,
                    'activity_module_id' => $module->id,
                    'old_module_id' => $module->master_module_id,
                    'status' => $this->getModuleStatus($moduleProgress),
                    'progress_percentage' => $moduleProgress,
                    'started_at' => $this->getModuleStartDate($phaseProgressRecord, $moduleIndex),
                    'completed_at' => $moduleProgress >= 100 ? $this->getModuleCompletionDate($phaseProgressRecord, $moduleIndex) : null,
                ]);

                // Create material progress
                $this->createMaterialProgress($module, $participant, $moduleProgress);
                
                // Create quiz attempts - lowered threshold to create more attempts
                $this->createQuizAttempts($module, $participant, $moduleProgress);
            }
        }
    }
    
    private function createMaterialProgress($module, $participant, $moduleProgress)
    {
        $materials = $module->materials()->orderBy('order')->get();
        
        foreach ($materials as $materialIndex => $material) {
            $materialProgress = $this->calculateMaterialProgress($moduleProgress, $materialIndex, $materials->count());
            
            if ($materialProgress > 0) {
                TrainingProgramMaterialProgress::create([
                    'participant_id' => $participant->id,
                    'activity_material_id' => $material->id,
                    'old_material_id' => $material->master_material_id,
                    'time_spent' => rand(5, 60) * 60, // 5-60 minutes in seconds
                    'viewed_at' => Carbon::now()->subDays(rand(1, 30)),
                    'completed_at' => $materialProgress >= 100 ? Carbon::now()->subDays(rand(0, 15)) : null,
                ]);
            }
        }
    }
    
    private function createQuizAttempts($module, $participant, $moduleProgress)
    {
        $quizzes = $module->quizzes()->get();
        
        foreach ($quizzes as $quiz) {
            // Create quiz attempts if module has minimal progress (very low threshold for testing)
            if ($moduleProgress >= 10) {
                $attemptCount = rand(1, 3); // 1-3 attempts per quiz
                
                for ($attempt = 1; $attempt <= $attemptCount; $attempt++) {
                    $completedAt = Carbon::now()->subDays(rand(0, 15));
                    
                    // Determine grading status - 70% of attempts are already graded
                    $isGraded = rand(1, 100) <= 70;
                    
                    $quizAttempt = [
                        'participant_id' => $participant->id,
                        'activity_quiz_id' => $quiz->id,
                        'old_quiz_id' => $quiz->master_quiz_id,
                        'attempt_number' => $attempt,
                        'answers' => $this->generateQuizAnswers($quiz),
                        'started_at' => Carbon::now()->subDays(rand(1, 20)),
                        'completed_at' => $completedAt,
                    ];
                    
                    if ($isGraded) {
                        // Generate realistic manual grading data
                        $gradingData = $this->generateManualGradingData($quiz, $attempt);
                        
                        $quizAttempt['score'] = $gradingData['total_score'];
                        $quizAttempt['passed'] = $gradingData['total_score'] >= ($quiz->passing_score ?? 70);
                        $quizAttempt['graded_at'] = $completedAt->addDays(rand(1, 5)); // Graded 1-5 days after completion
                        $quizAttempt['grader_id'] = $this->getRandomGraderId();
                        $quizAttempt['grader_feedback'] = $gradingData['feedback'];
                        $quizAttempt['manual_scores'] = $gradingData['manual_scores'];
                    } else {
                        // Quiz completed but awaiting manual grading
                        $quizAttempt['score'] = null;
                        $quizAttempt['passed'] = false;
                        $quizAttempt['graded_at'] = null;
                        $quizAttempt['grader_id'] = null;
                        $quizAttempt['grader_feedback'] = null;
                        $quizAttempt['manual_scores'] = null;
                    }
                    
                    TrainingProgramQuizAttempt::create($quizAttempt);
                    
                    // If passed, don't create more attempts
                    if (isset($quizAttempt['passed']) && $quizAttempt['passed']) break;
                }
            }
        }
    }
    
    private function generateQuizAnswers($quiz)
    {
        $questions = $quiz->questions;
        $answers = [];
        
        foreach ($questions as $question) {
            $questionId = (string) $question->id;
            
            switch ($question->type) {
                case 'multiple_choice':
                    $options = $question->options;
                    if ($options->isNotEmpty()) {
                        // 65% chance to answer correctly
                        if (rand(1, 100) <= 65) {
                            $correctOption = $options->where('is_correct', true)->first();
                            $answers[$questionId] = $correctOption ? (string) $correctOption->id : (string) $options->random()->id;
                        } else {
                            $answers[$questionId] = (string) $options->random()->id;
                        }
                    }
                    break;
                    
                case 'multiple_select':
            $options = $question->options;
            if ($options->isNotEmpty()) {
                        $correctOptions = $options->where('is_correct', true);
                        $selectedOptions = [];
                        
                        // 60% chance to select correct options
                        if (rand(1, 100) <= 60) {
                            // Add some correct options
                            $selectedOptions = $correctOptions->random(min(rand(1, $correctOptions->count()), $correctOptions->count()))->pluck('id')->map(function($id) {
                                return (string) $id;
                            })->toArray();
                        }
                        
                        // Sometimes add incorrect options
                        if (rand(1, 100) <= 30) {
                            $incorrectOptions = $options->where('is_correct', false);
                            if ($incorrectOptions->isNotEmpty()) {
                                $selectedOptions[] = (string) $incorrectOptions->random()->id;
                            }
                        }
                        
                        $answers[$questionId] = array_unique($selectedOptions);
                    }
                    break;
                    
                case 'true_false':
                // 70% chance to answer correctly
                    if (rand(1, 100) <= 70 && $question->correct_answer) {
                        $answers[$questionId] = $question->correct_answer;
                } else {
                        $answers[$questionId] = rand(0, 1) ? 'true' : 'false';
                    }
                    break;
                    
                case 'essay':
                    $essayAnswers = [
                        'Menurut saya, hal ini sangat penting dalam konteks pembelajaran dan pengembangan skill yang berkelanjutan.',
                        'Berdasarkan pengalaman, strategi yang efektif adalah dengan menerapkan pendekatan sistematis dan terstruktur.',
                        'Implementasi yang baik memerlukan koordinasi tim yang solid dan komunikasi yang efektif antar stakeholder.',
                        'Tantangan utama biasanya terletak pada aspek teknis dan adaptasi terhadap perubahan yang diperlukan.',
                        'Solusi optimal dapat dicapai melalui analisis mendalam dan pertimbangan berbagai faktor yang mempengaruhi.'
                    ];
                    $answers[$questionId] = $essayAnswers[array_rand($essayAnswers)];
                    break;
            }
        }
        
        return $answers;
    }
    
    private function generateManualGradingData($quiz, $attemptNumber)
    {
        $questions = $quiz->questions;
        $manualScores = [];
        $totalScore = 0;
        
        foreach ($questions as $question) {
            $questionScore = $this->generateQuestionScore($question->type, $attemptNumber);
            $manualScores[$question->id] = $questionScore;
            $totalScore += $questionScore;
        }
        
        // Calculate average score
        $averageScore = $questions->count() > 0 ? $totalScore / $questions->count() : 0;
        
        // Generate feedback based on score
        $feedback = $this->generateGraderFeedback($averageScore, $attemptNumber);
        
        return [
            'manual_scores' => $manualScores,
            'total_score' => round($averageScore, 1),
            'feedback' => $feedback
        ];
    }
    
    private function generateQuestionScore($questionType, $attemptNumber)
    {
        // Score varies by question type and attempt number
        switch ($questionType) {
            case 'multiple_choice':
            case 'true_false':
                // Objective questions: either 0 or 100
                $baseChance = $this->getPassChance($attemptNumber);
                return rand(1, 100) <= $baseChance ? 100 : 0;
                
            case 'multiple_select':
                // Partial credit possible
                $baseChance = $this->getPassChance($attemptNumber);
                if (rand(1, 100) <= $baseChance) {
                    return rand(70, 100); // Good answer
                } else {
                    return rand(0, 60); // Poor answer
                }
                
            case 'essay':
                // More subjective scoring
                $baseScore = $this->getBaseEssayScore($attemptNumber);
                return $baseScore + rand(-10, 15); // Add some variation
                
            default:
                return rand(60, 90);
        }
    }
    
    private function getPassChance($attemptNumber)
    {
        switch ($attemptNumber) {
            case 1:
                return 65; // 65% chance to get objective questions right
            case 2:
                return 75; // 75% chance (learning from mistakes)
            case 3:
                return 85; // 85% chance (should be better by now)
            default:
                return 70;
        }
    }
    
    private function getBaseEssayScore($attemptNumber)
    {
        switch ($attemptNumber) {
            case 1:
                return rand(60, 85); // First attempt: 60-85
            case 2:
                return rand(70, 90); // Second attempt: 70-90
            case 3:
                return rand(75, 95); // Third attempt: 75-95
            default:
                return rand(70, 90);
        }
    }
    
    private function generateGraderFeedback($averageScore, $attemptNumber)
    {
        $feedbacks = [];
        
        if ($averageScore >= 90) {
            $feedbacks = [
                'Excellent work! Jawaban menunjukkan pemahaman yang sangat baik terhadap materi.',
                'Outstanding performance! Semua konsep telah dipahami dengan baik.',
                'Impressive! Jawaban sangat komprehensif dan menunjukkan penguasaan materi yang excellent.'
            ];
        } elseif ($averageScore >= 80) {
            $feedbacks = [
                'Good job! Pemahaman materi sudah baik, ada beberapa area kecil yang bisa diperbaiki.',
                'Well done! Jawaban menunjukkan pemahaman yang solid terhadap sebagian besar konsep.',
                'Great effort! Hasil yang memuaskan dengan beberapa poin minor untuk improvement.'
            ];
        } elseif ($averageScore >= 70) {
            $feedbacks = [
                'Satisfactory performance. Pemahaman dasar sudah ada, perlu lebih focus pada detail.',
                'Cukup baik, namun masih ada beberapa konsep yang perlu diperdalam lagi.',
                'Passing grade achieved. Disarankan untuk review kembali materi yang masih kurang.'
            ];
        } else {
            $feedbacks = [
                'Perlu improvement significant. Silakan review materi dan coba kembali.',
                'Pemahaman masih kurang. Disarankan untuk study lebih intensif sebelum attempt berikutnya.',
                'Below passing grade. Please review the materials thoroughly and retake when ready.'
            ];
        }
        
        $baseFeedback = $feedbacks[array_rand($feedbacks)];
        
        // Add attempt-specific feedback
        if ($attemptNumber > 1) {
            $baseFeedback .= " (Attempt #{$attemptNumber} - good perseverance!)";
        }
        
        return $baseFeedback;
    }
    
    private function getRandomGraderId()
    {
        // Get random profile ID that could be a grader (instructors/admin)
        $profiles = Profile::inRandomOrder()->limit(5)->pluck('id')->toArray();
        return $profiles[array_rand($profiles)] ?? 1;
    }
    
    private function getRealisticActivityStatus($startDate, $endDate)
    {
        $now = Carbon::now();
        
        if ($now->lt($startDate)) {
            return 'planned';
        } elseif ($now->between($startDate, $endDate)) {
            return 'ongoing';
        } else {
            // 90% of past activities are completed
            return rand(1, 100) <= 90 ? 'completed' : 'ongoing';
        }
    }
    
    private function getParticipantCount($level)
    {
        switch ($level) {
            case 'beginner':
                return rand(15, 25);
            case 'intermediate':
                return rand(10, 20);
            case 'advanced':
                return rand(8, 15);
            default:
                return rand(10, 20);
        }
    }
    
    private function getRandomLocation($batchNumber)
    {
        $locations = [
            'Ruang Pelatihan A - Lantai 3',
            'Ruang Pelatihan B - Lantai 3',
            'Auditorium Utama - Lantai 2',
            'Ruang Seminar 1 - Lantai 4',
            'Ruang Seminar 2 - Lantai 4',
            'Training Center - Gedung Annex',
            'Online/Virtual Meeting',
            'Hybrid (Online + Onsite)',
        ];
        
        return $locations[($batchNumber - 1) % count($locations)];
    }
    
    private function getCompletionDate($activity, $status)
    {
        if ($status === 'completed') {
            $endDate = Carbon::parse($activity->end_date);
            return $endDate->subDays(rand(0, 7))->format('Y-m-d'); // Completed within a week of end date
        }
        
        return null;
    }
    
    private function getRealisticProgress($status)
    {
        switch ($status) {
            case 'planned':
                return 0;
            case 'ongoing':
                return rand(15, 85);
            case 'completed':
                return rand(90, 100);
            default:
                return 0;
        }
    }
    
    private function calculatePhaseProgress($phaseIndex, $totalPhases, $activityStatus)
    {
        switch ($activityStatus) {
            case 'planned':
                return 0;
            case 'ongoing':
                // Progressive completion: earlier phases more likely to be completed
                $baseProgress = ($phaseIndex / $totalPhases) * 100;
                $randomFactor = rand(-20, 30);
                return max(0, min(100, $baseProgress + $randomFactor));
            case 'completed':
                // Most phases completed, but some variation
                return rand(85, 100);
            default:
                return 0;
        }
    }
    
    private function calculateModuleProgress($phaseProgress, $moduleIndex, $totalModules)
    {
        if ($phaseProgress == 0) return 0;
        
        // Modules within a phase progress sequentially
        $moduleBaseProgress = ($moduleIndex / $totalModules) * $phaseProgress;
        $randomFactor = rand(-10, 20);
        
        return max(0, min(100, $moduleBaseProgress + $randomFactor));
    }
    
    private function calculateMaterialProgress($moduleProgress, $materialIndex, $totalMaterials)
    {
        if ($moduleProgress == 0) return 0;
        
        // Materials within a module progress sequentially
        $materialBaseProgress = ($materialIndex / $totalMaterials) * $moduleProgress;
        $randomFactor = rand(-5, 15);
        
        return max(0, min(100, $materialBaseProgress + $randomFactor));
    }
    
    private function getPhaseStatus($progress)
    {
        if ($progress == 0) return 'not_started';
        if ($progress >= 100) return 'completed';
        return 'in_progress';
    }
    
    private function getModuleStatus($progress)
    {
        if ($progress == 0) return 'not_started';
        if ($progress >= 100) return 'completed';
        return 'in_progress';
    }
    
    private function getPhaseStartDate($participant, $phaseIndex)
    {
        $enrollmentDate = Carbon::parse($participant->enrollment_date);
        return $enrollmentDate->addDays($phaseIndex * rand(3, 7)); // Each phase starts 3-7 days after previous
    }
    
    private function getPhaseCompletionDate($participant, $phaseIndex)
    {
        $startDate = $this->getPhaseStartDate($participant, $phaseIndex);
        return $startDate->addDays(rand(7, 21)); // Phase takes 1-3 weeks to complete
    }
    
    private function getModuleStartDate($phaseProgress, $moduleIndex)
    {
        $phaseStartDate = Carbon::parse($phaseProgress->started_at);
        return $phaseStartDate->addDays($moduleIndex * rand(1, 3)); // Each module starts 1-3 days after previous
    }
    
    private function getModuleCompletionDate($phaseProgress, $moduleIndex)
    {
        $startDate = $this->getModuleStartDate($phaseProgress, $moduleIndex);
        return $startDate->addDays(rand(2, 7)); // Module takes 2-7 days to complete
    }
} 