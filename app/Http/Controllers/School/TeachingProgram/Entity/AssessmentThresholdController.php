<?php

namespace App\Http\Controllers\School\TeachingProgram\Entity;

use App\Http\Controllers\Controller;
use App\Models\AssessmentThreshold;
use App\Models\AssessmentModule;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentThresholdController extends Controller
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
            $assessment_threshold = AssessmentThreshold::where('uuid', request('assessment_threshold_id'))->first();

            $assessment_threshold_created = AssessmentThreshold::updateOrCreate(
                [
                    'id' => $assessment_threshold ? $assessment_threshold->id : null,
                    'module_id' => $assessment_module->id,
                ],
                [
                    'name' => request('name'),
                    'description' => request('description'),
                ]
            );

            $scale_ids = [];

            foreach (request('scales') as $scale) {
                $scale_created = $assessment_threshold_created->scales()->updateOrCreate([
                    'uuid' => $scale['id'],
                ], [
                    'status' => $scale['status'],
                    'score' => $scale['score'],
                    'predicate' => $scale['predicate'],
                    'narrative' => $scale['narrative'],
                ]);

                array_push($scale_ids, $scale_created->id);
            }

            $assessment_threshold_created->scales()
                ->whereNotIn('id', $scale_ids)
                ->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kriteria Ketercapaian berhasil disimpan.',
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
            $assessment_threshold = AssessmentThreshold::where('uuid', request('assessment_threshold_id'))->firstOrFail();

            $assessment_threshold->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kriteria Ketercapaian berhasil dihapus.',
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
