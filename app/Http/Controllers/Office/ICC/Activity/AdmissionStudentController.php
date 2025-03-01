<?php

namespace App\Http\Controllers\Office\ICC\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AdmissionStudentResource;
use App\Models\AdmissionStage;
use App\Models\AdmissionStudent;
use App\Models\AdmissionStudentQuota;
use App\Models\School;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStudentController extends Controller
{
    public function index()
    {
        $admission_students = AdmissionStudent::whereNotIn('status', ['NEW', 'DRAFT']);

        if (request()->has('search')) {
            $admission_students->where('name', 'like', '%' . request('search') . '%')
                ->orWhere('registration_number', 'like', '%' . request('search') . '%');
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

        return Inertia::render('Office/ICC/Activity/AdmissionStudent/Index', $data);
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

        return Inertia::render('Office/ICC/Activity/AdmissionStudent/Detail', $data);
    }

    public function updateVerification()
    {
        DB::beginTransaction();

        try {
            $admission_student = AdmissionStudent::where('registration_number', request('registration_number'))->firstOrFail();

            $admission_student->update([
                'submitted_at' => now(),
                'status' => request('status'),
            ]);

            $message = request('status') == 'VERIFIED' ? 'Berhasil memverifikasi formulir' : 'Berhasil menolak formulir';

            if (request('status') == 'VERIFIED') {
                $admission_student_quota = AdmissionStudentQuota::where([
                    'school_id' => $admission_student->school_id,
                    'school_year_id' => $admission_student->school_year_id,
                    'school_grade_id' => $admission_student->school_grade_id,
                ])->firstOrFail();
                $admission_student_quota->increment('used_quota', 1);

                $admission_stages = AdmissionStage::whereHasMorph('model', School::class, function ($school) use ($admission_student) {
                    $school->where('id', $admission_student->school_id);
                })->get();

                foreach ($admission_stages as $admission_stage) {
                    $admission_stage_status = $admission_stage->statuses()->orderBy('sort_number', 'ASC')->first();
                    $admission_student->stages()->create([
                        'admission_stage_id' => $admission_stage->id,
                        'admission_stage_status_id' => $admission_stage_status->id,
                    ]);
                }
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
}
