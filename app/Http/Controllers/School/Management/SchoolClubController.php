<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Http\Resources\SchoolClubResource;
use App\Http\Resources\StudentResource;
use App\Models\Employee;
use App\Models\School;
use App\Models\SchoolClub;
use App\Models\SchoolClubMember;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolClubController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_clubs = SchoolClub::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_clubs->where('title', 'like', '%' . request('search') . '%');
        }

        $school_clubs = $school_clubs->with('mentor.profile')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_clubs' => SchoolClubResource::collection($school_clubs)
        ];

        return Inertia::render('School/Management/SchoolClub/Index', $data);
    }

    public function detail($school_club_id)
    {
        $school_club = SchoolClub::where('uuid', $school_club_id)
            ->with('mentor.profile')
            ->firstOrFail();

        $students = $school_club->members()->with('profile')->latest()->get();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_club' => SchoolClubResource::make($school_club),
            'members' => StudentResource::collection($students),
        ];

        return Inertia::render('School/Management/SchoolClub/Detail', $data);
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
            $school_club = SchoolClub::where('uuid', request('school_club_id'))->first();
            $mentor = Employee::where('uuid', request('mentor_id'))->first();

            SchoolClub::updateOrCreate(
                [
                    'id' => $school_club ? $school_club->id : null,
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
                'message' => 'Klub berhasil disimpan.',
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
            $school_club = SchoolClub::where('uuid', request('school_club_id'))->firstOrFail();

            $school_club->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Klub berhasil dihapus.',
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
            $school_club = SchoolClub::where('uuid', request('school_club_id'))->firstOrFail();
            $student = Student::where('uuid', request('student_id'))->firstOrFail();

            SchoolClubMember::updateOrCreate(
                [
                    'school_club_id' => $school_club->id,
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
            $school_club_member = SchoolClubMember::where('uuid', request('school_club_member_id'))->firstOrFail();

            $school_club_member->forceDelete();

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
