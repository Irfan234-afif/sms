<?php

namespace App\Http\Controllers\Office\QRD\Approval;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\TrainingProgram\TrainingProgramSubmission;
use App\Models\Submission;
use App\Services\SubmissionStoreService;
use App\Services\SubmissionUpdateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;

class TrainingProgramController extends Controller
{
    public function index()
    {
        $submissions = Submission::where('status',  '!=', 'DRAFT')->whereHas('group', function ($group) {
            $group->where('code', 'TRAINING_PROGRAM');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->with('approvals.approver.profile')
            ->with('approvals.delegate.profile')
            ->with('trainingProgramSubmission.participants.participant.profile')
            ->with('trainingProgramSubmission.trainingProgram')
            ->with('trainingProgramSubmission.goals')
            ->with('trainingProgramSubmission.budgetItems')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/QRD/Approval/TrainingProgram/Index', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('TRAINING_PROGRAM', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $training_program_submission_created = TrainingProgramSubmission::updateOrCreate([
                'submission_id' => $submission_created->id,
            ], [
                'submitter_id' => $submitter->id,
                'reference_number' => $submission_created->reference_number,
                'training_type' => request('training_type'),
                'training_program_id' => request('training_program_id'),
                'external_training_title' => request('external_training_title'),
                'external_training_provider' => request('external_training_provider'),
                'external_training_location' => request('external_training_location'),
                'external_training_method' => request('external_training_method'),
                'external_training_description' => request('external_training_description'),
                'start_date' => request('start_date'),
                'end_date' => request('end_date'),
                'daily_start_time' => request('daily_start_time'),
                'daily_end_time' => request('daily_end_time'),
                'training_days' => request('training_days'),
                'justification' => request('justification'),
                'expected_outcomes' => request('expected_outcomes'),
                'datetime' => $submission_created->datetime,
            ]);

            // Create goals if provided
            if (request()->has('goals') && is_array(request('goals'))) {
                foreach (request('goals') as $goal) {
                    $training_program_submission_created->goals()->create([
                        'goal_type' => $goal['goal_type'],
                        'description' => $goal['description'],
                        'success_indicator' => $goal['success_indicator'],
                        'order' => $goal['order'] ?? 1,
                    ]);
                }
            }

            // Create budget items if provided
            if (request()->has('budget_items') && is_array(request('budget_items'))) {
                foreach (request('budget_items') as $budget) {
                    $training_program_submission_created->budgetItems()->create([
                        'category' => $budget['category'],
                        'item_name' => $budget['item_name'],
                        'description' => $budget['description'] ?? null,
                        'quantity' => $budget['quantity'],
                        'unit_price' => $budget['unit_price'],
                    ]);
                }
            }

            // Create participants if provided
            if (request()->has('participants') && is_array(request('participants'))) {
                foreach (request('participants') as $participant) {
                    $training_program_submission_created->participants()->create([
                        'profile_id' => $participant['profile_id'],
                        'is_primary_participant' => $participant['is_primary_participant'] ?? false,
                        'role_description' => $participant['role_description'] ?? null,
                        'selection_reason' => $participant['selection_reason'] ?? null,
                    ]);
                }
            }

            // Handle file attachments
            if (request()->hasFile('attachment_files')) {
                foreach (request()->file('attachment_files') as $index => $file) {
                    $attachmentType = request('attachment_types')[$index] ?? 'OTHER';
                    $description = request('attachment_descriptions')[$index] ?? null;

                    $filename = time() . '_' . uniqid() . '_' . $file->getClientOriginalName();
                    $path = $file->storeAs('training-program-submissions/' . $training_program_submission_created->uuid, $filename, 'public');

                    $training_program_submission_created->attachments()->create([
                        'attachment_type' => $attachmentType,
                        'description' => $description,
                        'file_name' => $filename,
                        'file_path' => $path,
                        'file_size' => $file->getSize(),
                        'file_type' => $file->getClientMimeType(),
                    ]);
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pengajuan training program berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function update()
    {
        DB::beginTransaction();

        try {
            $submissionService = new SubmissionUpdateService(request('submission_id'));

            $submission = $submissionService->updateSubmission();

            $training_program_submission = $submission->trainingProgramSubmission;

            if ($training_program_submission) {
                $training_program_submission->update([
                    'training_type' => request('training_type'),
                    'training_program_id' => request('training_program_id'),
                    'external_training_title' => request('external_training_title'),
                    'external_training_provider' => request('external_training_provider'),
                    'external_training_location' => request('external_training_location'),
                    'external_training_method' => request('external_training_method'),
                    'external_training_description' => request('external_training_description'),
                    'start_date' => request('start_date'),
                    'end_date' => request('end_date'),
                    'daily_start_time' => request('daily_start_time'),
                    'daily_end_time' => request('daily_end_time'),
                    'training_days' => request('training_days'),
                    'justification' => request('justification'),
                    'expected_outcomes' => request('expected_outcomes'),
                ]);

                // Update goals
                if (request()->has('goals') && is_array(request('goals'))) {
                    $training_program_submission->goals()->delete();
                    foreach (request('goals') as $goal) {
                        $training_program_submission->goals()->create([
                            'goal_type' => $goal['goal_type'],
                            'description' => $goal['description'],
                            'success_indicator' => $goal['success_indicator'],
                            'order' => $goal['order'] ?? 1,
                        ]);
                    }
                }

                // Update budget items
                if (request()->has('budget_items') && is_array(request('budget_items'))) {
                    $training_program_submission->budgetItems()->delete();
                    foreach (request('budget_items') as $budget) {
                        $training_program_submission->budgetItems()->create([
                            'category' => $budget['category'],
                            'item_name' => $budget['item_name'],
                            'description' => $budget['description'] ?? null,
                            'quantity' => $budget['quantity'],
                            'unit_price' => $budget['unit_price'],
                        ]);
                    }
                }

                // Update participants
                if (request()->has('participants') && is_array(request('participants'))) {
                    $training_program_submission->participants()->delete();
                    foreach (request('participants') as $participant) {
                        $training_program_submission->participants()->create([
                            'profile_id' => $participant['profile_id'],
                            'is_primary_participant' => $participant['is_primary_participant'] ?? false,
                            'role_description' => $participant['role_description'] ?? null,
                            'selection_reason' => $participant['selection_reason'] ?? null,
                        ]);
                    }
                }

                // Handle new file attachments
                if (request()->hasFile('attachment_files')) {
                    foreach (request()->file('attachment_files') as $index => $file) {
                        $attachmentType = request('attachment_types')[$index] ?? 'OTHER';
                        $description = request('attachment_descriptions')[$index] ?? null;

                        $filename = time() . '_' . uniqid() . '_' . $file->getClientOriginalName();
                        $path = $file->storeAs('training-program-submissions/' . $training_program_submission->uuid, $filename, 'public');

                        $training_program_submission->attachments()->create([
                            'attachment_type' => $attachmentType,
                            'description' => $description,
                            'file_name' => $filename,
                            'file_path' => $path,
                            'file_size' => $file->getSize(),
                            'file_type' => $file->getClientMimeType(),
                        ]);
                    }
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pengajuan training program berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function delete()
    {
        DB::beginTransaction();

        try {
            $submission = Submission::where('uuid', request('submission_id'))->firstOrFail();

            $submission->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pengajuan training program berhasil dihapus.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
} 