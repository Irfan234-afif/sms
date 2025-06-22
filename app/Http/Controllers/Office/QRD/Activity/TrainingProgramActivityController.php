<?php

namespace App\Http\Controllers\Office\QRD\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityParticipantResource;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityResource;
use App\Http\Resources\TrainingProgramResource;
use App\Http\Resources\ProfileResource;
use App\Models\Profile;
use App\Models\Submission;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use App\Services\ActivitySnapshotService;
use App\Services\TrainingProgramActivityService;
use App\Services\TrainingProgramParticipantService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use App\Http\Requests\Office\QRD\Activity\AddParticipantsRequest;
use App\Http\Requests\TrainingProgram\StoreAssessmentResultRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Str;

class TrainingProgramActivityController extends Controller
{
    protected TrainingProgramActivityService $activityService;
    protected TrainingProgramParticipantService $participantService;

    public function __construct(
        TrainingProgramActivityService $activityService,
        TrainingProgramParticipantService $participantService
    ) {
        $this->activityService = $activityService;
        $this->participantService = $participantService;
    }
    /**
     * Display a listing of activities.
     */
    public function index(Request $request)
    {
        $activities = TrainingProgramActivity::query()
            ->with('trainingProgram')
            ->withCount('participants')
            ->withCount(['participants as completed_participants_count' => function ($query) {
                $query->where('overall_progress', '>=', 100);
            }])
            ->withAvg('participants', 'overall_progress')
            ->when($request->search, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%");
            })
            ->when($request->status, function ($query, $status) {
                $query->where('status', $status);
            })
            ->when($request->start_date, function ($query, $start_date) {
                $query->whereDate('start_date', '>=', $start_date);
            })
            ->when($request->end_date, function ($query, $end_date) {
                $query->whereDate('end_date', '<=', $end_date);
            })
            ->latest()
            ->paginate(15);

        $data = [
            'activities' => TrainingProgramActivityResource::collection($activities),
            'search_params' => [
                'search' => $request->search,
                'status' => $request->status,
                'start_date' => $request->start_date,
                'end_date' => $request->end_date,
            ],
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/Index', $data);
    }

    /**
     * Show the form for creating a new activity.
     */
    public function create()
    {
        // Data will be loaded via AJAX endpoints for better performance
        $data = [
            'can_create' => true,
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/Create', $data);
    }

    /**
     * AJAX endpoint to get training programs for select
     */
    public function getTrainingPrograms(Request $request)
    {
        $query = TrainingProgram::where('status', 'ACTIVE');

        if ($request->has('search') && $request->search) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        $programs = $query->select(['id', 'uuid', 'name', 'description'])
            ->limit(50)
            ->get();

        return response()->json([
            'data' => $programs->map(function ($program) {
                return [
                    'value' => $program->uuid,
                    'label' => $program->name,
                    'description' => $program->description,
                ];
            })
        ]);
    }

    /**
     * AJAX endpoint to get approved submissions for select
     */
    public function getApprovedSubmissions(Request $request)
    {
        $query = Submission::with(['submitter.profile'])
            ->where('status', 'APPROVED');

        if ($request->has('search') && $request->search) {
            $query->where('reference_number', 'like', '%' . $request->search . '%');
        }

        $submissions = $query->select(['id', 'uuid', 'reference_number', 'datetime', 'submitter_id'])
            ->limit(50)
            ->get();

        return response()->json([
            'data' => $submissions->map(function ($submission) {
                return [
                    'value' => $submission->uuid,
                    'label' => ($submission->reference_number ?? 'No Ref') . ' - ' . ($submission->submitter->profile->name ?? 'Unknown'),
                    'title' => $submission->reference_number ?? 'No Reference',
                    'description' => 'Submission on ' . ($submission->datetime ? $submission->datetime->format('d/m/Y') : 'Unknown date'),
                    'start_date' => $submission->datetime ? $submission->datetime->format('Y-m-d') : null,
                    'end_date' => $submission->datetime ? $submission->datetime->format('Y-m-d') : null,
                    'submitter_name' => $submission->submitter->profile->name ?? 'Unknown',
                ];
            })
        ]);
    }

    /**
     * AJAX endpoint to get available participants for select
     */
    public function getAvailableParticipants(Request $request)
    {
        $query = Profile::with(['employee.position', 'employee.area'])
            ->whereHas('employee');

        if ($request->has('search') && $request->search) {
            $query->where(function ($q) use ($request) {
                $q->where('name', 'like', '%' . $request->search . '%')
                  ->orWhere('email', 'like', '%' . $request->search . '%')
                  ->orWhereHas('employee', function ($eq) use ($request) {
                      $eq->where('identity_number', 'like', '%' . $request->search . '%');
                  });
            });
        }

        $participants = $query->select(['id', 'uuid', 'name', 'email'])
            ->limit(100)
            ->get();

        return response()->json([
            'data' => $participants->map(function ($participant) {
                return [
                    'value' => $participant->uuid,
                    'label' => $participant->name . ' - ' . ($participant->employee->area->name ?? 'N/A'),
                    'name' => $participant->name,
                    'email' => $participant->email,
                    'area' => $participant->employee->area->name ?? 'N/A',
                    'position' => $participant->employee->position->name ?? 'N/A',
                ];
            })
        ]);
    }

    /**
     * Store a newly created activity.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'training_program_id' => 'nullable|string',
            'submission_id' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'status' => 'required|in:planned,ongoing,completed',
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'string',
        ], [
            'title.required' => 'Judul aktivitas wajib diisi',
            'start_date.required' => 'Tanggal mulai wajib diisi',
            'end_date.required' => 'Tanggal selesai wajib diisi',
            'end_date.after_or_equal' => 'Tanggal selesai harus sama atau setelah tanggal mulai',
            'status.required' => 'Status aktivitas wajib dipilih',
            'status.in' => 'Status aktivitas tidak valid',
            'participant_ids.required' => 'Minimal pilih 1 peserta',
            'participant_ids.min' => 'Minimal pilih 1 peserta',
            'participant_ids.*.string' => 'Format peserta tidak valid',
        ]);

        try {
            $activity = $this->activityService->createActivity($validated);

            return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                ->with('success', 'Training activity berhasil dibuat.');
        } catch (\InvalidArgumentException $e) {
            return back()->withInput()->withErrors(['general' => $e->getMessage()]);
        } catch (\Exception $e) {
            return back()->withInput()->withErrors(['general' => 'Terjadi kesalahan saat membuat training activity: ' . $e->getMessage()]);
        }
    }

    /**
     * Display the specified activity.
     */
    public function show($uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with([
                'trainingProgram.phases.modules.materials',
                'trainingProgram.phases.modules.quizzes',
                'trainingProgram.phases.modules.assessments',
                'submission',
                'creator',
                'participants.profile',
                'participants.phaseProgress.phase',
                'participants.moduleProgress.module',
                'participants.materialProgress',
                'participants.quizAttempts',
                'participants.assessmentResults',
            ])
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
        ];

        // dd($data);

        return Inertia::render('Office/QRD/TrainingProgramActivities/Show', $data);
    }

    /**
     * Show the form for editing activity.
     */
    public function edit($uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['trainingProgram', 'submission', 'participants.profile'])
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/Edit', $data);
    }

    /**
     * Update the specified activity.
     */
    public function update(Request $request, $uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'status' => 'required|in:planned,ongoing,completed,cancelled',
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'string',
        ]);

        try {
            $activity = $this->activityService->updateActivity($activity, $validated);

            return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                ->with('success', 'Training activity berhasil diperbarui.');
        } catch (\InvalidArgumentException $e) {
            return back()->withErrors(['general' => $e->getMessage()]);
        } catch (\Exception $e) {
            return back()->withInput()->withErrors(['general' => 'Terjadi kesalahan saat memperbarui training activity: ' . $e->getMessage()]);
        }
    }

    /**
     * Remove the specified activity.
     */
    public function destroy($uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        
        DB::beginTransaction();
        try {
            $activity->delete();
            DB::commit();
            
            return redirect()->route('office.qrd.activity.training-program-activity.index')
                ->with('success', 'Training activity berhasil dihapus.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat menghapus training activity.');
        }
    }

    /**
     * Show add participants form or handle add participants.
     */
    public function addParticipants(Request $request, $uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['participants.profile', 'activityTrainingProgram.phases.modules'])
            ->firstOrFail();

        // GET request - show form
        if ($request->isMethod('GET')) {
            // Get available employees (profiles with Employee role)
            $employees = Profile::with(['user', 'employee', 'employee.area'])
                ->whereHas('user', function ($query) {
                    $query->whereHas('roles', function ($q) {
                        $q->where('name', 'Employee');
                    });
                })
                ->get();

            $data = [
                'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
                'employees' => ProfileResource::collection($employees)->resolve(),
                'current_participants' => TrainingProgramActivityParticipantResource::collection($activity->participants)->resolve(),
            ];

            return Inertia::render('Office/QRD/TrainingProgramActivities/AddParticipants', $data);
        }

        // POST request - handle form submission
        $validated = $request->validate([
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'exists:profiles,id',
        ]);

        DB::beginTransaction();
        try {
            foreach ($validated['participant_ids'] as $profileId) {
                // Check if participant already exists
                $exists = $activity->participants()
                    ->where('profile_id', $profileId)
                    ->exists();

                if (!$exists) {
                    $participant = TrainingProgramActivityParticipant::create([
                        'activity_id' => $activity->id,
                        'profile_id' => $profileId,
                        'enrollment_date' => now(),
                    ]);

                    // Create initial progress records if activity has training program snapshot
                    if ($activity->activityTrainingProgram) {
                        $this->createInitialProgressRecordsWithSnapshot($participant, $activity);
                    }
                }
            }

            DB::commit();
            
            return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                ->with('success', 'Peserta berhasil ditambahkan.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat menambahkan peserta.');
        }
    }

    /**
     * Remove participant from activity.
     */
    public function removeParticipant($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        $participant = $activity->participants()->where('uuid', $participantUuid)->firstOrFail();

        try {
            $participant->delete();
            return back()->with('success', 'Peserta berhasil dihapus dari aktivitas.');
        } catch (\Exception $e) {
            return back()->with('error', 'Gagal menghapus peserta: ' . $e->getMessage());
        }
    }

    /**
     * Show participant detail.
     */
    public function participantDetail($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with([
                'activityTrainingProgram.phases.modules.materials',
                'activityTrainingProgram.phases.modules.quizzes', 
                'activityTrainingProgram.phases.modules.assessments',
                'trainingProgram.phases.modules.materials',
                'trainingProgram.phases.modules.quizzes',
                'trainingProgram.phases.modules.assessments'
            ])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('uuid', $participantUuid)
            ->with([
                'profile.employee.area',
                'profile.employee.position',
                'phaseProgress.activityPhase',
                'phaseProgress.masterPhase', 
                'moduleProgress.activityModule',
                'moduleProgress.masterModule',
                'materialProgress.activityMaterial',
                'materialProgress.masterMaterial',
                'quizAttempts.activityQuiz.questions.options',
                'quizAttempts.masterQuiz.questions.options',
                'quizAttempts.quiz.questions.options', // Legacy compatibility
                'quizAttempts.grader',
                'assessmentResults.activityAssessment.groupIndicators.indicators.sessions.rubrics',
                'assessmentResults.masterAssessment'
            ])
            ->firstOrFail();

        // Create initial progress if not exists and has training program using snapshot
        if ($activity->activityTrainingProgram && $participant->phaseProgress->isEmpty()) {
            $this->createInitialProgressRecordsWithSnapshot($participant, $activity);
            
            // Reload the participant with fresh data
            $participant = $activity->participants()
                ->where('uuid', $participantUuid)
                ->with([
                    'profile.employee.area',
                    'profile.employee.position',
                    'phaseProgress.activityPhase',
                    'phaseProgress.masterPhase',
                    'moduleProgress.activityModule', 
                    'moduleProgress.masterModule',
                    'materialProgress.activityMaterial',
                    'materialProgress.masterMaterial',
                    'quizAttempts.activityQuiz.questions.options',
                    'quizAttempts.masterQuiz.questions.options',
                    'quizAttempts.quiz.questions.options', // Legacy compatibility
                    'quizAttempts.grader',
                    'assessmentResults.activityAssessment.groupIndicators.indicators.sessions.rubrics',
                    'assessmentResults.masterAssessment'
                ])
                ->firstOrFail();
        }

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
        ];

        // dd($data);


        return Inertia::render('Office/QRD/TrainingProgramActivities/ParticipantDetail', $data);
    }

    /**
     * Get participants for select options.
     */
    public function optionParticipants(Request $request)
    {
        $profiles = Profile::query();

        if ($request->has('search')) {
            $profiles->where(function ($query) use ($request) {
                $query->where('name', 'like', '%' . $request->search . '%')
                    ->orWhere('employee_id', 'like', '%' . $request->search . '%');
            });
        }

        $profiles = $profiles->with('user')
            ->whereHas('user', function ($query) {
                $query->whereHas('roles', function ($q) {
                    $q->where('name', 'Employee');
                });
            })
            ->limit(20)
            ->get();

        return ProfileResource::collection($profiles);
    }

    /**
     * Create approved submission to activity.
     */
    public function createFromSubmission($submissionId)
    {
        try {
            $activity = $this->activityService->createFromSubmission($submissionId);

            return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                ->with('success', 'Training activity berhasil dibuat dari submission.');
        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan saat membuat training activity.');
        }
    }

    /**
     * Create initial progress records for participant using activity snapshots.
     */
    private function createInitialProgressRecordsWithSnapshot($participant, $activity)
    {
        try {
            DB::beginTransaction();
            
            \Log::info('Creating initial progress records with snapshot', [
                'participant_id' => $participant->id,
                'activity_id' => $activity->id,
            ]);

            $activityTrainingProgram = $activity->activityTrainingProgram;
            
            if (!$activityTrainingProgram) {
                \Log::warning('No activity snapshot found for activity', ['activity_id' => $activity->id]);
                return;
            }

            // Create phase progress records using activity snapshots
            foreach ($activityTrainingProgram->phases as $activityPhase) {
                // For old_phase_id, we need a valid training_program_phases.id
                // If master_phase_id is null, we cannot create progress record
                if (!$activityPhase->master_phase_id) {
                    \Log::warning('Skipping phase progress creation - no master_phase_id', [
                        'activity_phase_id' => $activityPhase->id,
                        'phase_name' => $activityPhase->name
                    ]);
                    continue;
                }

                $phaseProgress = $participant->phaseProgress()->create([
                    'activity_phase_id' => $activityPhase->id,
                    'master_phase_id' => $activityPhase->master_phase_id,
                    'old_phase_id' => $activityPhase->master_phase_id, // Both must reference training_program_phases table
                    'progress_percentage' => 0,
                    'started_at' => null,
                    'completed_at' => null,
                ]);

                \Log::info('Created phase progress with snapshot', [
                    'phase_progress_id' => $phaseProgress->id,
                    'activity_phase_id' => $activityPhase->id,
                    'master_phase_id' => $activityPhase->master_phase_id,
                    'old_phase_id' => $activityPhase->master_phase_id
                ]);

                // Create module progress records using activity snapshots
                foreach ($activityPhase->modules as $activityModule) {
                    // For old_module_id, we need a valid phase_modules.id
                    // If master_module_id is null, we cannot create progress record
                    if (!$activityModule->master_module_id) {
                        \Log::warning('Skipping module progress creation - no master_module_id', [
                            'activity_module_id' => $activityModule->id,
                            'module_name' => $activityModule->name
                        ]);
                        continue;
                    }

                    $moduleProgress = $participant->moduleProgress()->create([
                        'activity_module_id' => $activityModule->id,
                        'master_module_id' => $activityModule->master_module_id,
                        'old_module_id' => $activityModule->master_module_id, // Both must reference phase_modules table
                        'status' => 'NOT_STARTED',
                        'progress_percentage' => 0,
                        'started_at' => null,
                        'completed_at' => null,
                    ]);

                    \Log::info('Created module progress with snapshot', [
                        'module_progress_id' => $moduleProgress->id,
                        'activity_module_id' => $activityModule->id,
                        'master_module_id' => $activityModule->master_module_id,
                        'old_module_id' => $activityModule->master_module_id
                    ]);

                    // Create material progress records using activity snapshots
                    foreach ($activityModule->materials as $activityMaterial) {
                        // For old_material_id, we need a valid phase_module_materials.id
                        // If master_material_id is null, we cannot create progress record
                        if (!$activityMaterial->master_material_id) {
                            \Log::warning('Skipping material progress creation - no master_material_id', [
                                'activity_material_id' => $activityMaterial->id,
                                'material_title' => $activityMaterial->title
                            ]);
                            continue;
                        }

                        $materialProgress = $participant->materialProgress()->create([
                            'activity_material_id' => $activityMaterial->id,
                            'master_material_id' => $activityMaterial->master_material_id,
                            'old_material_id' => $activityMaterial->master_material_id, // Both must reference phase_module_materials table
                            'viewed_at' => null,
                            'completed_at' => null,
                            'time_spent' => 0,
                        ]);

                        \Log::info('Created material progress with snapshot', [
                            'material_progress_id' => $materialProgress->id,
                            'activity_material_id' => $activityMaterial->id,
                            'master_material_id' => $activityMaterial->master_material_id,
                            'old_material_id' => $activityMaterial->master_material_id
                        ]);
                    }
                }
            }

            DB::commit();
            \Log::info('Successfully created all initial progress records with snapshots');
            
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Failed to create initial progress records with snapshots', [
                'error' => $e->getMessage(),
                'participant_id' => $participant->id,
                'activity_id' => $activity->id,
            ]);
        }
    }

    /**
     * Create initial progress records for participant (legacy method for old system).
     */
    private function createInitialProgressRecords($participant, $trainingProgram)
    {
        try {
            DB::beginTransaction();
            
            \Log::info('Creating initial progress records', [
                'participant_id' => $participant->id,
                'training_program_id' => $trainingProgram->id,
                'phases_count' => $trainingProgram->phases->count(),
            ]);

            // Create phase progress records
            foreach ($trainingProgram->phases as $phase) {
                $phaseProgress = $participant->phaseProgress()->create([
                    'old_phase_id' => $phase->id,
                    'master_phase_id' => $phase->id,
                    'progress_percentage' => 0,
                    'started_at' => null,
                    'completed_at' => null,
                ]);

                \Log::info('Created phase progress', ['phase_progress_id' => $phaseProgress->id]);

                // Create module progress records
                foreach ($phase->modules as $module) {
                    $moduleProgress = $participant->moduleProgress()->create([
                        'old_module_id' => $module->id,
                        'master_module_id' => $module->id,
                        'status' => 'NOT_STARTED',
                        'progress_percentage' => 0,
                        'started_at' => null,
                        'completed_at' => null,
                    ]);

                    \Log::info('Created module progress', ['module_progress_id' => $moduleProgress->id]);

                    // Create material progress records
                    foreach ($module->materials as $material) {
                        $materialProgress = $participant->materialProgress()->create([
                            'old_material_id' => $material->id,
                            'master_material_id' => $material->id,
                            'viewed_at' => null,
                            'completed_at' => null,
                            'time_spent' => 0,
                        ]);

                        \Log::info('Created material progress', ['material_progress_id' => $materialProgress->id]);
                    }
                }
            }

            DB::commit();
            \Log::info('Successfully created all initial progress records');
            
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Failed to create initial progress records', [
                'error' => $e->getMessage(),
                'participant_id' => $participant->id,
                'training_program_id' => $trainingProgram->id,
            ]);
        }
    }

    /**
     * Show assessment input form.
     */
    public function inputAssessment($uuid, $participantUuid, $assessmentId)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['activityTrainingProgram'])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('uuid', $participantUuid)
            ->with(['profile'])
            ->firstOrFail();

        // Get assessment from activity snapshot
        $assessment = null;
        if ($activity->activityTrainingProgram) {
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

        // Get existing assessment result if any
        $existingResult = $participant->assessmentResults()
            ->where('activity_assessment_id', $assessmentId)
            ->first();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
            'assessment' => [
                'id' => $assessment->id,
                'title' => $assessment->title,
                'description' => $assessment->description,
                'calculation_method' => $assessment->calculation_method ?? 'AVERAGE',
                'passing_score' => $assessment->passing_score ?? 70,
                'module' => [
                    'name' => $assessment->activityModule->name,
                    'phase' => [
                        'name' => $assessment->activityModule->activityPhase->name
                    ]
                ],
                'group_indicators' => $assessment->groupIndicators->map(function ($group) {
                    return [
                        'id' => $group->id,
                        'name' => $group->name,
                        'description' => $group->description,
                        'indicators' => $group->indicators->map(function ($indicator) {
                            return [
                                'id' => $indicator->id,
                                'name' => $indicator->name,
                                'description' => $indicator->description,
                                'sessions' => $indicator->sessions->map(function ($session) {
                                    return [
                                        'id' => $session->id,
                                        'name' => $session->name,
                                        'description' => $session->description,
                                        'rubrics' => $session->rubrics->map(function ($rubric) {
                                            return [
                                                'id' => $rubric->id,
                                                'level' => $rubric->level,
                                                'description' => $rubric->description,
                                                'score' => $rubric->score,
                                                'order' => $rubric->order,
                                            ];
                                        })->sortBy('order')->values(),
                                    ];
                                }),
                            ];
                        }),
                    ];
                }),
            ],
            'existing_result' => $existingResult ? [
                'id' => $existingResult->id,
                'scores' => $existingResult->scores, // This will contain session_id => rubric_id
                'final_score' => $existingResult->final_score,
                'feedback' => $existingResult->feedback,
                'assessed_at' => $existingResult->assessed_at?->format('Y-m-d H:i:s'),
            ] : null,
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/InputAssessment', $data);
    }

    /**
     * Store assessment result.
     */
    public function storeAssessment(StoreAssessmentResultRequest $request, $uuid, $participantUuid, $assessmentId)
    {
        DB::beginTransaction();
        try {
            $activity = TrainingProgramActivity::where('uuid', $uuid)
                ->with(['activityTrainingProgram'])
                ->firstOrFail();

            $participant = $activity->participants()
                ->where('uuid', $participantUuid)
                ->firstOrFail();

            // Get assessment from activity snapshot
            $assessment = \App\Models\TrainingProgram\ActivityAssessment::where('id', $assessmentId)
                ->whereHas('activityModule.activityPhase', function ($query) use ($activity) {
                    $query->where('activity_training_program_id', $activity->activityTrainingProgram->id);
                })
                ->with(['groupIndicators.indicators.sessions.rubrics'])
                ->firstOrFail();

            // Get selected rubrics and calculate final score
            $selectedRubrics = $request->validated()['scores']; // session_id => rubric_id
            $sessionScores = [];
            
            foreach ($selectedRubrics as $sessionId => $rubricId) {
                // Find the rubric to get its score
                $rubric = \App\Models\TrainingProgram\ActivityAssessmentRubric::where('id', $rubricId)
                    ->where('activity_session_id', $sessionId)
                    ->first();
                
                if ($rubric) {
                    $sessionScores[$sessionId] = floatval($rubric->score);
                }
            }

            // Calculate final score based on assessment calculation method
            $calculationMethod = $assessment->calculation_method ?? 'AVERAGE';
            $finalScore = 0;
            
            if (!empty($sessionScores)) {
                switch ($calculationMethod) {
                    case 'SUM':
                        $finalScore = array_sum($sessionScores);
                        break;
                    case 'AVERAGE':
                    default:
                        $finalScore = array_sum($sessionScores) / count($sessionScores);
                        break;
                }
            }

            // Create or update assessment result
            $assessmentResult = \App\Models\TrainingProgram\TrainingProgramAssessmentResult::updateOrCreate(
                [
                    'participant_id' => $participant->id,
                    'activity_assessment_id' => $assessmentId,
                ],
                [
                    'old_assessment_id' => $assessment->master_assessment_id, // Reference to master assessment
                    'master_assessment_id' => $assessment->master_assessment_id, // Reference to master assessment
                    'assessor_id' => auth()->user()->profile->id,
                    'scores' => $selectedRubrics, // Store session_id => rubric_id mapping
                    'final_score' => $finalScore,
                    'feedback' => $request->validated()['feedback'] ?? null,
                    'assessed_at' => now(),
                ]
            );

            // Update module progress after assessment completion
            $this->participantService->updateProgressCalculations($participant);

            DB::commit();

            return redirect()
                ->route('office.qrd.activity.training-program-activity.participantDetail', [$uuid, $participantUuid])
                ->with('success', 'Assessment berhasil disimpan');

        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Failed to store assessment result', [
                'error' => $e->getMessage(),
                'activity_uuid' => $uuid,
                'participant_uuid' => $participantUuid,
                'assessment_id' => $assessmentId,
            ]);
            
            throw $e;
        }
    }

    /**
     * Show quiz grading interface.
     */
    public function gradeQuiz($uuid, $participantUuid, $attemptId)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['activityTrainingProgram'])
            ->firstOrFail();

        $participant = $activity->participants()
            ->where('uuid', $participantUuid)
            ->with(['profile'])
            ->firstOrFail();

        $attempt = $participant->quizAttempts()
            ->where('id', $attemptId)
            ->with(['activityQuiz.questions.options', 'masterQuiz.questions.options'])
            ->firstOrFail();

        // Get quiz and questions from activity snapshot or master
        $quiz = $attempt->activityQuiz ?? $attempt->masterQuiz;
        $questions = $quiz ? $quiz->questions : collect();

        // Prepare questions data with manual scores if already graded
        $questionsData = $questions->map(function ($question) use ($attempt) {
            $questionData = [
                'id' => $question->id,
                'question' => $question->question_text, // Use question_text as primary field
                'question_text' => $question->question_text,
                'type' => $question->type,
                'correct_answer' => $question->correct_answer,
                'explanation' => $question->explanation,
                'points' => $question->points,
                'options' => $question->options ? $question->options->map(function ($option) {
                    return [
                        'id' => $option->id,
                        'option_text' => $option->option_text,
                        'text' => $option->option_text, // Use option_text as primary field
                        'is_correct' => (bool) $option->is_correct,
                    ];
                })->toArray() : [],
                'manual_score' => 0, // Default score
            ];

            // If already graded, get the manual score for this question
            if ($attempt->manual_scores && isset($attempt->manual_scores[$question->id])) {
                $questionData['manual_score'] = $attempt->manual_scores[$question->id];
            }

            return $questionData;
        })->toArray();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
            'attempt' => [
                'id' => $attempt->id,
                'attempt_number' => $attempt->attempt_number,
                'started_at' => $attempt->started_at?->format('Y-m-d H:i:s'),
                'completed_at' => $attempt->completed_at?->format('Y-m-d H:i:s'),
                'score' => $attempt->score,
                'passed' => $attempt->passed,
                'answers' => $attempt->answers,
                'graded_at' => $attempt->graded_at?->format('Y-m-d H:i:s'),
                'grader_feedback' => $attempt->grader_feedback,
                'manual_scores' => $attempt->manual_scores,
            ],
            'quiz' => [
                'id' => $quiz->id,
                'title' => $quiz->title,
                'description' => $quiz->description,
                'passing_score' => $quiz->passing_score,
                'time_limit' => $quiz->time_limit,
            ],
            'questions' => $questionsData,
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/GradeQuiz', $data);
    }

    /**
     * Store quiz grading results.
     */
    public function storeQuizGrade($uuid, $participantUuid, $attemptId, Request $request)
    {
        DB::beginTransaction();
        try {
            $activity = TrainingProgramActivity::where('uuid', $uuid)
                ->firstOrFail();

            $participant = $activity->participants()
                ->where('uuid', $participantUuid)
                ->firstOrFail();

            $attempt = $participant->quizAttempts()
                ->where('id', $attemptId)
                ->firstOrFail();

            // Validate input
            $validated = $request->validate([
                'scores' => 'required|array',
                'scores.*' => 'numeric|min:0|max:100',
                'total_score' => 'required|numeric|min:0|max:100',
                'feedback' => 'nullable|string|max:1000',
            ]);

            // Calculate final score and determine pass/fail
            $finalScore = $validated['total_score'];
            $quiz = $attempt->activityQuiz ?? $attempt->masterQuiz;
            $passingScore = $quiz ? $quiz->passing_score : 70;
            $passed = $finalScore >= $passingScore;

            // Update attempt with manual grading
            $attempt->update([
                'score' => $finalScore,
                'passed' => $passed,
                'graded_at' => now(),
                'grader_id' => auth()->user()->profile->id,
                'grader_feedback' => $validated['feedback'],
                'manual_scores' => $validated['scores'],
            ]);

            // Update module progress after manual grading
            $this->participantService->updateProgressCalculations($participant);

            DB::commit();

            return redirect()
                ->route('office.qrd.activity.training-program-activity.participantDetail', [$uuid, $participantUuid])
                ->with('success', 'Penilaian quiz berhasil disimpan');

        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Failed to store quiz grade', [
                'error' => $e->getMessage(),
                'activity_uuid' => $uuid,
                'participant_uuid' => $participantUuid,
                'attempt_id' => $attemptId,
            ]);
            
            return back()->withErrors(['error' => 'Terjadi kesalahan saat menyimpan penilaian quiz.']);
        }
    }

    /**
     * Issue certificate for participant.
     */
    public function issueCertificate($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        $participant = $activity->participants()->where('uuid', $participantUuid)->firstOrFail();

        if ($participant->certificate_issued) {
            return back()->with('error', 'Sertifikat sudah diterbitkan untuk peserta ini.');
        }

        if ($participant->overall_progress < 100) {
            return back()->with('error', 'Peserta belum menyelesaikan pelatihan (progress < 100%).');
        }

        try {
            $participant->issueCertificate();
            return back()->with('success', 'Sertifikat berhasil diterbitkan untuk ' . $participant->profile->name);
        } catch (\Exception $e) {
            return back()->with('error', 'Gagal menerbitkan sertifikat: ' . $e->getMessage());
        }
    }

    /**
     * Revoke certificate for participant.
     */
    public function revokeCertificate($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        $participant = $activity->participants()->where('uuid', $participantUuid)->firstOrFail();

        if (!$participant->certificate_issued) {
            return back()->with('error', 'Peserta belum memiliki sertifikat.');
        }

        try {
            $participant->update([
                'certificate_issued' => false,
                'certificate_number' => null,
            ]);

            return back()->with('success', 'Sertifikat berhasil dicabut untuk ' . $participant->profile->name);
        } catch (\Exception $e) {
            return back()->with('error', 'Gagal mencabut sertifikat: ' . $e->getMessage());
        }
    }

    /**
     * View participant certificate.
     */
    public function viewParticipantCertificate($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['trainingProgram.phases.modules'])
            ->firstOrFail();
            
        $participant = $activity->participants()
            ->with(['profile'])
            ->where('uuid', $participantUuid)
            ->where('certificate_issued', true)
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity)->resolve(),
            'participant' => TrainingProgramActivityParticipantResource::make($participant)->resolve(),
        ];

        return Inertia::render('Office/QRD/TrainingProgramActivities/ParticipantCertificate', $data);
    }

    /**
     * Download participant certificate PDF.
     */
    public function downloadParticipantCertificate($uuid, $participantUuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        $participant = $activity->participants()
            ->with(['profile'])
            ->where('uuid', $participantUuid)
            ->where('certificate_issued', true)
            ->firstOrFail();

        // Generate PDF certificate
        // This would typically use a PDF library like DomPDF or TCPDF
        return response()->download(
            public_path('certificates/certificate-template.pdf'),
            "certificate-{$activity->title}-{$participant->profile->name}.pdf"
        );
    }

    /**
     * Update activity status.
     */
    public function updateStatus(Request $request, $uuid)
    {
        $request->validate([
            'status' => 'required|in:planned,ongoing,completed,cancelled'
        ]);

        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        
        // Validate status transition
        $currentStatus = strtolower($activity->status);
        $newStatus = strtolower($request->status);
        
        $validTransitions = [
            'planned' => ['ongoing', 'cancelled'],
            'ongoing' => ['completed', 'cancelled'],
            'completed' => [], // Cannot change from completed
            'cancelled' => [] // Cannot change from cancelled
        ];
        
        if (!in_array($newStatus, $validTransitions[$currentStatus])) {
            return back()->with('error', 'Transisi status tidak valid.');
        }

        try {
            $activity->update([
                'status' => strtoupper($newStatus)
            ]);

            $statusLabels = [
                'planned' => 'Direncanakan',
                'ongoing' => 'Sedang Berlangsung', 
                'completed' => 'Selesai',
                'cancelled' => 'Dibatalkan'
            ];

            return back()->with('success', 'Status aktivitas berhasil diubah menjadi ' . $statusLabels[$newStatus]);
        } catch (\Exception $e) {
            return back()->with('error', 'Gagal mengubah status aktivitas: ' . $e->getMessage());
        }
    }

    public function storeParticipants(Request $request, string $uuid): RedirectResponse
    {
        $request->validate([
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'required|string|exists:profiles,uuid',
        ], [
            'participant_ids.required' => 'Anda harus memilih setidaknya satu peserta.',
            'participant_ids.min' => 'Anda harus memilih setidaknya satu peserta.',
            'participant_ids.*.exists' => 'Salah satu peserta yang dipilih tidak valid.',
        ]);
    
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();
        
        DB::beginTransaction();
        try {
            $participantUuids = $request->input('participant_ids');
            $profiles = Profile::whereIn('uuid', $participantUuids)->get();
            
            $existingParticipantProfileIds = $activity->participants()->pluck('profile_id')->toArray();
            
            $newParticipants = [];
            foreach ($profiles as $profile) {
                if (!in_array($profile->id, $existingParticipantProfileIds)) {
                    $newParticipants[] = [
                        'activity_id' => $activity->id,
                        'profile_id' => $profile->id,
                        'enrollment_date' => now(),
                        'overall_progress' => 0,
                        'created_at' => now(),
                        'updated_at' => now(),
                        'uuid' => Str::uuid(),
                    ];
                }
            }
    
            if (empty($newParticipants)) {
                DB::rollBack();
                return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                    ->with('warning', 'Tidak ada peserta baru yang ditambahkan. Semua sudah terdaftar.');
            }
    
            TrainingProgramActivityParticipant::insert($newParticipants);
            
            $newParticipantProfileIds = collect($newParticipants)->pluck('profile_id')->toArray();
            $newlyAddedParticipants = TrainingProgramActivityParticipant::with('profile')
                ->where('activity_id', $activity->id)
                ->whereIn('profile_id', $newParticipantProfileIds)
                ->get();
    
            foreach ($newlyAddedParticipants as $participant) {
                // This private method is in the same controller
                $this->createInitialProgressRecordsWithSnapshot($participant, $activity);
            }
    
            DB::commit();
    
            return redirect()->route('office.qrd.activity.training-program-activity.show', $activity->uuid)
                ->with('success', count($newParticipants) . ' peserta berhasil ditambahkan.');
    
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Error adding participants: ' . $e->getMessage() . ' at ' . $e->getFile() . ':' . $e->getLine());
            return back()->withErrors(['error' => 'Gagal menambahkan peserta: ' . $e->getMessage()]);
        }
    }
}