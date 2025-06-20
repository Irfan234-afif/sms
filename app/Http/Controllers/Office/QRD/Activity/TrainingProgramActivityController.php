<?php

namespace App\Http\Controllers\Office\QRD\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\TrainingProgram\TrainingProgramActivityResource;
use App\Http\Resources\TrainingProgram\TrainingProgramResource;
use App\Http\Resources\ProfileResource;
use App\Models\Profile;
use App\Models\Submission;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class TrainingProgramActivityController extends Controller
{
    /**
     * Display a listing of activities.
     */
    public function index(Request $request)
    {
        $activities = TrainingProgramActivity::query();

        // Search
        if ($request->has('search')) {
            $activities->where(function ($query) use ($request) {
                $query->where('title', 'like', '%' . $request->search . '%')
                    ->orWhere('description', 'like', '%' . $request->search . '%')
                    ->orWhere('location', 'like', '%' . $request->search . '%')
                    ->orWhere('external_provider', 'like', '%' . $request->search . '%');
            });
        }

        // Status filter
        if ($request->has('status') && $request->status !== '') {
            $activities->where('status', $request->status);
        }

        // Date range filter
        if ($request->has('start_date') && $request->start_date !== '') {
            $activities->whereDate('start_date', '>=', $request->start_date);
        }
        
        if ($request->has('end_date') && $request->end_date !== '') {
            $activities->whereDate('end_date', '<=', $request->end_date);
        }

        $activities = $activities->with(['trainingProgram', 'submission', 'creator', 'participants.profile'])
            ->withCount('participants')
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

        return Inertia::render('Office/QRD/Activity/TrainingProgramActivity/Index', $data);
    }

    /**
     * Show the form for creating a new activity.
     */
    public function create()
    {
        $data = [
            'training_programs' => TrainingProgramResource::collection(
                TrainingProgram::where('status', 'ACTIVE')->get()
            ),
        ];

        return Inertia::render('Office/QRD/Activity/TrainingProgramActivity/Create', $data);
    }

    /**
     * Store a newly created activity.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'training_program_id' => 'nullable|exists:training_programs,id',
            'submission_id' => 'nullable|exists:submissions,id',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'location' => 'nullable|string|max:255',
            'external_provider' => 'nullable|string|max:255',
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'exists:profiles,id',
        ]);

        DB::beginTransaction();
        try {
            // Determine status based on dates
            $today = now()->startOfDay();
            $startDate = \Carbon\Carbon::parse($validated['start_date']);
            $endDate = \Carbon\Carbon::parse($validated['end_date']);
            
            $status = 'PLANNED';
            if ($startDate->isPast() && $endDate->isFuture()) {
                $status = 'ONGOING';
            } elseif ($endDate->isPast()) {
                $status = 'COMPLETED';
            }

            // Create activity
            $activity = TrainingProgramActivity::create([
                'title' => $validated['title'],
                'description' => $validated['description'],
                'training_program_id' => $validated['training_program_id'],
                'submission_id' => $validated['submission_id'],
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'],
                'location' => $validated['location'],
                'external_provider' => $validated['external_provider'],
                'status' => $status,
                'created_by' => auth()->user()->profile->id,
            ]);

            // Add participants
            foreach ($validated['participant_ids'] as $profileId) {
                $participant = TrainingProgramActivityParticipant::create([
                    'activity_id' => $activity->id,
                    'profile_id' => $profileId,
                    'enrollment_date' => now(),
                ]);

                // If training program is set, create initial progress records
                if ($activity->training_program_id) {
                    $this->createInitialProgressRecords($participant, $activity->trainingProgram);
                }
            }

            DB::commit();

            return redirect()->route('office.qrd.activity.trainingProgramActivity.show', $activity->uuid)
                ->with('success', 'Training activity berhasil dibuat.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat membuat training activity.');
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
            'activity' => TrainingProgramActivityResource::make($activity),
        ];

        return Inertia::render('Office/QRD/Activity/TrainingProgramActivity/Show', $data);
    }

    /**
     * Show the form for editing activity.
     */
    public function edit($uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)
            ->with(['trainingProgram', 'participants.profile'])
            ->firstOrFail();

        $data = [
            'activity' => TrainingProgramActivityResource::make($activity),
            'training_programs' => TrainingProgramResource::collection(
                TrainingProgram::where('status', 'ACTIVE')->get()
            ),
        ];

        return Inertia::render('Office/QRD/Activity/TrainingProgramActivity/Edit', $data);
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
            'location' => 'nullable|string|max:255',
            'external_provider' => 'nullable|string|max:255',
            'status' => 'required|in:PLANNED,ONGOING,COMPLETED',
        ]);

        $activity->update($validated);

        return redirect()->route('office.qrd.activity.trainingProgramActivity.show', $activity->uuid)
            ->with('success', 'Training activity berhasil diperbarui.');
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
            
            return redirect()->route('office.qrd.activity.trainingProgramActivity.index')
                ->with('success', 'Training activity berhasil dihapus.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat menghapus training activity.');
        }
    }

    /**
     * Add participants to activity.
     */
    public function addParticipants(Request $request, $uuid)
    {
        $activity = TrainingProgramActivity::where('uuid', $uuid)->firstOrFail();

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

                    // Create initial progress records if training program is set
                    if ($activity->training_program_id) {
                        $this->createInitialProgressRecords($participant, $activity->trainingProgram);
                    }
                }
            }

            DB::commit();
            
            return back()->with('success', 'Peserta berhasil ditambahkan.');
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

        DB::beginTransaction();
        try {
            $participant->delete();
            DB::commit();
            
            return back()->with('success', 'Peserta berhasil dihapus.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat menghapus peserta.');
        }
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
        $submission = Submission::with(['trainingProgramSubmission.participants'])
            ->where('id', $submissionId)
            ->where('status', 'APPROVED')
            ->whereHas('trainingProgramSubmission')
            ->firstOrFail();

        $trainingSubmission = $submission->trainingProgramSubmission;

        DB::beginTransaction();
        try {
            // Create activity from submission
            $activity = TrainingProgramActivity::create([
                'title' => $trainingSubmission->training_name,
                'description' => $trainingSubmission->description,
                'training_program_id' => $trainingSubmission->training_program_id,
                'submission_id' => $submission->id,
                'start_date' => $trainingSubmission->start_date,
                'end_date' => $trainingSubmission->end_date,
                'location' => $trainingSubmission->location,
                'external_provider' => $trainingSubmission->external_provider,
                'status' => 'PLANNED',
                'created_by' => auth()->user()->profile->id,
            ]);

            // Add participants from submission
            foreach ($trainingSubmission->participants as $submissionParticipant) {
                $participant = TrainingProgramActivityParticipant::create([
                    'activity_id' => $activity->id,
                    'profile_id' => $submissionParticipant->profile_id,
                    'enrollment_date' => now(),
                ]);

                // Create initial progress records if internal training
                if ($activity->training_program_id) {
                    $this->createInitialProgressRecords($participant, $activity->trainingProgram);
                }
            }

            DB::commit();

            return redirect()->route('office.qrd.activity.trainingProgramActivity.show', $activity->uuid)
                ->with('success', 'Training activity berhasil dibuat dari submission.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Terjadi kesalahan saat membuat training activity.');
        }
    }

    /**
     * Create initial progress records for participant.
     */
    private function createInitialProgressRecords($participant, $trainingProgram)
    {
        // Create phase progress records
        foreach ($trainingProgram->phases as $phase) {
            $participant->phaseProgress()->create([
                'phase_id' => $phase->id,
                'progress_percentage' => 0,
            ]);

            // Create module progress records
            foreach ($phase->modules as $module) {
                $participant->moduleProgress()->create([
                    'module_id' => $module->id,
                    'status' => 'NOT_STARTED',
                    'progress_percentage' => 0,
                ]);

                // Create material progress records
                foreach ($module->materials as $material) {
                    $participant->materialProgress()->create([
                        'material_id' => $material->id,
                        'time_spent' => 0,
                    ]);
                }
            }
        }
    }
}