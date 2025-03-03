<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\Employee;
use App\Models\School;
use App\Models\SchoolExtracurricular;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolExtracurricularController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_extracurriculars = SchoolExtracurricular::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_extracurriculars->where('name', 'like', '%' . request('search') . '%');
        }

        $school_extracurriculars = $school_extracurriculars->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_extracurriculars' => SchoolSubjectResource::collection($school_extracurriculars)
        ];

        return Inertia::render('School/Management/SchoolExtracurricular/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_extracurricular = SchoolExtracurricular::where('uuid', request('school_extracurricular_id'))->first();
            $mentor = Employee::where('uuid', request('mentor_id'))->first();

            SchoolExtracurricular::updateOrCreate(
                [
                    'id' => $school_extracurricular ? $school_extracurricular->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'mentor_id' => $mentor->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Ekstrakurikular berhasil disimpan.',
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
            $school_extracurricular = SchoolExtracurricular::where('uuid', request('school_extracurricular_id'))->firstOrFail();

            $school_extracurricular->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Ekstrakurikular berhasil dihapus.',
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
