<?php

namespace App\Http\Controllers\Office\QRD\Setting;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Http\Resources\EmployeeResource;
use App\Http\Resources\SubmissionApproverResource;
use App\Http\Resources\SubmissionGroupResource;
use App\Models\Area;
use App\Models\Employee;
use App\Models\SubmissionApprover;
use App\Models\SubmissionGroup;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class SubmissionApproverController extends Controller
{
    public function index()
    {
        $groups = ['TRAINING_PROGRAM'];
        $submission_groups = SubmissionGroup::whereIn('code', $groups)->get();
        $areas = Area::get();

        $data = [
            'submission_groups' => SubmissionGroupResource::collection($submission_groups),
            'areas' => AreaResource::collection($areas),
        ];

        return Inertia::render('Office/QRD/Setting/SubmissionApprover/Index', $data);
    }

    public function getSubmissionApprover()
    {
        $submission_group = SubmissionGroup::where('uuid', request('submission_group_id'))->firstOrFail();
        $area = Area::where('uuid', request('area_id'))->firstOrFail();
        $submission_approvers = SubmissionApprover::where('submission_group_id', $submission_group->id)
            ->where('area_id', $area->id)
            ->with('approver.profile')
            ->with('delegates.delegate.profile');

        return response()->json(SubmissionApproverResource::collection($submission_approvers->orderBy('sort_number', 'ASC')->get()), 200);
    }

    public function optionEmployee()
    {
        $employees = Employee::query();

        if (request()->has('search')) {
            $employees->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        return response()->json(EmployeeResource::collection($employees->with('profile')->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $submission_group = SubmissionGroup::where('uuid', request('submission_group_id'))->firstOrFail();
            $area = Area::where('uuid', request('area_id'))->firstOrFail();

            $submission_approver_ids = [];

            foreach (request('submission_approvers') as $submission_approver) {
                $approver = Employee::where('uuid', $submission_approver['approver_id'])->firstOrFail();

                $approver_created = SubmissionApprover::updateOrCreate([
                    'submission_group_id' => $submission_group->id,
                    'area_id' => $area->id,
                    'sort_number' => $submission_approver['sort_number']
                ], [
                    'approver_id' => $approver->id,
                ]);

                array_push($submission_approver_ids, $approver_created->id);

                $submission_approval_delegate_ids = [];

                foreach ($submission_approver['delegates'] as $delegate) {
                    $delegate = Employee::where('uuid', $delegate['delegate_id'])->firstOrFail();

                    $delegate_created = $approver_created->delegates()->updateOrCreate([
                        'uuid' => $delegate['submission_approval_delegate_id']
                    ], [
                        'delegate_id' => $delegate->id,
                    ]);

                    array_push($submission_approval_delegate_ids, $delegate_created->id);
                }

                $approver_created->delegates()
                    ->whereNotIn('id', $submission_approval_delegate_ids)
                    ->delete();
            }

            SubmissionApprover::where('submission_group_id', $submission_group->id)
                ->where('area_id', $area->id)
                ->whereNotIn('id', $submission_approver_ids)
                ->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Petugas persetujuan berhasil disimpan.',
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