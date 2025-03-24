<?php

namespace App\Http\Controllers\School\Management\Entity;

use App\Http\Controllers\Controller;
use App\Models\School;
use App\Models\LearningRubric;
use App\Models\SchoolCurriculum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class LearningRubricController extends Controller
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
            $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->firstOrFail();
            $learning_rubric = LearningRubric::where('uuid', request('learning_rubric_id'))->first();

            $learning_rubric_created = LearningRubric::updateOrCreate(
                [
                    'id' => $learning_rubric ? $learning_rubric->id : null,
                    'school_curriculum_id' => $school_curriculum->id,
                ],
                [
                    'school_id' => $this->school->id,
                    'title' => request('title'),
                    'code' => request('code'),
                ]
            );

            $learning_rubric_ids = [];

            foreach (request('scales') as $scale) {
                $scale_created = $learning_rubric_created->scales()->updateOrCreate([
                    'uuid' => $scale['id'],
                ], [
                    'title' => $scale['title'],
                    'value' => $scale['value'],
                    'narrative' => $scale['narrative'],
                ]);

                array_push($learning_rubric_ids, $scale_created->id);
            }

            $learning_rubric_created->scales()
                ->whereNotIn('id', $learning_rubric_ids)
                ->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Rubrik berhasil disimpan.',
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
            $learning_rubric = LearningRubric::where('uuid', request('learning_rubric_id'))->firstOrFail();

            $learning_rubric->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Rubrik berhasil dihapus.',
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
