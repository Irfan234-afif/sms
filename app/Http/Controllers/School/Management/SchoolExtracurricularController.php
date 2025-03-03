<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Http\Resources\SchoolExtracurricularResource;
use App\Http\Resources\SchoolSubjectResource;
use App\Http\Resources\StudentResource;
use App\Models\Employee;
use App\Models\School;
use App\Models\SchoolExtracurricular;
use App\Models\SchoolExtracurricularMember;
use App\Models\Student;
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
            $school_extracurriculars->where('title', 'like', '%' . request('search') . '%');
        }

        $school_extracurriculars = $school_extracurriculars->with('mentor.profile')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_extracurriculars' => SchoolExtracurricularResource::collection($school_extracurriculars)
        ];

        return Inertia::render('School/Management/SchoolExtracurricular/Index', $data);
    }

    public function detail($school_extracurricular_id)
    {
        $school_extracurricular = SchoolExtracurricular::where('uuid', $school_extracurricular_id)
            ->with('mentor.profile')
            ->firstOrFail();

        $students = $school_extracurricular->members()->with('profile')->latest()->get();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_extracurricular' => SchoolExtracurricularResource::make($school_extracurricular),
            'members' => StudentResource::collection($students),
        ];

        return Inertia::render('School/Management/SchoolExtracurricular/Detail', $data);
    }

    public function optionMentor()
    {
        $mentors = Employee::whereHas('assignments', function ($assignments) {
            $assignments->where('area_id', $this->school->area->id);
        });

        if (request()->has('search')) {
            $mentors->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        return response()->json(EmployeeResource::collection($mentors->with('profile')->latest()->get()), 200);
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

    public function optionMember()
    {
        $students = Student::where('school_id', $this->school->id)
            ->whereHas('active_school_classroom');

        if (request()->has('search')) {
            $students->where(function ($query) {
                $query->whereHas('profile', function ($profile) {
                    $profile->where('name', 'like', '%' .  request('search') . '%');
                })->orWhere('school_national_id', 'like', '%' .  request('search') . '%');
            });
        }

        return response()->json(StudentResource::collection($students->with('profile')->latest()->get()), 200);
    }

    public function assignMember()
    {
        DB::beginTransaction();

        try {
            $school_extracurricular = SchoolExtracurricular::where('uuid', request('school_extracurricular_id'))->firstOrFail();
            $student = Student::where('uuid', request('student_id'))->firstOrFail();

            SchoolExtracurricularMember::updateOrCreate(
                [
                    'school_extracurricular_id' => $school_extracurricular->id,
                    'student_id' => $student->id,
                ],
                [
                    'school_classroom_id' => $student->active_school_classroom()->first()->pivot->school_classroom_id
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Anggota berhasil ditambahkan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function removeMember()
    {
        DB::beginTransaction();

        try {
            $school_extracurricular_member = SchoolExtracurricularMember::where('uuid', request('school_extracurricular_member_id'))->firstOrFail();

            $school_extracurricular_member->forceDelete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Anggota berhasil dihapus.',
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
