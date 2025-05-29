<?php

namespace App\Http\Controllers\School\TeachingProgram;

use App\Http\Controllers\Controller;
use App\Http\Resources\AssessmentModuleResource;
use App\Http\Resources\LearningObjectiveCategoryResource;
use App\Http\Resources\SchoolCurriculumResource;
use App\Models\AssessmentModule;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentModuleController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_curriculum = $this->school->academic_program_active->curriculum;

        $assessment_modules = $school_curriculum->assessment_modules();

        if (request()->has('search')) {
            $assessment_modules->where('name', 'like', '%' . request('search') . '%');
        }

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_curriculum' => SchoolCurriculumResource::make($school_curriculum),
            'assessment_modules' => AssessmentModuleResource::collection($assessment_modules->latest()->paginate(10)),
        ];

        return Inertia::render('School/TeachingProgram/AssessmentModule/Index', $data);
    }

    public function detail($assessment_module_id)
    {
        $school_curriculum = $this->school->academic_program_active->curriculum;

        $assessment_module = AssessmentModule::where('uuid', $assessment_module_id)
            ->with('aspects.learning_objective_category')
            ->with('rubrics.scales')
            ->with('thresholds.scales')
            ->with('final_rules.scores.aspect')
            ->with('final_rules.narratives.aspect')
            ->firstOrFail();

        $data = [
            'school_curriculum' => SchoolCurriculumResource::make($school_curriculum),
            'assessment_module' => AssessmentModuleResource::make($assessment_module),
        ];

        return Inertia::render('School/TeachingProgram/AssessmentModule/Detail', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_curriculum = $this->school->academic_program_active->curriculum;
            $assessment_module = AssessmentModule::where('uuid', request('assessment_module_id'))->first();

            AssessmentModule::updateOrCreate(
                [
                    'id' => $assessment_module ? $assessment_module->id : null,
                    'school_curriculum_id' => $school_curriculum->id,
                ],
                [
                    'type' => 'SUBJECT', // todo: dynamic input 
                    'name' => request('name'),
                    'description' => request('description'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Module Penilaian berhasil disimpan.',
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
            $assessment_module = AssessmentModule::where('uuid', request('assessment_module_id'))->firstOrFail();

            $assessment_module->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Module Penilaian berhasil dihapus.',
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
