<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolMajorResource;
use App\Models\School;
use App\Models\SchoolMajor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolMajorController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_majors = SchoolMajor::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_majors->where('title', 'like', '%' . request('search') . '%');
        }

        $school_majors = $school_majors->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_majors' => SchoolMajorResource::collection($school_majors)
        ];

        return Inertia::render('School/Management/SchoolMajor/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_major = SchoolMajor::where('uuid', request('school_major_id'))->first();

            SchoolMajor::updateOrCreate(
                [
                    'id' => $school_major ? $school_major->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Jurusan berhasil disimpan.',
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
            $school_major = SchoolMajor::where('uuid', request('school_major_id'))->firstOrFail();

            $school_major->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Jurusan berhasil dihapus.',
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
