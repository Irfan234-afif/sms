<?php

namespace App\Http\Controllers\School\LearningActivity;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolClassroomResource;
use App\Http\Resources\StudentResource;
use App\Models\School;
use App\Models\SchoolClassroom;
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

        return Inertia::render('School/LearningActivity/SchoolClassroom/Index', $data);
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

        return Inertia::render('School/LearningActivity/SchoolClassroom/Detail', $data);
    }
}
