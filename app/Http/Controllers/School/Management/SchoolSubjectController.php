<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\School;
use App\Models\SchoolSubject;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolSubjectController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_subjects = SchoolSubject::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_subjects->where('title', 'like', '%' . request('search') . '%');
        }

        $school_subjects = $school_subjects->with('group')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_subjects' => SchoolSubjectResource::collection($school_subjects)
        ];

        return Inertia::render('School/Management/SchoolSubject/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->first();

            SchoolSubject::updateOrCreate(
                [
                    'id' => $school_subject ? $school_subject->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Mata Pelajaran berhasil disimpan.',
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
            $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->firstOrFail();

            $school_subject->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Mata Pelajaran berhasil dihapus.',
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
