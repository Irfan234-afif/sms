<?php

namespace App\Http\Controllers\Office\GA\Activity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AdmissionStudentResource;
use App\Models\AdmissionStudent;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AdmissionStudentController extends Controller
{
    public function index()
    {
        $admission_students = AdmissionStudent::where('status', 'ACCEPTED');

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

        return Inertia::render('Office/GA/Activity/AdmissionStudent/Index', $data);
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

        return Inertia::render('Office/GA/Activity/AdmissionStudent/Detail', $data);
    }
}
