<?php

namespace App\Http\Controllers\School;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolGradeResource;
use App\Http\Resources\StudentResource;
use App\Models\Profile;
use App\Models\School;
use App\Models\SchoolGrade;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
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

    public function detail($student_id)
    {
        $student = Student::where('school_id', $this->school->id)
            ->where('uuid', $student_id)
            ->with('profile')
            ->with('school.area')
            ->with('school_grade')
            ->firstOrFail();

        $data = [
            'student' => StudentResource::make($student),
        ];

        return Inertia::render('School/Student/Detail', $data);
    }

    public function optionSchoolGrade()
    {
        $school_grades = $this->school->grades();

        if (request()->has('search')) {
            $school_grades->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolGradeResource::collection($school_grades->latest()->get()), 200);
    }

    public function store()
    {
        request()->validate([
            'school_grade_id' => 'required|exists:school_grades,uuid',
            'school_national_id' => 'required|string|unique:students,school_national_id',
            'name' => 'required|string',
            'birth_place' => 'nullable|string',
            'birth_date' => 'nullable|date',
            'gender' => 'nullable|string',
            'blood_type' => 'nullable|string',
            'religion' => 'nullable|string',
            'phone' => 'nullable|string',
            'email' => 'nullable',
            'address' => 'nullable|string',
            'postal_code' => 'nullable|string',
        ]);

        DB::beginTransaction();

        try {
            $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->firstOrFail();

            $profile = Profile::create([
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

            Student::create([
                'profile_id' => $profile->id,
                'school_id' => $this->school->id,
                'school_grade_id' => $school_grade->id,
                'school_national_id' => request('school_national_id'),
            ]);


            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Siswa berhasil ditambahkan.',
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
        $student = Student::where('uuid', request('student_id'))->firstOrFail();

        request()->validate([
            'school_national_id' => [
                'required',
                'string',
                Rule::unique('students', 'school_national_id')->ignore($student->id),
            ],
            'name' => 'required|string',
            'birth_place' => 'nullable|string',
            'birth_date' => 'nullable|date',
            'gender' => 'nullable|string',
            'blood_type' => 'nullable|string',
            'religion' => 'nullable|string',
            'phone' => 'nullable|string',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
            'postal_code' => 'nullable|string',
        ]);

        DB::beginTransaction();

        try {
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

    public function import()
    {
        DB::beginTransaction();

        try {
            foreach (request('students') as $student) {
                $school_grade = $this->school->grades()->where('title', $student['school_grade'])->firstOrFail();
                $existing_student = Student::where('school_national_id', $student['school_national_id'])->first();

                if ($existing_student) {
                    $existing_student->profile->update([
                        'name' => $student['name'],
                        'birth_place' => $student['birth_place'],
                        'birth_date' => $student['birth_date'],
                        'gender' => $student['gender'],
                        'blood_type' => $student['blood_type'],
                        'religion' => $student['religion'],
                        'address' => $student['address'],
                        'postal_code' => $student['postal_code'],
                    ]);

                    $existing_student->update([
                        'school_id' => $this->school->id,
                        'school_grade_id' => $school_grade->id,
                    ]);

                    // father
                    $existing_student->profile->families()->updateOrCreate([
                        'relation' => 'FATHER'
                    ], [
                        'name' => $student['father_name'],
                        'national_id' => $student['father_national_id'],
                        'phone' => $student['father_phone'],
                        'email' => $student['father_email'],
                        'occupation' => $student['father_occupation'],
                    ]);
                    // mother
                    $existing_student->profile->families()->updateOrCreate([
                        'relation' => 'MOTHER'
                    ], [
                        'name' => $student['mother_name'],
                        'national_id' => $student['mother_national_id'],
                        'phone' => $student['mother_phone'],
                        'email' => $student['mother_email'],
                        'occupation' => $student['mother_occupation'],
                    ]);
                } else {
                    $new_profile = Profile::create([
                        'name' => $student['name'],
                        'birth_place' => $student['birth_place'],
                        'birth_date' => $student['birth_date'],
                        'gender' => $student['gender'],
                        'blood_type' => $student['blood_type'],
                        'religion' => $student['religion'],
                        'address' => $student['address'],
                        'postal_code' => $student['postal_code'],
                    ]);

                    Student::create([
                        'profile_id' => $new_profile->id,
                        'school_id' => $this->school->id,
                        'school_grade_id' => $school_grade->id,
                        'school_national_id' => $student['school_national_id'],
                    ]);

                    // father
                    $new_profile->families()->updateOrCreate([
                        'relation' => 'FATHER'
                    ], [
                        'name' => $student['father_name'],
                        'national_id' => $student['father_national_id'],
                        'phone' => $student['father_phone'],
                        'email' => $student['father_email'],
                        'occupation' => $student['father_occupation'],
                    ]);
                    // mother
                    $new_profile->families()->updateOrCreate([
                        'relation' => 'MOTHER'
                    ], [
                        'name' => $student['mother_name'],
                        'national_id' => $student['mother_national_id'],
                        'phone' => $student['mother_phone'],
                        'email' => $student['mother_email'],
                        'occupation' => $student['mother_occupation'],
                    ]);
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Import berhasil.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function downloadImportTemplate()
    {
        $school_level = Str::lower($this->school->level->code);
        $filePath = public_path("assets/imports/import-$school_level-student-template.xlsx");

        abort_if(!File::exists($filePath), 404, 'File not found');

        return response()->download($filePath);
    }
}
