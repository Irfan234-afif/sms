<?php

namespace App\Http\Controllers\School\TeachingProgram\Entity;

use App\Http\Controllers\Controller;
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
                    'use_final_score' => request('use_final_score'),
                    'final_score_method' => request('final_score_method'),
                    'use_learning_objective' => request('use_learning_objective'),
                    'learning_objective_category_id' => $learning_objective_category?->id,
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Aspek Penilaian berhasil disimpan.',
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
                'message' => 'Aspek Penilaian berhasil dihapus.',
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
