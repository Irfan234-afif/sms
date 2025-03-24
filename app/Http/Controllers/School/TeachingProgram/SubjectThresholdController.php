<?php

namespace App\Http\Controllers\School\TeachingProgram;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolGradeResource;
use App\Http\Resources\SubjectThresholdResource;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\School;
use App\Models\SchoolGrade;
use App\Models\SchoolSubject;
use App\Models\SchoolYear;
use App\Models\SubjectThreshold;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SubjectThresholdController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index()
    {
        $school_grades = $this->school->level->grades;
        $school_subjects = SchoolSubject::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_subjects->where('title', 'like', '%' . request('search') . '%');
        }

        $school_subjects = $school_subjects->with('group')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_grades' => SchoolGradeResource::collection($school_grades),
            'school_subjects' => SchoolSubjectResource::collection($school_subjects),
        ];

        return Inertia::render('School/TeachingProgram/SubjectThreshold/Index', $data);
    }

    public function getSubjectThreshold()
    {
        $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->firstOrFail();
        // todo:modified by school
        $school_year = SchoolYear::first();
        $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->firstOrFail();
        $subject_threshold = SubjectThreshold::where('school_subject_id', $school_subject->id)
            ->where('school_year_id', $school_year->id)
            ->where('school_grade_id', $school_grade->id)
            ->with('scales')
            ->with('narratives');

        if ($subject_threshold) {
            $subject_threshold = SubjectThresholdResource::make($subject_threshold->first());
        } else {
            $subject_threshold = null;
        }

        return response()->json($subject_threshold, 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->firstOrFail();
            // todo:modified by school
            $school_year = SchoolYear::first();
            $school_grade = SchoolGrade::where('uuid', request('school_grade_id'))->firstOrFail();

            $subject_threshold_created = SubjectThreshold::updateOrCreate(
                [
                    'school_subject_id' => $school_subject->id,
                    'school_year_id' => $school_year->id,
                    'school_grade_id' => $school_grade->id,
                ],
                [
                    'minimum_value' => request('minimum_value'),
                ]
            );

            // scales

            $scale_ids = [];

            foreach (request('scales') as $scale) {
                $scale_created = $subject_threshold_created->scales()->updateOrCreate([
                    'uuid' => $scale['id'],
                ], [
                    'predicate' => $scale['predicate'],
                    'value' => $scale['value'],
                    'narrative' => $scale['narrative'],
                ]);

                array_push($scale_ids, $scale_created->id);
            }

            $subject_threshold_created->scales()
                ->whereNotIn('id', $scale_ids)
                ->delete();

            // narrative

            $narrative_ids = [];

            foreach (request('narratives') as $narrative) {
                $narrative_created = $subject_threshold_created->narratives()->updateOrCreate([
                    'uuid' => $narrative['id'],
                ], [
                    'value' => $narrative['value'],
                    'narrative' => $narrative['narrative'],
                ]);

                array_push($narrative_ids, $narrative_created->id);
            }

            $subject_threshold_created->narratives()
                ->whereNotIn('id', $narrative_ids)
                ->delete();


            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Mata Pelajaran berhasil disimpan.',
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
