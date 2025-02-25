<?php

namespace App\Http\Controllers\Office\MyProfile\Submission;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Submission;
use App\Models\SubmissionGroup;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class MaterialController extends Controller
{
    public function index()
    {
        $submissions = Submission::whereHas('submitter.profile.user', function ($user) {
            $user->where('id', Auth::user()->id);
        })->whereHas('group', function ($group) {
            $group->where('code', 'MATERIAL');
        })->with('material.items');

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->latest()
            ->paginate(15);

        $submission_groups = SubmissionGroup::get();

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
            //    

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Submission berhasil diperbarui.',
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
                'message' => 'Submission berhasil dihapus.',
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
