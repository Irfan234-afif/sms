<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Http\Resources\SchoolClassroomResource;
use App\Http\Resources\SchoolGradeResource;
use App\Http\Resources\SchoolMajorResource;
use App\Http\Resources\StudentResource;
use App\Models\Employee;
use App\Models\School;
use App\Models\SchoolClassroom;
use App\Models\SchoolClassroomMember;
use App\Models\SchoolGrade;
use App\Models\SchoolMajor;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolClassroomController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_classrooms = SchoolClassroom::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_classrooms->where('title', 'like', '%' . request('search') . '%');
        }

        $school_classrooms = $school_classrooms->with('grade')
            ->with('major')
            ->with('homeroom_teacher.profile')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_classrooms' => SchoolClassroomResource::collection($school_classrooms)
        ];

        return Inertia::render('School/Management/SchoolClassroom/Index', $data);
    }

    public function detail($school_classroom_id)
    {
        $school_classroom = SchoolClassroom::where('uuid', $school_classroom_id)
            ->with('grade')
            ->with('major')
            ->with('homeroom_teacher.profile')
            ->firstOrFail();

        $students = $school_classroom->members()->with('profile')->latest()->get();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_classroom' => SchoolClassroomResource::make($school_classroom),
            'members' => StudentResource::collection($students),
        ];

        return Inertia::render('School/Management/SchoolClassroom/Detail', $data);
    }


    public function optionSchoolGrade()
    {
        $school_level = SchoolGrade::where('school_level_id', $this->school->school_level_id);

        if (request()->has('search')) {
            $school_level->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolGradeResource::collection($school_level->latest()->get()), 200);
    }

    public function optionSchoolMajor()
    {
        $school_majors = SchoolMajor::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_majors->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolMajorResource::collection($school_majors->latest()->get()), 200);
    }

    public function optionHomeroomTeacher()
    {
        $homeroom_teachers = Employee::whereHas('assignments', function ($assignments) {
            $assignments->where('area_id', $this->school->area->id);
        });

        if (request()->has('search')) {
            $homeroom_teachers->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        return response()->json(EmployeeResource::collection($homeroom_teachers->with('profile')->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->first();
            $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->first();
            $school_major = SchoolMajor::where('uuid', request('school_major_id'))->first();
            $homeroom_teacher = Employee::where('uuid', request('homeroom_teacher_id'))->first();

            SchoolClassroom::updateOrCreate(
                [
                    'id' => $school_classroom ? $school_classroom->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'school_grade_id' => $school_grade->id,
                    'school_major_id' => $school_major ? $school_major->id : null,
                    'homeroom_teacher_id' => $homeroom_teacher ? $homeroom_teacher->id : null,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kelas berhasil disimpan.',
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
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->firstOrFail();

            $school_classroom->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kelas berhasil dihapus.',
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
        $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->firstOrFail();

        $students = Student::where('school_id', $this->school->id)
            ->where('school_grade_id', $school_classroom->school_grade_id);

        if (request()->has('search')) {
            $students->where(function ($query) {
                $query->whereHas('profile', function ($profile) {
                    $profile->where('name', 'like', '%' . request('search') . '%');
                })->orWhere('school_national_id', 'like', '%' . request('search') . '%');
            });
        }

        return response()->json(StudentResource::collection($students->with('profile')->latest()->get()), 200);
    }

    public function assignMember()
    {
        DB::beginTransaction();

        try {
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->firstOrFail();
            $student = Student::where('uuid', request('student_id'))->firstOrFail();

            SchoolClassroomMember::updateOrCreate(
                [
                    'school_classroom_id' => $school_classroom->id,
                    'student_id' => $student->id,
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
            $school_classroom_member = SchoolClassroomMember::where('uuid', request('school_classroom_member_id'))->firstOrFail();

            $school_classroom_member->forceDelete();

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
