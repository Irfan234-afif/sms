<?php

namespace App\Http\Controllers\Office\MyProfile\Approval;

use App\Exports\SubMaterialExport;
use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubMaterial;
use App\Models\Submission;
use App\Services\SubmissionStoreService;
use App\Services\SubmissionUpdateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;

class MaterialController extends Controller
{
    public function index()
    {
        $submissions = Submission::where('status',  '!=', 'DRAFT')->whereHas('group', function ($group) {
            $group->where('code', 'MATERIAL');
        });

        if (request()->has('status')) {
            $submissions->where('status', request('status'));
        }

        if (request()->has('from_date') && request()->has('to_date')) {
            $submissions->whereBetween('datetime', [request('from_date'), request('to_date')]);
        }

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $take = request('take');
        $page = request('page', 1);

        if ($take) {
            $total = $submissions->count();

            $submissions = $submissions->with([
                'approvals.approver.profile',
                'approvals.delegate.profile',
                'material.items',
            ])
                ->latest()
                ->offset(($page - 1) * $take)
                ->limit($take)
                ->get();

            $submissions = new LengthAwarePaginator(
                $submissions,
                min($total, $take * $page),
                $take,
                $page,
                ['path' => request()->url(), 'query' => request()->query()]
            );
        } else {
            $submissions = $submissions->with([
                'approvals.approver.profile',
                'approvals.delegate.profile',
                'material.items',
            ])
                ->latest()
                ->paginate(15);
        }

        $data = [
            'search_params' => [
                'search' => request('search'),
                'from_date' => request('from_date'),
                'to_date' => request('to_date'),
                'status' => request('status'),
                'take' => request('take'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/MyProfile/Approval/Material/Index', $data);
    }

    public function export()
    {
        $filename = 'sub-material.xlsx';
        return Excel::download(new SubMaterialExport(), $filename);
    }


    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('MATERIAL', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $sub_material_created = SubMaterial::updateOrCreate([
                'submission_id' => $submission_created->id,
            ]);

            $sub_material_created->items()->create([
                'reference_number' =>  'ITEM-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                'name' => request('name'),
                'quantity' => request('quantity'),
                'unit' => request('unit'),
                'description' => request('description'),
                'status' => 'DRAFT',
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

            $submission->material->items()->first()->update([
                'name' => request('name'),
                'quantity' => request('quantity'),
                'unit' => request('unit'),
                'description' => request('description'),
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
