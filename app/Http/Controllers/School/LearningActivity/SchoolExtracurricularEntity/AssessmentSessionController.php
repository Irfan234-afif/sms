<?php

namespace App\Http\Controllers\School\LearningActivity\SchoolExtracurricularEntity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AssessmentRubricResource;
use App\Http\Resources\LearningObjectiveResource;
use App\Models\AssessmentAspect;
use App\Models\AssessmentAspectSessionRubric;
use App\Models\AssessmentRecord;
use App\Models\AssessmentRubric;
use App\Models\AssessmentSession;
use App\Models\AssessmentSessionRubric;
use App\Models\LearningObjective;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use App\Models\SchoolExtracurricular;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class AssessmentSessionController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function optionLearningObjective()
    {
        // todo:modified by school
        $assessment_record = AssessmentRecord::where('uuid', request('assessment_record_id'))->firstOrFail();
        $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->firstOrFail();

        // add more params
        $learning_objectives = LearningObjective::where('category_id', $learning_objective_category->id)
            ->where('school_year_id', $this->school->academic_program_active->school_year_id)
            ->where('objectiveable_type', $assessment_record->assessable_type)
            ->where('objectiveable_id', $assessment_record->assessable_id);

        if (request()->has('search')) {
            $learning_objectives->where('code', 'like', '%' . request('search') . '%');
        }

        return response()->json(LearningObjectiveResource::collection($learning_objectives->latest()->get()), 200);
    }

    public function optionAssessmentRubric()
    {
        $assessment_record = AssessmentRecord::where('uuid', request('assessment_record_id'))->firstOrFail();
        $assessment_rubrics = AssessmentRubric::where('module_id', $assessment_record->module_id);

        if (request()->has('search')) {
            $assessment_rubrics->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(AssessmentRubricResource::collection($assessment_rubrics->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $assessment_session_ids = [];

            foreach (request('sessions') as $session) {
                $assessment_record = AssessmentRecord::where('uuid', $session['record_id'])->firstOrFail();
                $assessment_aspect = AssessmentAspect::where('uuid', $session['aspect_id'])->firstOrFail();

                $learning_objective_ids = LearningObjective::whereIn('uuid', $session['learning_objective_ids'] ?? [])->pluck('id')->toArray();
                $rubric_ids = AssessmentRubric::whereIn('uuid', $session['rubric_ids'] ?? [])->pluck('id')->toArray();
                $assessment_rubric = AssessmentRubric::where('uuid', $session['rubric_id'])->first();

                $assessment_session_created = AssessmentSession::updateOrCreate([
                    'record_id' => $assessment_record->id,
                    'aspect_id' => $assessment_aspect->id,
                    'sort_order' => $session['sort_order'],
                ], [
                    'name' => $session['name'],
                    'description' => $session['description'],
                    'rubric_id' => $assessment_rubric?->id,
                    'type' => $session['type'],
                    'method' => $session['method'],
                    'date' => $session['date'],
                    'portion_score' => $session['portion_score'],
                ]);

                $assessment_session_created->learning_objectives()->detach();

                foreach ($learning_objective_ids as $objective_id) {
                    $assessment_session_created->learning_objectives()->attach($objective_id, [
                        'uuid' => Uuid::uuid1(),
                    ]);
                }

                AssessmentSessionRubric::where('session_id', $assessment_session_created->id)
                    ->update(['deleted_at' => now()]);

                foreach ($rubric_ids as $rubric_id) {
                    AssessmentSessionRubric::withTrashed()
                        ->updateOrCreate([
                            'session_id' => $assessment_session_created->id,
                            'rubric_id' => $rubric_id,
                        ], [
                            'uuid' => Uuid::uuid1(),
                            'deleted_at' => null,
                        ]);
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Sesi berhasil diperbarui.',
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
