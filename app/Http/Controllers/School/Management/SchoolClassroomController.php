<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\Employee;
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
            $school_classrooms->where('name', 'like', '%' . request('search') . '%');
        }

        $school_classrooms = $school_classrooms->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_classrooms' => SchoolSubjectResource::collection($school_classrooms)
        ];

        return Inertia::render('School/Management/SchoolClassroom/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->first();
            $homeroom_teacher = Employee::where('uuid', request('homeroom_teacher_id'))->first();

            SchoolClassroom::updateOrCreate(
                [
                    'id' => $school_classroom ? $school_classroom->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'homeroom_teacher_id' => $homeroom_teacher->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kelas berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function delete()
    {
        DB::beginTransaction();

        try {
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->firstOrFail();

            $school_classroom->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kelas berhasil dihapus.',
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
