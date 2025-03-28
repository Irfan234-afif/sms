<?php

namespace App\Http\Controllers\Office\MyProfile\Approval;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubDesign;
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

class DesignController extends Controller
{
    public function index()
    {
        $submissions = Submission::where('status',  '!=', 'DRAFT')->whereHas('group', function ($group) {
            $group->where('code', 'DESIGN');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->with('approvals.approver.profile')
            ->with('approvals.delegate.profile')
            ->with('design.items')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/MyProfile/Approval/Design/Index', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('DESIGN', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $sub_design_created = SubDesign::updateOrCreate([
                'submission_id' => $submission_created->id,
            ]);

            $item_created = $sub_design_created->items()->create([
                'title' => request('title'),
                'due_date' => request('due_date'),
                'description' => request('description'),
            ]);

            if (request()->hasFile('attachment_file')) {
                $file = request()->file('attachment_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($item_created->attachment) {
                    Storage::disk('public')->delete('attachments/' . $item_created->attachment);
                }

                $item_created->attachment = $filename;

                $item_created->save();
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

            $item = $submission->design->items()->first();

            if ($item) {
                $item->update([
                    'name' => request('name'),
                    'quantity' => request('quantity'),
                    'unit' => request('unit'),
                    'due_date' => request('due_date'),
                    'description' => request('description'),
                ]);

                if (request()->hasFile('attachment_file')) {
                    $file = request()->file('attachment_file');
                    $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                    if ($item->attachment) {
                        Storage::disk('public')->delete('attachments/' . $item->attachment);
                    }

                    $file->storeAs('attachments', $filename, 'public');

                    $item->update(['attachment' => $filename]);
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
