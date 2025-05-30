<?php

namespace App\Http\Controllers\School\TeachingProgram\Entity;

use App\Http\Controllers\Controller;
use App\Models\AssessmentAspect;
use App\Models\AssessmentFinalRule;
use App\Models\AssessmentModule;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentFinalRuleController extends Controller
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
            $assessment_final_rule = AssessmentFinalRule::where('uuid', request('assessment_final_rule_id'))->first();

            $assessment_final_rule_created = AssessmentFinalRule::updateOrCreate(
                [
                    'id' => $assessment_final_rule ? $assessment_final_rule->id : null,
                    'module_id' => $assessment_module->id,
                ],
                [
                    'name' => request('name'),
                    'sort_order' => request('sort_order'),
                    'use_score' => request('use_score'),
                    'score_method' => request('score_method'),
                    'use_predicate' => request('use_predicate'),
                    'predicate_method' => request('predicate_method'),
                    'use_narrative' => request('use_narrative'),
                    'narrative_method' => request('narrative_method'),
                ]
            );

            $score_ids = [];

            foreach (request('final_rule_scores') as $score) {
                $aspect = AssessmentAspect::where('uuid', $score['aspect_id'])->firstOrFail();

                $score_created = $assessment_final_rule_created->scores()->updateOrCreate([
                    'uuid' => $score['id'],
                ], [
                    'aspect_id' => $aspect->id,
                    'portion_score' => $score['portion_score'],
                ]);

                array_push($score_ids, $score_created->id);
            }

            $assessment_final_rule_created->scores()
                ->whereNotIn('id', $score_ids)
                ->delete();

            foreach (request('final_rule_narratives') as $narrative) {
                $aspect = AssessmentAspect::where('uuid', $narrative['aspect_id'])->firstOrFail();

                $assessment_final_rule_created->narratives()->updateOrCreate([
                    'uuid' => $narrative['id'],
                ], [
                    'aspect_id' => $aspect->id,
                ]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian Akhir berhasil disimpan.',
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
            $assessment_final_rule = AssessmentFinalRule::where('uuid', request('assessment_final_rule_id'))->firstOrFail();

            $assessment_final_rule->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian Akhir berhasil dihapus.',
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
