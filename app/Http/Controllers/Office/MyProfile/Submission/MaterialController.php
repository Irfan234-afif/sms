<?php

namespace App\Http\Controllers\Office\MyProfile\Submission;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubMaterial;
use App\Models\Submission;
use App\Models\SubmissionGroup;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;

class MaterialController extends Controller
{
    public function index()
    {
        $submissions = Submission::whereHas('submitter.profile.user', function ($user) {
            $user->where('id', Auth::user()->id);
        })->whereHas('group', function ($group) {
            $group->where('code', 'MATERIAL');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->latest()
            ->with('material.items.chats.sender')
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/MyProfile/Submission/Material/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $submission_group = SubmissionGroup::where('code', 'MATERIAL')->firstOrFail();
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->first();
            $area = $submitter->assignments()->first()?->area;
            $reference_number = sprintf("SUB/%s/%011d", $submission_group->reference_code, $submission_group->reference_number);
            if ($area) {
                $submission_created = Submission::create([
                    'submission_group_id' => $submission_group->id,
                    'submitter_id' => $submitter->id,
                    'area_id' => $area->id,
                    'reference_number' => $reference_number,
                    'datetime' => request('datetime'),
                    'status' => 'DRAFT',
                ]);

                $sub_material_created = SubMaterial::updateOrCreate([
                    'submission_id' => $submission_created->id,
                ]);

                $sub_material_created->items()->create([
                    'reference_number' =>  'ITEM-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                    'name' => request('name'),
                    'quantity' => request('quantity'),
                    'unit' => request('unit'),
                    'description' => request('unit'),
                    'status' => 'DRAFT',
                ]);
                // approvers
                $submission_group->increment('reference_number', 1);
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
            $submission = Submission::where('uuid', request('submission'))->firstOrFail();

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
