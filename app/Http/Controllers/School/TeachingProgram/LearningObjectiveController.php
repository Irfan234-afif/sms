<?php

namespace App\Http\Controllers\School\TeachingProgram;

use App\Http\Controllers\Controller;
use App\Http\Resources\LearningObjectiveCategoryResource;
use App\Http\Resources\LearningObjectiveResource;
use App\Http\Resources\SchoolCurriculumResource;
use App\Http\Resources\SchoolGradeResource;
use App\Http\Resources\SchoolPhaseResource;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\LearningObjective;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use App\Models\SchoolCurriculum;
use App\Models\SchoolGrade;
use App\Models\SchoolPhase;
use App\Models\SchoolSubject;
use App\Models\SchoolYear;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class LearningObjectiveController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        // todo:modified by school
        $school_curriculum = SchoolCurriculum::where('school_id', $this->school->id)
            ->orderBy('id', 'DESC')->first();
        $learning_objective_categories = $school_curriculum->learning_objective_categories()
            ->with('parent')
            ->get();

        $data = [
            'school_curriculum' => SchoolCurriculumResource::make($school_curriculum),
            'learning_objective_categories' => LearningObjectiveCategoryResource::collection($learning_objective_categories),
        ];

        return Inertia::render('School/TeachingProgram/LearningObjective/Index', $data);
    }

    public function detail($learning_objective_category_id)
    {
        $school_phases = SchoolPhase::where('school_level_id', $this->school->school_level_id)
            ->with('grades')
            ->get();
        // todo:modified by school
        $school_curriculum = SchoolCurriculum::where('id', $this->school->academic_program_active->school_curriculum_id)
            ->orderBy('id', 'DESC')->first();
        $learning_objective_category = LearningObjectiveCategory::where('uuid', $learning_objective_category_id)
            ->with('parent')
            ->firstOrFail();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_phases' => SchoolPhaseResource::make($school_phases),
            'school_curriculum' => SchoolCurriculumResource::make($school_curriculum),
            'learning_objective_category' => LearningObjectiveCategoryResource::make($learning_objective_category),
        ];

        return Inertia::render('School/TeachingProgram/LearningObjective/Detail', $data);
    }

    public function optionSchoolPhase()
    {
        $school_phases = SchoolPhase::where('school_level_id', $this->school->school_level_id);

        if (request()->has('search')) {
            $school_phases->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolPhaseResource::collection($school_phases->latest()->get()), 200);
    }

    public function optionSchoolGrade()
    {
        $school_phase = SchoolPhase::where('uuid', request('school_phase_id'))->first();
        $school_grades = SchoolGrade::where('school_level_id', $this->school->school_level_id);

        if ($school_phase) {
            $school_grades->where('school_phase_id', $school_phase->id);
        }

        if (request()->has('search')) {
            $school_grades->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolGradeResource::collection($school_grades->latest()->get()), 200);
    }

    public function optionSchoolSubject()
    {
        $school_subjects = SchoolSubject::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_subjects->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolSubjectResource::collection($school_subjects->latest()->get()), 200);
    }


    public function optionLearningObjective()
    {
        $school_year = SchoolYear::where('id', $this->school->academic_program_active->school_year_id)->firstOrFail();
        $school_phase = SchoolPhase::where('uuid', request('school_phase_id'))->first();
        $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->first();
        $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->first();

        $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->firstOrFail();

        $learning_objectives = $learning_objective_category->parent->objectives()
            ->with('parent');

        if ($school_year) {
            $learning_objectives->where('school_year_id', $school_year->id);
        }

        if ($school_phase) {
            $learning_objectives->where('school_phase_id', $school_phase->id);
        }

        if ($school_grade) {
            $learning_objectives->where('school_grade_id', $school_grade->id);
        }

        if ($school_subject) {
            $learning_objectives->where('school_subject_id', $school_subject->id);
        }

        if (request()->has('search')) {
            $learning_objectives->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(LearningObjectiveResource::collection($learning_objectives->latest()->get()), 200);
    }

    public function getLearningObjective()
    {
        $school_year = SchoolYear::where('id', $this->school->academic_program_active->school_year_id)->firstOrFail();
        $school_phase = SchoolPhase::where('uuid', request('school_phase_id'))->first();
        $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->first();
        $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->first();

        $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->firstOrFail();

        $learning_objectives = $learning_objective_category->objectives()
            ->with('parent');

        if ($school_year) {
            $learning_objectives->where('school_year_id', $school_year->id);
        }

        if ($school_phase) {
            $learning_objectives->where('school_phase_id', $school_phase->id);
        }

        if ($school_grade) {
            $learning_objectives->where('school_grade_id', $school_grade->id);
        }

        if ($school_subject) {
            $learning_objectives->where('school_subject_id', $school_subject->id);
        }

        if (request()->has('search')) {
            $learning_objectives->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(LearningObjectiveResource::collection($learning_objectives->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $learning_objective_category = LearningObjectiveCategory::where('uuid', request('learning_objective_category_id'))->firstOrFail();
            $learning_objective = LearningObjective::where('uuid', request('learning_objective_id'))->first();
            $parent = LearningObjective::where('uuid', request('parent_id'))->first();
            // todo:modified by school
            $school_year = SchoolYear::where('id', $this->school->academic_program_active->school_year_id)->firstOrFail();
            $school_phase = SchoolPhase::where('uuid', request('school_phase_id'))->firstOrFail();
            $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->firstOrFail();
            $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->firstOrFail();

            LearningObjective::updateOrCreate(
                [
                    'id' => $learning_objective ? $learning_objective->id : null,
                    'school_curriculum_id' => $learning_objective_category->school_curriculum_id,
                    'category_id' => $learning_objective_category->id,
                    'school_year_id' => $school_year->id,
                    'school_phase_id' => $school_phase ? $school_phase->id : null,
                    'school_grade_id' => $school_grade ? $school_grade->id : null,
                    'school_subject_id' => $school_subject ? $school_subject->id : null,
                ],
                [
                    'parent_id' => $parent ? $parent->id : null,
                    'title' => request('title'),
                    'code' => request('code'),
                    'narrative' => request('narrative'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Indikator Pembelajaran berhasil disimpan.',
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
            $learning_objective = LearningObjective::where('uuid', request('learning_objective_id'))->firstOrFail();

            $learning_objective->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Indikator Pembelajaran berhasil dihapus.',
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
