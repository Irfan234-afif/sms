<?php

namespace App\Http\Controllers\Office\HCM\Approval;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubAttendance;
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

class AttendanceController extends Controller
{
    public function index()
    {
        $submissions = Submission::where('status',  '!=', 'DRAFT')->whereHas('group', function ($group) {
            $group->where('code', 'ATTENDANCE');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->with('approvals.approver.profile')
            ->with('approvals.delegate.profile')
            ->with('attendance')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/HCM/Approval/Attendance/Index', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('ATTENDANCE', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $sub_attendance_created = SubAttendance::updateOrCreate([
                'submission_id' => $submission_created->id,
            ], [
                'date' => request('date'),
                'type' => request('type'),
                'description' => request('description'),
            ]);

            if (request()->hasFile('attachment_file')) {
                $file = request()->file('attachment_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($sub_attendance_created->attachment) {
                    Storage::disk('public')->delete('attachments/' . $sub_attendance_created->attachment);
                }

                $sub_attendance_created->attachment = $filename;

                $sub_attendance_created->save();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Permintaan berhasil disimpan.',
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

            $sub_attendance_created = $submission->attendance;

            if ($sub_attendance_created) {
                $sub_attendance_created->update([
                    'date' => request('date'),
                    'type' => request('type'),
                    'description' => request('description'),
                ]);

                if (request()->hasFile('attachment_file')) {
                    $file = request()->file('attachment_file');
                    $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                    if ($sub_attendance_created->attachment) {
                        Storage::disk('public')->delete('attachments/' . $sub_attendance_created->attachment);
                    }

                    $file->storeAs('attachments', $filename, 'public');

                    $sub_attendance_created->update(['attachment' => $filename]);
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Permintaan berhasil disimpan.',
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
                'message' => 'Permintaan berhasil dihapus.',
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
