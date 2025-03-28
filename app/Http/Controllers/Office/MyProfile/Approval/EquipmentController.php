<?php

namespace App\Http\Controllers\Office\MyProfile\Approval;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubEquipment;
use App\Models\Submission;
use App\Services\SubmissionStoreService;
use App\Services\SubmissionUpdateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;

class EquipmentController extends Controller
{
    public function index()
    {
        $submissions = Submission::where('status',  '!=', 'DRAFT')->whereHas('group', function ($group) {
            $group->where('code', 'EQUIPMENT');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->with('approvals.approver.profile')
            ->with('approvals.delegate.profile')
            ->with('equipment.items')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/MyProfile/Approval/Equipment/Index', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('EQUIPMENT', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $sub_equipment_created = SubEquipment::updateOrCreate([
                'submission_id' => $submission_created->id,
            ]);

            $sub_equipment_created->items()->create([
                'name' => request('name'),
                'quantity' => request('quantity'),
                'due_date' => request('due_date'),
                'description' => request('description'),
                'status' => 'UNKNOWN',
            ]);

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

            $submission->equipment->items()->first()->update([
                'name' => request('name'),
                'quantity' => request('quantity'),
                'due_date' => request('due_date'),
                'description' => request('description'),
                'status' => 'UNKNOWN',
            ]);

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
