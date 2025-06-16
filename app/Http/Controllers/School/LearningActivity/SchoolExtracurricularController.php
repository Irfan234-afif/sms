<?php

namespace App\Http\Controllers\School\LearningActivity;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolExtracurricularResource;
use App\Http\Resources\StudentResource;
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

        return Inertia::render('School/LearningActivity/SchoolExtracurricular/Index', $data);
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

        return Inertia::render('School/LearningActivity/SchoolExtracurricular/Detail', $data);
    }
}
