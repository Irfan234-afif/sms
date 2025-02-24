<?php

namespace App\Http\Controllers\School;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use App\Models\Student;
use Illuminate\Http\Request;
use Inertia\Inertia;

class StudentController extends Controller
{
    public function index()
    {
        $students = Student::query();

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
}
