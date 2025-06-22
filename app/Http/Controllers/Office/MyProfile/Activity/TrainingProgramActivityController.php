<?php

namespace App\Http\Controllers\Office\MyProfile\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityResource;
use App\Http\Resources\TrainingProgram\ActivityAssessmentResource;
use App\Http\Resources\TrainingProgram\TrainingProgramAssessmentResultResource;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityParticipantResource;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Models\TrainingProgram\TrainingProgramMaterialProgress;
use App\Models\TrainingProgram\TrainingProgramQuizAttempt;
use App\Services\TrainingProgramParticipantService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use App\Http\Resources\TrainingProgram\ActivityTrainingProgramResource;

class TrainingProgramActivityController extends Controller
{
    protected TrainingProgramParticipantService $participantService;

    public function __construct(TrainingProgramParticipantService $participantService)
    {
        $this->participantService = $participantService;
    }
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

        // Manual serialization to ensure nested resources work properly
        $participantsData = [];
        foreach ($participants as $participant) {
            $participantArray = (new TrainingProgramActivityParticipantResource($participant))->toArray(request());
            
            // Manually serialize the activity resource and its nested resources
            if ($participant->activity) {
                $activity = $participant->activity;
                $activityArray = (new TrainingProgramActivityResource($activity))->toArray(request());
                
                // Also serialize nested resources within activity
                if ($activity->trainingProgram) {
                    $activityArray['training_program'] = $activity->trainingProgram->toArray();
                }
                if ($activity->creator) {
                    $activityArray['creator'] = $activity->creator->toArray();
                }
                
                $participantArray['activity'] = $activityArray;
            }
            
            $participantsData[] = $participantArray;
        }

        $data = [
            'participants' => [
                'data' => $participantsData,
                'links' => $participants->linkCollection()->toArray(),
                'meta' => [
                    'current_page' => $participants->currentPage(),
                    'from' => $participants->firstItem(),
                    'last_page' => $participants->lastPage(),
                    'path' => $participants->path(),
                    'per_page' => $participants->perPage(),
                    'to' => $participants->lastItem(),
                    'total' => $participants->total(),
                ]
            ],
            'search_params' => [
                'search' => $request->search,
                'status' => $request->status,
                'completed' => $request->completed,
            ],
        ];
        // dd($data);

        return Inertia::render('Office/MyProfile/Activity/Index', $data);
    }

    /**
     * Display the specified activity.
     */
    public function show($activityUuid)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with([
                'activityTrainingProgram.phases.modules.materials',
                'activityTrainingProgram.phases.modules.quizzes',
                'activityTrainingProgram.phases.modules.assessments',
                'submission',
                'creator',
            ])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->with([
                'phaseProgress.activityPhase',
                'phaseProgress.masterPhase',
                'moduleProgress.activityModule',
                'moduleProgress.masterModule',
                'materialProgress.activityMaterial',
                'materialProgress.masterMaterial',
                'quizAttempts.activityQuiz',
                'quizAttempts.masterQuiz',
                'assessmentResults.activityAssessment',
                'assessmentResults.masterAssessment',
            ])
            ->first();

        // Manually serialize activity with progress data integrated
        $activityData = TrainingProgramActivityResource::make($activity)->resolve();
        
        // If there's an activity training program (snapshot), integrate progress data
        if ($activity->activityTrainingProgram && $participant) {
            $activityTrainingProgramData = ActivityTrainingProgramResource::make($activity->activityTrainingProgram)->resolve();
            
            // Map phase progress using activity_phase_id (for snapshot system)
            $phaseProgressMap = $participant->phaseProgress->keyBy('activity_phase_id');
            
            // Map module progress using activity_module_id (for snapshot system)
            $moduleProgressMap = $participant->moduleProgress->keyBy('activity_module_id');
            
            // Integrate progress into phases
            if (isset($activityTrainingProgramData['phases'])) {
                foreach ($activityTrainingProgramData['phases'] as &$phase) {
                    $phaseProgress = $phaseProgressMap->get($phase['id']);
                    $phase['progress'] = $phaseProgress ? (float) $phaseProgress->progress_percentage : 0;
                    $phase['status'] = $phaseProgress && $phaseProgress->completed_at ? 'completed' : 
                                     ($phaseProgress && $phaseProgress->started_at ? 'in_progress' : 'not_started');
                    
                    // Integrate progress into modules
                    if (isset($phase['modules'])) {
                        foreach ($phase['modules'] as &$module) {
                            $moduleProgress = $moduleProgressMap->get($module['id']);
                            $module['progress'] = $moduleProgress ? (float) $moduleProgress->progress_percentage : 0;
                            $module['status'] = $moduleProgress ? strtolower($moduleProgress->status) : 'not_started';
                        }
                    }
                }
            }
            
            $activityData['activity_training_program'] = $activityTrainingProgramData;
        }

        $data = [
            'activity' => $activityData,
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
        ];

        return Inertia::render('Office/MyProfile/Activity/Show', $data);
    }

    /**
     * Display learning interface for activity.
     */
    public function learn($activityUuid)
    {
        $profileId = auth()->user()->profile->id;
        
        $activity = TrainingProgramActivity::where('uuid', $activityUuid)
            ->whereHas('participants', function ($query) use ($profileId) {
                $query->where('profile_id', $profileId);
            })
            ->with([
                'activityTrainingProgram.phases.modules.materials',
                'activityTrainingProgram.phases.modules.quizzes.questions.options',
                'activityTrainingProgram.phases.modules.assessments.groupIndicators.indicators.sessions.rubrics',
                'submission',
                'creator',
            ])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('profile_id', $profileId)
            ->with([
                'phaseProgress.activityPhase',
                'phaseProgress.masterPhase',
                'moduleProgress.activityModule',
                'moduleProgress.masterModule',
                'materialProgress.activityMaterial',
                'materialProgress.masterMaterial',
                'quizAttempts.activityQuiz',
                'quizAttempts.masterQuiz',
                'assessmentResults.activityAssessment',
                'assessmentResults.masterAssessment',
            ])
            ->first();

        // Manually serialize activity with progress data integrated
        $activityData = TrainingProgramActivityResource::make($activity)->resolve();
        
        // If there's an activity training program (snapshot), integrate progress data
        if ($activity->activityTrainingProgram && $participant) {
            $activityTrainingProgramData = ActivityTrainingProgramResource::make($activity->activityTrainingProgram)->resolve();
            
            // Map phase progress using activity_phase_id (for snapshot system)
            $phaseProgressMap = $participant->phaseProgress->keyBy('activity_phase_id');
            
            // Map module progress using activity_module_id (for snapshot system)
            $moduleProgressMap = $participant->moduleProgress->keyBy('activity_module_id');
            
            // Integrate progress into phases
            if (isset($activityTrainingProgramData['phases'])) {
                foreach ($activityTrainingProgramData['phases'] as &$phase) {
                    $phaseProgress = $phaseProgressMap->get($phase['id']);
                    $phase['progress'] = $phaseProgress ? (float) $phaseProgress->progress_percentage : 0;
                    $phase['status'] = $phaseProgress && $phaseProgress->completed_at ? 'completed' : 
                                     ($phaseProgress && $phaseProgress->started_at ? 'in_progress' : 'not_started');
                    
                    // Integrate progress into modules
                    if (isset($phase['modules'])) {
                        foreach ($phase['modules'] as &$module) {
                            $moduleProgress = $moduleProgressMap->get($module['id']);
                            $module['progress'] = $moduleProgress ? (float) $moduleProgress->progress_percentage : 0;
                            $module['status'] = $moduleProgress ? strtolower($moduleProgress->status) : 'not_started';
                            
                            // Add quiz completion status
                            if (isset($module['quizzes'])) {
                                foreach ($module['quizzes'] as &$quiz) {
                                    // Check if quiz has been completed (submitted at least once)
                                    $hasCompletedQuiz = $participant->quizAttempts()
                                        ->where('activity_quiz_id', $quiz['id'])
                                        ->whereNotNull('completed_at')
                                        ->exists();
                                    
                                    // Check if quiz has been passed
                                    $hasPassedQuiz = $participant->quizAttempts()
                                        ->where('activity_quiz_id', $quiz['id'])
                                        ->where('passed', true)
                                        ->exists();
                                    
                                    $quiz['completed'] = $hasCompletedQuiz;
                                    $quiz['passed'] = $hasPassedQuiz;
                                    $quiz['status'] = $hasPassedQuiz ? 'passed' : 
                                                     ($hasCompletedQuiz ? 'completed' : 'not_started');
                                    
                                    // Get best score from all attempts
                                    $bestAttempt = $participant->quizAttempts()
                                        ->where('activity_quiz_id', $quiz['id'])
                                        ->whereNotNull('completed_at')
                                        ->orderBy('score', 'desc')
                                        ->first();
                                    $quiz['best_score'] = $bestAttempt ? $bestAttempt->score : null;
                                    
                                    // Get latest attempt for additional info
                                    $latestAttempt = $participant->quizAttempts()
                                        ->where('activity_quiz_id', $quiz['id'])
                                        ->whereNotNull('completed_at')
                                        ->orderBy('completed_at', 'desc')
                                        ->first();
                                    $quiz['latest_score'] = $latestAttempt ? $latestAttempt->score : null;
                                    $quiz['attempt_count'] = $participant->quizAttempts()
                                        ->where('activity_quiz_id', $quiz['id'])
                                        ->whereNotNull('completed_at')
                                        ->count();
                                }
                            }
                            
                            // Add assessment completion status
                            if (isset($module['assessments'])) {
                                foreach ($module['assessments'] as &$assessment) {
                                    // Check if assessment has been completed (has result)
                                    $assessmentResult = $participant->assessmentResults()
                                        ->where('activity_assessment_id', $assessment['id'])
                                        ->first();
                                    
                                    if ($assessmentResult) {
                                        $assessment['completed'] = true;
                                        $assessment['score'] = $assessmentResult->final_score;
                                        $assessment['status'] = 'dinilai';
                                        $assessment['assessed_at'] = $assessmentResult->assessed_at ? $assessmentResult->assessed_at->format('Y-m-d H:i:s') : null;
                                        $assessment['feedback'] = $assessmentResult->feedback;
                                        $assessment['is_passed'] = method_exists($assessmentResult, 'isPassed') ? $assessmentResult->isPassed() : ($assessmentResult->final_score >= 70);
                                    } else {
                                        $assessment['completed'] = false;
                                        $assessment['score'] = null;
                                        $assessment['status'] = 'belum dinilai';
                                        $assessment['assessed_at'] = null;
                                        $assessment['feedback'] = null;
                                        $assessment['is_passed'] = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            $activityData['activity_training_program'] = $activityTrainingProgramData;
        }

        $data = [
            'activity' => $activityData,
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
        ];

        return Inertia::render('Office/MyProfile/Activity/Learn', $data);
    }

    /**
     * Take quiz.
     */
    public function takeQuiz($activityUuid, $quizId, Request $request)
    {
        try {
            $profileId = auth()->user()->profile->id;
            $reviewMode = $request->has('review') && $request->review === 'true';
            
            // Get activity for resource
            $activity = TrainingProgramActivity::where('uuid', $activityUuid)
                ->whereHas('participants', function ($query) use ($profileId) {
                    $query->where('profile_id', $profileId);
                })
                ->firstOrFail();

            $participant = $activity->participants()
                ->where('profile_id', $profileId)
                ->first();

            // Check if user has completed attempts for this quiz
            $completedAttempt = $participant->quizAttempts()
                ->where('activity_quiz_id', $quizId)
                ->whereNotNull('completed_at')
                ->orderBy('completed_at', 'desc')
                ->first();

            // If quiz is completed and not in review mode, redirect to result
            if ($completedAttempt && !$reviewMode) {
                return redirect()->route('office.myProfile.activity.trainingProgram.viewQuizResult', [
                    'activityUuid' => $activityUuid,
                    'attemptId' => $completedAttempt->id
                ]);
            }

            // For review mode, use completed attempt; otherwise start new attempt
            if ($reviewMode && $completedAttempt) {
                $attempt = $completedAttempt;
            } else {
                // Use service to start quiz attempt
                $attempt = $this->participantService->startQuizAttempt($activityUuid, $quizId, $profileId);
            }

            // Get quiz with questions from activity snapshot
            $quiz = $attempt->activityQuiz()->with('questions.options')->first();

            if (!$quiz) {
                abort(404, 'Quiz tidak ditemukan');
            }

            $data = [
                'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
                'quiz' => $quiz->toArray(),
                'attempt' => $attempt->toArray(),
                'questions' => $quiz->questions->toArray(),
                'reviewMode' => $reviewMode,
            ];

            return Inertia::render('Office/MyProfile/Activity/TakeQuiz', $data);
        } catch (\RuntimeException $e) {
            abort(500, $e->getMessage());
        } catch (\InvalidArgumentException $e) {
            abort(404, $e->getMessage());
        } catch (\Exception $e) {
            abort(500, 'Terjadi kesalahan sistem.');
        }
    }

    /**
     * Save quiz answers (auto-save while taking quiz).
     */
    public function saveQuizAnswers(Request $request)
    {
        $validated = $request->validate([
            'attempt_id' => 'required|exists:tp_quiz_attempts,id',
            'answers' => 'required|array',
        ]);

        try {
            $profileId = auth()->user()->profile->id;
            
            // Find the attempt and verify ownership
            $attempt = TrainingProgramQuizAttempt::where('id', $validated['attempt_id'])
                ->whereHas('participant', function ($query) use ($profileId) {
                    $query->where('profile_id', $profileId);
                })
                ->whereNull('completed_at') // Only allow saving for incomplete attempts
                ->firstOrFail();

            // Save answers to the attempt
            $attempt->update([
                'answers' => $validated['answers']
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Jawaban berhasil disimpan.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menyimpan jawaban.',
            ], 500);
        }
    }

    /**
     * Submit quiz answers.
     */
    public function submitQuiz(Request $request, $activityUuid, $quizId)
    {
        $validated = $request->validate([
            'attempt_id' => 'required|exists:tp_quiz_attempts,id',
            'answers' => 'required|array',
        ]);

        try {
            $profileId = auth()->user()->profile->id;
            
            // Use service to submit quiz answers
            $attempt = $this->participantService->submitQuizAnswers(
                $activityUuid,
                $quizId,
                $profileId,
                $validated['attempt_id'],
                $validated['answers']
            );

            return redirect()->route('office.myProfile.activity.trainingProgram.viewQuizResult', [
                'activityUuid' => $activityUuid,
                'attemptId' => $attempt->id
            ])->with('success', 'Quiz berhasil diselesaikan.');
        } catch (\InvalidArgumentException $e) {
            return back()->withErrors(['general' => $e->getMessage()]);
        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan saat menyelesaikan quiz: ' . $e->getMessage());
        }
    }

    /**
     * View quiz result.
     */
    public function viewQuizResult($activityUuid, $attemptId)
    {
        try {
            $profileId = auth()->user()->profile->id;
            
            // Get activity for resource
            $activity = TrainingProgramActivity::where('uuid', $activityUuid)
                ->whereHas('participants', function ($query) use ($profileId) {
                    $query->where('profile_id', $profileId);
                })
                ->firstOrFail();

            $participant = $activity->participants()
                ->where('profile_id', $profileId)
                ->first();

            // Get the specific attempt with activity quiz data (snapshot system)
            $attempt = $participant->quizAttempts()
                ->where('id', $attemptId)
                ->with([
                    'activityQuiz.questions.options',
                    'quiz.questions.options' // fallback for legacy data
                ])
                ->firstOrFail();

            $data = [
                'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
                'attempt' => $attempt->toArray(),
                'quizId' => $attempt->activity_quiz_id ?: $attempt->quiz_id, // Add explicit quiz ID for review
            ];

            // dd($data);

            return Inertia::render('Office/MyProfile/Activity/TakeQuizResult', $data);
        } catch (\Exception $e) {
            abort(404, 'Quiz result tidak ditemukan.');
        }
    }

    /**
     * View assessment.
     */
    public function viewAssessment($activityUuid, $assessmentId)
    {
        try {
            $profileId = auth()->user()->profile->id;
            
            // Get activity for resource
            $activity = TrainingProgramActivity::where('uuid', $activityUuid)
                ->whereHas('participants', function ($query) use ($profileId) {
                    $query->where('profile_id', $profileId);
                })
                ->with(['activityTrainingProgram'])
                ->firstOrFail();

            $participant = $activity->participants()
                ->where('profile_id', $profileId)
                ->first();

            if (!$participant) {
                abort(403, 'Anda tidak terdaftar dalam aktivitas ini.');
            }

            // Get assessment from activity snapshot (not master)
            $assessment = null;
            if ($activity->activityTrainingProgram) {
                // Find assessment in snapshot data using activity_assessment_id
                $assessment = \App\Models\TrainingProgram\ActivityAssessment::where('id', $assessmentId)
                    ->whereHas('activityModule.activityPhase', function ($query) use ($activity) {
                        $query->where('activity_training_program_id', $activity->activityTrainingProgram->id);
                    })
                    ->with([
                        'groupIndicators.indicators.sessions.rubrics',
                        'activityModule.activityPhase'
                    ])
                    ->first();
            }

            if (!$assessment) {
                abort(404, 'Assessment tidak ditemukan dalam aktivitas ini.');
            }

            // Use service to get assessment results
            $results = $this->participantService->getAssessmentResults($activityUuid, $assessmentId, $profileId);
            $result = $results ? $results->first() : null;

            $data = [
                'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
                'assessment' => ActivityAssessmentResource::make($assessment)->resolve(),
                'result' => $result ? TrainingProgramAssessmentResultResource::make($result)->resolve() : null,
            ];

            return Inertia::render('Office/MyProfile/Activity/ViewAssessment', $data);
        } catch (\Exception $e) {
            \Log::error('ViewAssessment Error: ' . $e->getMessage());
            \Log::error('Stack trace: ' . $e->getTraceAsString());
            abort(404, 'Assessment tidak ditemukan: ' . $e->getMessage());
        }
    }

    /**
     * View certificate.
     */
    public function certificate($activityUuid)
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

        return Inertia::render('Office/MyProfile/Activity/Certificate', $data);
    }



    /**
     * Mark material as viewed.
     */
    public function markMaterialViewed(Request $request)
    {
        $validated = $request->validate([
            'activity_uuid' => 'required|string',
            'material_id' => 'required|integer',
        ]);

        try {
            $profileId = auth()->user()->profile->id;
            $this->participantService->markMaterialViewed(
                $validated['activity_uuid'], 
                $validated['material_id'], 
                $profileId
            );

            return response()->json([
                'success' => true,
                'message' => 'Material berhasil ditandai sebagai dilihat.',
            ]);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan sistem.',
            ], 500);
        }
    }

    /**
     * Mark material as completed.
     */
    public function markMaterialCompleted(Request $request)
    {
        $validated = $request->validate([
            'activity_uuid' => 'required|string',
            'material_id' => 'required|integer',
            'time_spent' => 'nullable|integer|min:0',
        ]);

        try {
            $profileId = auth()->user()->profile->id;
            $this->participantService->markMaterialCompleted(
                $validated['activity_uuid'], 
                $validated['material_id'], 
                $profileId,
                $validated['time_spent'] ?? null
            );

            return response()->json([
                'success' => true,
                'message' => 'Material berhasil diselesaikan.',
            ]);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan sistem.',
            ], 500);
        }
    }

    /**
     * Download certificate PDF.
     */
    public function downloadCertificate($activityUuid)
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

        // Generate PDF certificate
        // This would typically use a PDF library like DomPDF or TCPDF
        // For now, return a simple response
        return response()->download(
            public_path('certificates/certificate-template.pdf'),
            "certificate-{$activity->title}-{$participant->profile->name}.pdf"
        );
    }
}