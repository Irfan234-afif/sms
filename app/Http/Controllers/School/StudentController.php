<?php

namespace App\Http\Controllers\School;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use App\Models\School;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class StudentController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $students = Student::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $students->where('school_national_id', 'like', '%' . request('search') . '%')
                ->orWhereHas('profile', function ($profile) {
                    $profile->where('name', 'like', '%' . request('search') . '%');
                });
        }

        $students = $students->with('profile')
            ->with('school.area')
            ->with('school_grade')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'students' => StudentResource::collection($students),
        ];

        return Inertia::render('School/Student/Index', $data);
    }

    public function detail($school_national_id)
    {
        $student = Student::where('school_national_id', $school_national_id)
            ->with('profile')
            ->with('school.area')
            ->with('school_grade')
            ->firstOrFail();

        $data = [
            'student' => StudentResource::make($student),
        ];

        return Inertia::render('School/Student/Detail', $data);
    }

    public function update()
    {
        DB::beginTransaction();

        try {
            $student = Student::where('uuid', request('student_id'))->firstOrFail();

            $student->profile()->update([
                'name' => request('name'),
                'birth_place' => request('birth_place'),
                'birth_date' => request('birth_date'),
                'gender' => request('gender'),
                'blood_type' => request('blood_type'),
                'religion' => request('religion'),
                'phone' => request('phone'),
                'email' => request('email'),
                'address' => request('address'),
                'postal_code' => request('postal_code'),
            ]);

            $student->update([
                'school_national_id' => request('school_national_id'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Siswa berhasil diperbarui.',
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
