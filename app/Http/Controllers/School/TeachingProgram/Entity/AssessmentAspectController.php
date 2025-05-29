<?php

namespace App\Http\Controllers\School\TeachingProgram\Entity;

use App\Http\Controllers\Controller;
use App\Http\Resources\LearningObjectiveCategoryResource;
use App\Models\AssessmentAspect;
use App\Models\AssessmentModule;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentAspectController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function optionLearningObjectiveCategory()
    {
        $school_curriculum = $this->school->academic_program_active->curriculum;

        $learning_objectiv_categories = $school_curriculum->learning_objective_categories();

        if (request()->has('search')) {
            $learning_objectiv_categories->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(LearningObjectiveCategoryResource::collection($learning_objectiv_categories->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $assessment_module = AssessmentModule::where('uuid', request('assessment_module_id'))->firstOrFail();
            $assessment_aspect = AssessmentAspect::where('uuid', request('assessment_aspect_id'))->first();
            $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->first();

            AssessmentAspect::updateOrCreate(
                [
                    'id' => $assessment_aspect?->id,
                    'module_id' => $assessment_module->id,
                ],
                [
                    'name' => request('name'),
                    'sort_order' => request('sort_order'),
                    'use_sessions' => request('use_sessions'),
                    'total_sessions' => request('total_sessions'),
                    'use_final_score' => request('use_final_score'),
                    'final_score_method' => request('final_score_method'),
                    'use_learning_objective' => request('use_learning_objective'),
                    'learning_objective_category_id' => $learning_objective_category?->id,
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian Aspek berhasil disimpan.',
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
            $assessment_aspect = AssessmentAspect::where('uuid', request('assessment_aspect_id'))->firstOrFail();

            $assessment_aspect->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian Aspek berhasil dihapus.',
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
