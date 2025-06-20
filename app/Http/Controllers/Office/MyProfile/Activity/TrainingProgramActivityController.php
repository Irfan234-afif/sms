<?php

namespace App\Http\Controllers\Office\MyProfile\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityResource;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityParticipantResource;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\TrainingProgramMaterialProgress;
use App\Models\TrainingProgram\TrainingProgramQuizAttempt;
use App\Models\TrainingProgram\TrainingProgramAssessmentResult;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class TrainingProgramActivityController extends Controller
{
    /**
     * Display a listing of my training activities.
     */
    public function index(Request $request)
    {
        $profileId = auth()->user()->profile->id;
        
        $participants = TrainingProgramActivityParticipant::where('profile_id', $profileId);

        // Search
        if ($request->has('search')) {
            $participants->whereHas('activity', function ($query) use ($request) {
                $query->where('title', 'like', '%' . $request->search . '%')
                    ->orWhere('description', 'like', '%' . $request->search . '%');
            });
        }

        // Status filter
        if ($request->has('status') && $request->status !== '') {
            $participants->whereHas('activity', function ($query) use ($request) {
                $query->where('status', $request->status);
            });
        }

        // Completion filter
        if ($request->has('completed') && $request->completed !== '') {
            if ($request->completed === 'yes') {
                $participants->whereNotNull('completion_date');
            } else {
                $participants->whereNull('completion_date');
            }
        }

        $participants = $participants->with([
                'activity.trainingProgram',
                'activity.creator',
                'phaseProgress',
                'moduleProgress',
            ])
            ->latest()
            ->paginate(15);

        $data = [
            'participants' => TrainingProgramActivityParticipantResource::collection($participants),
            'search_params' => [
                'search' => $request->search,
                'status' => $request->status,
                'completed' => $request->completed,
            ],
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Index', $data);
    }

    /**
     * Display my training activity detail and learning interface.
     */
    public function show($activityUuid)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with([
                'trainingProgram.phases.modules.materials',
                'trainingProgram.phases.modules.quizzes.questions.options',
                'trainingProgram.phases.modules.assessments.groupIndicators.indicators.sessions.rubrics',
                'submission',
                'creator',
            ])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->with([
                'phaseProgress.phase',
                'moduleProgress.module',
                'materialProgress.material',
                'quizAttempts.quiz',
                'assessmentResults.assessment',
            ])
            ->first();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'participant' => TrainingProgramActivityParticipantResource::make($participant),
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Show', $data);
    }

    /**
     * View material and track progress.
     */
    public function viewMaterial(Request $request, $activityUuid, $materialId)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Get or create material progress
        $materialProgress = $participant->materialProgress()
            ->where('material_id', $materialId)
            ->first();

        if (!$materialProgress) {
            $materialProgress = TrainingProgramMaterialProgress::create([
                'participant_id' => $participant->id,
                'material_id' => $materialId,
                'time_spent' => 0,
            ]);
        }

        // Mark as viewed
        $materialProgress->markAsViewed();

        // Get material with module info
        $material = $materialProgress->material()->with('module')->first();

        // Update module progress
        $moduleProgress = $participant->moduleProgress()
            ->where('module_id', $material->module_id)
            ->first();
        
        if ($moduleProgress) {
            $moduleProgress->markAsStarted();
        }

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'material' => $material,
            'materialProgress' => $materialProgress,
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Material', $data);
    }

    /**
     * Mark material as completed.
     */
    public function completeMaterial(Request $request, $activityUuid, $materialId)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        $materialProgress = $participant->materialProgress()
            ->where('material_id', $materialId)
            ->firstOrFail();

        // Update time spent if provided
        if ($request->has('time_spent')) {
            $materialProgress->addTimeSpent($request->time_spent);
        }

        // Mark as completed
        $materialProgress->markAsCompleted();

        // Update progress calculations
        $this->updateProgressCalculations($participant);

        return response()->json([
            'success' => true,
            'message' => 'Material berhasil diselesaikan.',
        ]);
    }

    /**
     * Start quiz attempt.
     */
    public function startQuiz($activityUuid, $quizId)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Check if participant can take quiz (max attempts, etc.)
        $attemptNumber = TrainingProgramQuizAttempt::getNextAttemptNumber($participant->id, $quizId);
        
        // Create new quiz attempt
        $attempt = TrainingProgramQuizAttempt::create([
            'participant_id' => $participant->id,
            'quiz_id' => $quizId,
            'attempt_number' => $attemptNumber,
            'started_at' => now(),
        ]);

        // Get quiz with questions
        $quiz = $attempt->quiz()->with('questions.options')->first();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'quiz' => $quiz,
            'attempt' => $attempt,
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Quiz', $data);
    }

    /**
     * Submit quiz answers.
     */
    public function submitQuiz(Request $request, $activityUuid, $quizId)
    {
        $profileId = auth()->user()->profile->id;
        
        $validated = $request->validate([
            'attempt_id' => 'required|exists:training_program_quiz_attempts,id',
            'answers' => 'required|array',
        ]);

        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        $attempt = $participant->quizAttempts()
            ->where('id', $validated['attempt_id'])
            ->where('quiz_id', $quizId)
            ->whereNull('completed_at')
            ->firstOrFail();

        // Complete the attempt and calculate score
        $attempt->completeAttempt($validated['answers']);

        // Update progress calculations
        $this->updateProgressCalculations($participant);

        return response()->json([
            'success' => true,
            'message' => 'Quiz berhasil diselesaikan.',
            'score' => $attempt->score,
            'passed' => $attempt->passed,
        ]);
    }

    /**
     * View quiz result.
     */
    public function viewQuizResult($activityUuid, $attemptId)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        $attempt = $participant->quizAttempts()
            ->where('id', $attemptId)
            ->with('quiz.questions.options')
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'attempt' => $attempt,
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/QuizResult', $data);
    }

    /**
     * View assessment.
     */
    public function viewAssessment($activityUuid, $assessmentId)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->first();

        // Get assessment with all relations
        $assessment = $activity->trainingProgram->phases()
            ->join('training_program_phase_modules', 'training_program_phases.id', '=', 'training_program_phase_modules.phase_id')
            ->join('training_program_module_assessments', 'training_program_phase_modules.id', '=', 'training_program_module_assessments.module_id')
            ->where('training_program_module_assessments.id', $assessmentId)
            ->with('groupIndicators.indicators.sessions.rubrics')
            ->first();

        // Get existing result if any
        $result = $participant->assessmentResults()
            ->where('assessment_id', $assessmentId)
            ->first();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'assessment' => $assessment,
            'result' => $result,
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Assessment', $data);
    }

    /**
     * View certificate.
     */
    public function viewCertificate($activityUuid)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->where('certificate_issued', true)
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'participant' => TrainingProgramActivityParticipantResource::make($participant),
        ];

        return Inertia::render('Office/MyProfile/Activity/TrainingProgram/Certificate', $data);
    }

    /**
     * Update progress calculations for participant.
     */
    private function updateProgressCalculations($participant)
    {
        // Update module progress
        foreach ($participant->moduleProgress as $moduleProgress) {
            $moduleProgress->calculateProgress();
        }

        // Update phase progress
        foreach ($participant->phaseProgress as $phaseProgress) {
            $phaseProgress->calculateProgress();
        }

        // Update overall progress
        $participant->calculateOverallProgress();

        // Check if certificate should be issued
        if ($participant->hasCompleted()) {
            $participant->issueCertificate();
        }
    }
}