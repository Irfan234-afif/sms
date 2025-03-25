<?php

namespace App\Http\Controllers\School\Setting;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Http\Resources\SchoolAcademicProgramResource;
use App\Http\Resources\SchoolCurriculumResource;
use App\Http\Resources\SchoolResource;
use App\Models\Employee;
use App\Models\School;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->with('area')->firstOrFail();
    }

    public function index()
    {
        $school = $this->school;

        $data = [
            'school' => SchoolResource::make($school),
            'school_academic_programs' => SchoolAcademicProgramResource::collection($school->academic_programs()->with('year')->with('curriculum')->latest()->get()),
        ];

        return Inertia::render('School/Setting/Profile/Index', $data);
    }

    public function optionHeadmaster()
    {
        $headmasters = Employee::whereHas('assignments', function ($assignments) {
            $assignments->where('area_id', $this->school->area->id);
        });

        if (request()->has('search')) {
            $headmasters->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        return response()->json(EmployeeResource::collection($headmasters->with('profile')->latest()->get()), 200);
    }


    public function save()
    {
        DB::beginTransaction();

        try {
            $school = $this->school;

            $school->area->update([
                'name' => request('name'),
                'phone' => request('phone'),
                'email' => request('email'),
                'hotline' => request('hotline'),
                'address' => request('address'),
                'logo' => request('logo'),
            ]);

            $headmaster = Employee::where('uuid', request('headmaster_id'))->first();

            $school->update([
                'headmaster_id' => $headmaster ? $headmaster->id : null,
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Berhasil diperbarui.',
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
}
