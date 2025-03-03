<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolSubjectGroupResource;
use App\Models\School;
use App\Models\SchoolSubjectGroup;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolSubjectGroupController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_subject_groups = SchoolSubjectGroup::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_subject_groups->where('title', 'like', '%' . request('search') . '%');
        }

        $school_subject_groups = $school_subject_groups->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_subject_groups' => SchoolSubjectGroupResource::collection($school_subject_groups)
        ];

        return Inertia::render('School/Management/SchoolSubjectGroup/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_subject_group = SchoolSubjectGroup::where('uuid', request('school_subject_group_id'))->first();

            SchoolSubjectGroup::updateOrCreate(
                [
                    'id' => $school_subject_group ? $school_subject_group->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Grup Mata Pelajaran berhasil disimpan.',
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
            $school_subject_group = SchoolSubjectGroup::where('uuid', request('school_subject_group_id'))->firstOrFail();

            $school_subject_group->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Grup Mata Pelajaran berhasil dihapus.',
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
