<?php

namespace App\Http\Controllers\School;

use App\Http\Controllers\Controller;
use App\Models\School;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('School/Index', $data);
    }

    public function switchActiveSchool($active_school_id)
    {
        $active_school = School::where('uuid', $active_school_id)
            ->with('area')
            ->with('academic_program_active.year')
            ->with('academic_program_active.curriculum')
            ->firstOrFail();
        $user = User::where('uuid', Auth::user()->uuid)->firstOrFail();

        if ($user->hasRole('System Admin') || $user->hasRole('Site Admin')) {
            Session::put('active_school', $active_school);
            return redirect()->route('school');
        }

        $employee = optional($user->profile)->employee;

        if (!$employee) {
            abort(404, 'Employee tidak ditemukan');
        }

        $assignment_area_exists = $employee->assignments()
            ->where('area_id', $active_school->area->id)
            ->exists();

        if (!$assignment_area_exists) {
            abort(403, 'Anda tidak memiliki akses ke sekolah ini');
        }

        Session::put('active_school', $active_school);
        return redirect()->route('school');
    }
}
