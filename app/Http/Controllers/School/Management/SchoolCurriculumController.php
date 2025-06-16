<?php

namespace App\Http\Controllers\School\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\LearningObjectiveCategoryResource;
use App\Http\Resources\SchoolCurriculumResource;
use App\Models\School;
use App\Models\SchoolCurriculum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolCurriculumController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_curriculums = SchoolCurriculum::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_curriculums->where('title', 'like', '%' . request('search') . '%');
        }

        $school_curriculums = $school_curriculums->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_curriculums' => SchoolCurriculumResource::collection($school_curriculums)
        ];

        return Inertia::render('School/Management/SchoolCurriculum/Index', $data);
    }

    public function detail($school_curriculum_id)
    {
        $school_curriculum = SchoolCurriculum::where('school_id', $this->school->id)
            ->where('uuid', $school_curriculum_id)
            ->firstOrFail();

        $learning_objective_categories = $school_curriculum->learning_objective_categories()
            ->with('parent')
            ->get();


        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_curriculum' => SchoolCurriculumResource::make($school_curriculum),
            'learning_objective_categories' => LearningObjectiveCategoryResource::collection($learning_objective_categories),
        ];

        return Inertia::render('School/Management/SchoolCurriculum/Detail', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->first();

            SchoolCurriculum::updateOrCreate(
                [
                    'id' => $school_curriculum ? $school_curriculum->id : null,
                ],
                [
                    'school_id' => $this->school->id,
                    'title' => request('title'),
                    'code' => request('code'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kurikulum berhasil disimpan.',
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
            $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->firstOrFail();

            $school_curriculum->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kurikulum berhasil dihapus.',
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
