<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\Employee;
use App\Models\School;
use App\Models\SchoolClub;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolClubController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_clubs = SchoolClub::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_clubs->where('name', 'like', '%' . request('search') . '%');
        }

        $school_clubs = $school_clubs->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_clubs' => SchoolSubjectResource::collection($school_clubs)
        ];

        return Inertia::render('School/Management/SchoolClub/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_club = SchoolClub::where('uuid', request('school_club_id'))->first();
            $mentor = Employee::where('uuid', request('mentor_id'))->first();

            SchoolClub::updateOrCreate(
                [
                    'id' => $school_club ? $school_club->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'mentor_id' => $mentor->id,
                    'title' => request('title'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Klub berhasil disimpan.',
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
            $school_club = SchoolClub::where('uuid', request('school_club_id'))->firstOrFail();

            $school_club->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Klub berhasil dihapus.',
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
