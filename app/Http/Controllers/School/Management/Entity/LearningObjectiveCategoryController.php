<?php

namespace App\Http\Controllers\School\Management\Entity;

use App\Http\Controllers\Controller;
use App\Http\Resources\LearningObjectiveCategoryResource;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use App\Models\SchoolCurriculum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class LearningObjectiveCategoryController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function optionParent()
    {
        $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->firstOrFail();
        $learning_objective_category_not_include = LearningObjectiveCategory::where('school_curriculum_id', $school_curriculum->id)
            ->where('uuid', request('learning_objective_category_id'))
            ->first();

        $learning_objective_categories = LearningObjectiveCategory::where('school_curriculum_id', $school_curriculum->id);

        if ($learning_objective_category_not_include) {
            $learning_objective_categories->whereNotIn('id', [$learning_objective_category_not_include->id]);
        }

        if (request()->has('search')) {
            $learning_objective_categories->where(function ($self) {
                $self->where('title', 'like', '%' . request('search') . '%')
                    ->orWhere('code', 'like', '%' . request('search') . '%');
            });
        }

        return response()->json(LearningObjectiveCategoryResource::collection($learning_objective_categories->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->firstOrFail();
            $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->first();
            $learning_objective_category_parent = LearningObjectiveCategory::where('uuid', request('parent_id'))->first();

            LearningObjectiveCategory::updateOrCreate(
                [
                    'id' => $learning_objective_category ? $learning_objective_category->id : null,
                    'school_curriculum_id' => $school_curriculum->id,
                ],
                [
                    'parent_id' => $learning_objective_category_parent ? $learning_objective_category_parent->id : null,
                    'title' => request('title'),
                    'code' => request('code'),
                    'options' => request('options'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kategori Indikator Pembelajaran berhasil disimpan.',
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
            $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->firstOrFail();

            $learning_objective_category->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kategori Indikator Pembelajaran berhasil dihapus.',
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
