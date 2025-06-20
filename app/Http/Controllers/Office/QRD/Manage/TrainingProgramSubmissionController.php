<?php

namespace App\Http\Controllers\Office\QRD\Manage;

use App\Http\Controllers\Controller;
use App\Http\Resources\TrainingProgramSubmissionResource;
use App\Http\Requests\TrainingProgram\StoreTrainingProgramSubmissionRequest;
use App\Http\Requests\TrainingProgram\UpdateTrainingProgramSubmissionRequest;
use App\Models\TrainingProgram\TrainingProgramSubmission;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\Employee;
use App\Models\Profile;
use App\Models\Area;
use App\Models\SubmissionGroup;
use App\Models\Submission;
use App\Models\SubmissionApprover;
use App\Models\SubmissionApproval;
use App\Services\SubmissionUpdateService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Arr;
use Inertia\Inertia;
use App\Services\SubmissionStoreService;
use App\Models\Student;
use App\Models\StudentGuardian;

class TrainingProgramSubmissionController extends Controller
{
    /**
     * Display a listing of training program submissions.
     */
    public function index()
    {
        $submissions = TrainingProgramSubmission::query();

        // Apply search filters
        if (request()->has('search')) {
            $submissions->where(function ($query) {
                $query->where('reference_number', 'like', '%' . request('search') . '%')
                      ->orWhere('title', 'like', '%' . request('search') . '%')
                      ->orWhere('provider', 'like', '%' . request('search') . '%');
            });
        }

        // Filter by status
        if (request()->has('status') && request('status') !== '') {
            $submissions->whereHas('submission', function ($query) {
                $query->where('status', request('status'));
            });
        }

        // Filter by training type
        if (request()->has('training_type') && request('training_type') !== '') {
            $submissions->where('training_type', request('training_type'));
        }

        $submissions = $submissions->with([
            'submitter.profile',
            'submission.area',
            'trainingProgram',
            'participants.participant' => function ($query) {
                $query->morphWith([
                    Employee::class => ['profile', 'assignment.area', 'assignment.position'],
                    Student::class => ['profile', 'school', 'grade'],
                    StudentGuardian::class => ['profile', 'students.profile'],
                ]);
            },
            'goals',
            'budgetItems',
            'attachments'
        ])->latest()->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
                'status' => request('status'),
                'training_type' => request('training_type'),
            ],
            'submissions' => TrainingProgramSubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/QRD/TrainingProgramSubmissions/Index', $data);
    }

    /**
     * Show the form for creating a new training program submission.
     */
    public function create()
    {
        return Inertia::render('Office/QRD/TrainingProgramSubmissions/Form');
    }

    /**
     * Store a newly created training program submission.
     */
    public function store(StoreTrainingProgramSubmissionRequest $request)
    {
        DB::beginTransaction();

        try {
            $validated = $request->validated();
            
            // Get submitter employee - use consistent pattern
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            // Use SubmissionStoreService for consistency
            $submissionService = new SubmissionStoreService('TRAINING_PROGRAM', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                return redirect()->back()->withErrors([
                    'area' => 'Anda belum ditempatkan di area manapun.'
                ]);
            }

            // Create main submission using service
            $mainSubmission = $submissionService->createSubmission();

            // Create training program submission
            $submission = TrainingProgramSubmission::create([
                'submission_id' => $mainSubmission->id,
                'submitter_id' => $submitter->id,
                'reference_number' => $mainSubmission->reference_number,
                'training_type' => $validated['training_type'],
                'training_program_id' => $validated['training_program_id'] ?? null,
                'external_training_title' => $validated['external_training_title'] ?? null,
                'external_training_provider' => $validated['external_training_provider'] ?? null,
                'external_training_location' => $validated['external_training_location'] ?? null,
                'external_training_method' => $validated['external_training_method'] ?? null,
                'external_training_description' => $validated['external_training_description'] ?? null,
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'],
                'daily_start_time' => $validated['daily_start_time'],
                'daily_end_time' => $validated['daily_end_time'],
                'training_days' => $validated['training_days'] ?? null,
                'justification' => $validated['justification'] ?? null,
                'expected_outcomes' => $validated['expected_outcomes'] ?? null,
                'datetime' => $mainSubmission->datetime,
            ]);

            // Create goals
            if (isset($validated['goals'])) {
                foreach ($validated['goals'] as $goalData) {
                    $submission->goals()->create([
                        'goal_type' => $goalData['goal_type'],
                        'description' => $goalData['description'],
                        'success_indicator' => $goalData['success_indicator'],
                        'order' => $goalData['order'],
                    ]);
                }
            }

            // Create budget items
            if (isset($validated['budget_items'])) {
                foreach ($validated['budget_items'] as $budgetData) {
                    $submission->budgetItems()->create([
                        'category' => $budgetData['category'],
                        'item_name' => $budgetData['item_name'],
                        'description' => $budgetData['description'] ?? null,
                        'quantity' => $budgetData['quantity'],
                        'unit_price' => $budgetData['unit_price'],
                        // total_price will be calculated by observer
                    ]);
                }
            }

            // Create participants
            if (isset($validated['participants'])) {
                foreach ($validated['participants'] as $participantData) {
                    // Convert participant type to model class
                    $participantType = match($participantData['participant_type']) {
                        'employee' => Employee::class,
                        'student' => Student::class, 
                        'student_guardian' => StudentGuardian::class,
                        default => null,
                    };

                    if ($participantType) {
                        $submission->participants()->create([
                            'participant_type' => $participantType,
                            'participant_id' => $participantData['participant_id'],
                            'is_primary_participant' => $participantData['is_primary_participant'] ?? false,
                            'role_description' => $participantData['role_description'] ?? null,
                            'selection_reason' => $participantData['selection_reason'] ?? null,
                        ]);
                    }
                }
            }

            // Handle file attachments
            if (isset($validated['attachments'])) {
                foreach ($validated['attachments'] as $attachmentData) {
                    if (isset($attachmentData['file'])) {
                        $file = $attachmentData['file'];
                        $filename = time() . '_' . $file->getClientOriginalName();
                        $path = $file->storeAs('training-program-submissions/' . $submission->uuid, $filename, 'public');

                        $submission->attachments()->create([
                            'attachment_type' => $attachmentData['attachment_type'],
                            'description' => $attachmentData['description'] ?? null,
                            'file_name' => $filename,
                            'file_path' => $path,
                            'file_size' => $file->getSize(),
                            'file_type' => $file->getClientMimeType(),
                        ]);
                    }
                }
            }

            DB::commit();

            return redirect()->route('office.qrd.manage.training-program-submission.show', $submission->uuid)
                ->with('success', 'Pengajuan training program berhasil dibuat.');

        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withErrors([
                'error' => $th->getMessage()
            ]);
        }
    }

    /**
     * Display the specified training program submission.
     */
    public function show($uuid)
    {
        $submission = TrainingProgramSubmission::where('uuid', $uuid)
            ->with([
                'submitter.profile',
                'submission.area',
                'trainingProgram.phases.modules',
                'participants.participant' => function ($query) {
                    $query->morphWith([
                        Employee::class => ['profile', 'assignment.area', 'assignment.position'],
                        Student::class => ['profile', 'school', 'grade'],
                        StudentGuardian::class => ['profile', 'students.profile'],
                    ]);
                },
                'goals',
                'budgetItems',
                'attachments',
                'approvals.approver.profile',
                'approvals.delegate.profile'
            ])
            ->firstOrFail();

        $data = [
            'submission' => TrainingProgramSubmissionResource::make($submission)->toArray(request()),
        ];

        return Inertia::render('Office/QRD/TrainingProgramSubmissions/Show', $data);
    }

    /**
     * Show the form for editing the training program submission.
     */
    public function edit($uuid)
    {
        $submission = TrainingProgramSubmission::where('uuid', $uuid)
            ->with([
                'submitter.profile',
                'submission.area',
                'trainingProgram',
                'participants.participant' => function ($query) {
                    $query->morphWith([
                        Employee::class => ['profile', 'assignment.area', 'assignment.position'],
                        Student::class => ['profile', 'school', 'grade'],
                        StudentGuardian::class => ['profile', 'students.profile'],
                    ]);
                },
                'goals',
                'budgetItems',
                'attachments'
            ])
            ->firstOrFail();

        // Only allow editing if status is draft
        if ($submission->submission->status !== 'DRAFT') {
            return redirect()->back()->with('error', 'Hanya pengajuan dengan status draft yang dapat diedit.');
        }

        $data = [
            'submission' => TrainingProgramSubmissionResource::make($submission)->toArray(request()),
        ];

        return Inertia::render('Office/QRD/TrainingProgramSubmissions/Form', $data);
    }

    /**
     * Update the specified training program submission.
     */
    public function update(UpdateTrainingProgramSubmissionRequest $request, $uuid)
    {
        DB::beginTransaction();

        try {
            $submission = TrainingProgramSubmission::where('uuid', $uuid)
                ->with('submission')
                ->firstOrFail();
            
            // Only allow updating if status is draft
            if ($submission->submission && $submission->submission->status !== 'DRAFT') {
                return redirect()->back()->withErrors([
                    'status' => 'Hanya pengajuan dengan status draft yang dapat diubah.'
                ]);
            }

            $validated = $request->validated();

            $submissionService = new SubmissionUpdateService($submission->submission_id);
            $submissionService->updateSubmission();

            // Update main submission
            $submission->update([
                'training_type' => $validated['training_type'],
                'training_program_id' => $validated['training_program_id'] ?? null,
                'external_training_title' => $validated['external_training_title'] ?? null,
                'external_training_provider' => $validated['external_training_provider'] ?? null,
                'external_training_location' => $validated['external_training_location'] ?? null,
                'external_training_method' => $validated['external_training_method'] ?? null,
                'external_training_description' => $validated['external_training_description'] ?? null,
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'],
                'daily_start_time' => $validated['daily_start_time'],
                'daily_end_time' => $validated['daily_end_time'],
                'training_days' => $validated['training_days'] ?? null,
                'justification' => $validated['justification'] ?? null,
                'expected_outcomes' => $validated['expected_outcomes'] ?? null,
            ]);

            // Update goals
            if (isset($validated['goals'])) {
                $submission->goals()->delete();
                foreach ($validated['goals'] as $goalData) {
                    $submission->goals()->create([
                        'goal_type' => $goalData['goal_type'],
                        'description' => $goalData['description'],
                        'success_indicator' => $goalData['success_indicator'],
                        'order' => $goalData['order'],
                    ]);
                }
            }

            // Update budget items
            if (isset($validated['budget_items'])) {
                $submission->budgetItems()->delete();
                foreach ($validated['budget_items'] as $budgetData) {
                    $submission->budgetItems()->create([
                        'category' => $budgetData['category'],
                        'item_name' => $budgetData['item_name'],
                        'description' => $budgetData['description'] ?? null,
                        'quantity' => $budgetData['quantity'],
                        'unit_price' => $budgetData['unit_price'],
                    ]);
                }
            }

            // Update participants
            if (isset($validated['participants'])) {
                $submission->participants()->delete();
                foreach ($validated['participants'] as $participantData) {
                    // Convert participant type to model class
                    $participantType = match($participantData['participant_type']) {
                        'employee' => Employee::class,
                        'student' => Student::class,
                        'student_guardian' => StudentGuardian::class,
                        default => null,
                    };

                    if ($participantType) {
                        $submission->participants()->create([
                            'participant_type' => $participantType,
                            'participant_id' => $participantData['participant_id'],
                            'is_primary_participant' => $participantData['is_primary_participant'] ?? false,
                            'role_description' => $participantData['role_description'] ?? null,
                            'selection_reason' => $participantData['selection_reason'] ?? null,
                        ]);
                    }
                }
            }

            // Handle new file attachments
            if (isset($validated['attachments'])) {
                foreach ($validated['attachments'] as $attachmentData) {
                    if (isset($attachmentData['file'])) {
                        $file = $attachmentData['file'];
                        $filename = time() . '_' . $file->getClientOriginalName();
                        $path = $file->storeAs('training-program-submissions/' . $submission->uuid, $filename, 'public');

                        $submission->attachments()->create([
                            'attachment_type' => $attachmentData['attachment_type'],
                            'description' => $attachmentData['description'] ?? null,
                            'file_name' => $filename,
                            'file_path' => $path,
                            'file_size' => $file->getSize(),
                            'file_type' => $file->getClientMimeType(),
                        ]);
                    }
                }
            }

            DB::commit();

            return redirect()->back()->with('success', 'Pengajuan training program berhasil diperbarui.');

        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withErrors([
                'error' => $th->getMessage()
            ]);
        }
    }

    /**
     * Update the status of the training program submission.
     */
    public function updateStatus($uuid)
    {
        DB::beginTransaction();
        try {
            $submission = TrainingProgramSubmission::where('uuid', $uuid)
            ->with('submission')
            ->firstOrFail();
            
            $submissionService = new SubmissionUpdateService($submission->submission->uuid);
            $submissionService->updateSubmission();
            
            DB::commit();
            return redirect()->back()->with('success', 'Status pengajuan training program berhasil diperbarui.');
        } catch (\Throwable $th) {
            DB::rollBack();
            return redirect()->back()->withErrors([
                'error' => $th->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified training program submission.
     */
    public function destroy($uuid)
    {
        DB::beginTransaction();

        try {
            $submission = TrainingProgramSubmission::where('uuid', $uuid)
                ->with('submission')
                ->firstOrFail();

            // Only allow deletion if status is draft or cancelled
            $allowedStatuses = ['DRAFT', 'CANCELLED'];
            if (!in_array($submission->submission->status ?? 'DRAFT', $allowedStatuses)) {
                return redirect()->back()->withErrors([
                    'status' => 'Hanya pengajuan dengan status draft atau cancelled yang dapat dihapus.'
                ]);
            }

            $submission->delete();

            DB::commit();

            return redirect()->route('office.qrd.manage.training-program-submissions.index')
                ->with('success', 'Pengajuan training program berhasil dihapus.');

        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withErrors([
                'error' => $th->getMessage()
            ]);
        }
    }

    /**
     * Get options for training programs.
     */
    public function optionTrainingPrograms()
    {
        $programs = TrainingProgram::where('status', 'active');

        if (request()->has('search')) {
            $programs->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(
            $programs->select('id', 'name', 'type', 'level')
                    ->latest()
                    ->get()
                    ->map(function ($program) {
                        return [
                            'value' => $program->id,
                            'label' => $program->name . ' (' . $program->type . ' - ' . $program->level . ')',
                            'name' => $program->name,
                            'type' => $program->type,
                            'level' => $program->level,
                        ];
                    })
        );
    }

    /**
     * Get options for participants based on type.
     */
    public function optionParticipants()
    {
        $type = request('type', 'employee');
        $search = request('search', '');

        $results = match($type) {
            'employee' => $this->getEmployeeOptions($search),
            'student' => $this->getStudentOptions($search),
            'student_guardian' => $this->getStudentGuardianOptions($search),
            default => collect([]),
        };

        return response()->json($results);
    }

    /**
     * Get employee options for participants.
     */
    private function getEmployeeOptions($search)
    {
        $employees = Employee::with(['profile', 'assignment.area', 'assignment.position']);

        if (!empty($search)) {
            $employees->whereHas('profile', function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%');
            });
        }

        return $employees->latest()
            ->get()
            ->map(function ($employee) {
                return [
                    'value' => $employee->id,
                    'label' => $employee->profile?->name,
                    'email' => $employee->profile?->email,
                    'phone' => $employee->profile?->phone,
                    'position' => $employee->assignment?->position?->name,
                    'area' => $employee->assignment?->area?->name,
                ];
            });
    }

    /**
     * Get student options for participants.
     */
    private function getStudentOptions($search)
    {
        $students = Student::with(['profile', 'school', 'grade']);

        if (!empty($search)) {
            $students->whereHas('profile', function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%');
            });
        }

        return $students->latest()
            ->get()
            ->map(function ($student) {
                return [
                    'value' => $student->id,
                    'label' => $student->profile?->name,
                    'email' => $student->profile?->email,
                    'phone' => $student->profile?->phone,
                    'school' => $student->school?->name,
                    'grade' => $student->grade?->name,
                ];
            });
    }

    /**
     * Get student guardian options for participants.
     */
    private function getStudentGuardianOptions($search)
    {
        $guardians = StudentGuardian::with(['profile', 'student.profile']);

        if (!empty($search)) {
            $guardians->whereHas('profile', function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%');
            });
        }

        return $guardians->latest()
            ->get()
            ->map(function ($guardian) {
                $studentNames = $guardian->getAllStudents()->pluck('profile.name')->implode(', ');
                return [
                    'value' => $guardian->id,
                    'label' => $guardian->profile?->name,
                    'email' => $guardian->profile?->email,
                    'phone' => $guardian->profile?->phone,
                    'students' => $studentNames,
                ];
            });
    }

    /**
     * Delete attachment file.
     */
    public function deleteAttachment($uuid, $attachmentUuid)
    {
        DB::beginTransaction();

        try {
            $submission = TrainingProgramSubmission::where('uuid', $uuid)
                ->with('submission')
                ->firstOrFail();
            $attachment = $submission->attachments()->where('uuid', $attachmentUuid)->firstOrFail();

            // Only allow deletion if submission is in draft status
            if ($submission->submission && $submission->submission->status !== 'DRAFT') {
                return redirect()->back()->withErrors([
                    'status' => 'Hanya attachment pada pengajuan draft yang dapat dihapus.'
                ]);
            }

            $attachment->delete(); // Observer will handle file deletion

            DB::commit();

            return redirect()->back()->with('success', 'File attachment berhasil dihapus.');

        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withErrors([
                'error' => $th->getMessage()
            ]);
        }
    }
} 