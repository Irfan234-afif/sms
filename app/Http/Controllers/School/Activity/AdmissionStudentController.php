<?php

namespace App\Http\Controllers\School\Activity;

use App\Exports\AdmissionStudentExport;
use App\Http\Controllers\Controller;
use App\Http\Resources\AdmissionStudentResource;
use App\Models\AdmissionStageStatus;
use App\Models\AdmissionStudent;
use App\Models\AdmissionStudentStage;
use App\Models\Profile;
use App\Models\School;
use App\Models\Student;
use App\Models\StudentGuardian;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;
use Ramsey\Uuid\Uuid;

class AdmissionStudentController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $admission_students = AdmissionStudent::where('school_id', $this->school->id)->whereNotIn('status', ['NEW', 'DRAFT', 'PENDING', 'UNVERIFIED']);

        if (request()->has('search')) {
            $admission_students->where(function ($self) {
                $self->where('name', 'like', '%' . request('search') . '%')
                    ->orWhere('registration_number', 'like', '%' . request('search') . '%');
            });
        }

        $admission_students = $admission_students->with('school.area')
            ->with('school_year')
            ->with('school_grade')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'admission_students' => AdmissionStudentResource::collection($admission_students),
        ];

        return Inertia::render('School/Activity/AdmissionStudent/Index', $data);
    }

    public function detail($registration_number)
    {
        $admission_student = AdmissionStudent::where('registration_number', $registration_number)
            ->with('school.area')
            ->with('school_year')
            ->with('school_grade')
            ->with('stages.admission_stage.statuses')
            ->with('stages.status')
            ->firstOrFail();

        $data = [
            'admission_student' => AdmissionStudentResource::make($admission_student),
        ];

        return Inertia::render('School/Activity/AdmissionStudent/Detail', $data);
    }

    public function updateStage()
    {
        DB::beginTransaction();

        try {
            $admission_student_stage = AdmissionStudentStage::where('uuid', request('admission_student_stage'))->firstOrFail();
            $admission_stage_status = AdmissionStageStatus::where('uuid', request('admission_stage_status'))->firstOrFail();

            $admission_student_stage->update([
                'admission_stage_status_id' => $admission_stage_status->id,
                'description' => request('description'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Tahapan diperbarui',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function updateStatus()
    {
        DB::beginTransaction();

        try {
            $admission_student = AdmissionStudent::where('registration_number', request('registration_number'))->firstOrFail();

            $message = request('status') == 'ACCEPTED' ? 'Berhasil menerima sebagai Siswa' : 'Berhasil menolak calon Siswa';

            if (request('status') == 'ENROLLED') {
                $message = 'Berhasil menyelesaikan pendaftaran. Siswa sudah ditempatkan disekolah';

                $profile_created = Profile::create([
                    'name' => $admission_student->name,
                    'birth_place' => $admission_student->birth_place,
                    'birth_date' => $admission_student->birth_date,
                    'gender' => $admission_student->gender,
                    'blood_type' => $admission_student->blood_type,
                    'religion' => $admission_student->religion,
                    'phone' => $admission_student->phone,
                    'address' => $admission_student->address,
                    'postal_code' => $admission_student->postal_code,
                ]);

                // father
                $profile_created->families()->updateOrCreate([
                    'relation' => 'FATHER'
                ], [
                    'name' => $admission_student->father_name,
                    'avatar' => $admission_student->father_avatar,
                    'national_id' => $admission_student->father_national_id,
                    'birth_place' => $admission_student->father_birth_place,
                    'birth_date' => $admission_student->father_birth_date,
                    'religion' => $admission_student->father_religion,
                    'languages' => $admission_student->father_languages,
                    'phone' => $admission_student->father_phone,
                    'address' => $admission_student->father_address,
                    'education' => $admission_student->father_education,
                    'occupation' => $admission_student->father_occupation,
                ]);
                // mother
                $profile_created->families()->updateOrCreate([
                    'relation' => 'MOTHER'
                ], [
                    'name' => $admission_student->mother_name,
                    'avatar' => $admission_student->mother_avatar,
                    'national_id' => $admission_student->mother_national_id,
                    'birth_place' => $admission_student->mother_birth_place,
                    'birth_date' => $admission_student->mother_birth_date,
                    'religion' => $admission_student->mother_religion,
                    'languages' => $admission_student->mother_languages,
                    'phone' => $admission_student->mother_phone,
                    'address' => $admission_student->mother_address,
                    'education' => $admission_student->mother_education,
                    'occupation' => $admission_student->mother_occupation,
                ]);

                $student_created = Student::firstOrCreate([
                    'profile_id' => $profile_created->id,
                ], [
                    'school_id' => $admission_student->school_id,
                    'school_grade_id' => $admission_student->school_grade_id,
                    'school_national_id' => Uuid::uuid1(),
                ]);

                StudentGuardian::create([
                    'student_id' => $student_created->id,
                    'guardian_id' => $admission_student->transaction->customer_id,
                ]);

                $admission_student->update([
                    'student_id' => $student_created->id,
                    'status' => request('status'),
                ]);
            } else {
                $admission_student->update([
                    'status' => request('status'),
                ]);
            }


            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => $message,
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function export()
    {
        $admission_student = AdmissionStudent::where('uuid', request('admission_student_id'))->firstOrFail();

        $filename = $admission_student->registration_number . '-' . $admission_student->name . '.xlsx';
        return Excel::download(new AdmissionStudentExport([[
            'uuid' => request('admission_student_id'),
        ]]), $filename);
    }
}
