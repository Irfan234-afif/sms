<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\AdmissionStudentQuotaResource;
use App\Http\Resources\SchoolResource;
use App\Http\Resources\SchoolYearResource;
use App\Models\AdmissionStudentQuota;
use App\Models\School;
use App\Models\SchoolYear;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStudentQuotaController extends Controller
{
    public function index()
    {
        $schools = School::query();

        if (request()->has('search')) {
            $schools->whereHas('area', function ($area) {
                $area->where('name', 'like', '%' . request('search') . '%');
            });
        }

        $schools = $schools->with('area')
            ->with('level.grades')
            ->latest()
            ->paginate(15);

        $school_years = SchoolYear::latest()->get();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'schools' => SchoolResource::collection($schools),
            'school_years' => SchoolYearResource::collection($school_years)
        ];

        return Inertia::render('Office/ICC/Management/AdmissionStudentQuota/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            foreach (request('admission_student_quotas') as $quota) {
                AdmissionStudentQuota::updateOrCreate(
                    [
                        'school_id' => $quota['school_id'],
                        'school_year_id' => $quota['school_year_id'],
                        'school_grade_id' => $quota['school_grade_id'],
                    ],
                    [
                        'max_quota' => $quota['max_quota'],
                        'used_quota' => $quota['used_quota'],
                    ]
                );
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kuota pendaftaran berhasil diperbarui.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function getStudentQuota()
    {
        $school = School::where('uuid', request('school'))->firstOrFail();
        $school_year = SchoolYear::where('uuid', request('school_year'))->firstOrFail();

        $admission_student_quotas = AdmissionStudentQuota::where([
            'school_id' => $school->id,
            'school_year_id' => $school_year->id,
        ])->with('school_grade')
            ->get();

        $admission_student_quotas = AdmissionStudentQuotaResource::collection($admission_student_quotas);

        return response()->json($admission_student_quotas, 200);
    }
}
