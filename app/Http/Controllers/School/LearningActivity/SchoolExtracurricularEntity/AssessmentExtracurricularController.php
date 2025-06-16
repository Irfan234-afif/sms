<?php

namespace App\Http\Controllers\School\LearningActivity\SchoolExtracurricularEntity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AssessmentModuleResource;
use App\Http\Resources\AssessmentRecordResource;
use App\Http\Resources\SchoolClassroomResource;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\AssessmentModule;
use App\Models\AssessmentRecord;
use App\Models\School;
use App\Models\SchoolExtracurricular;
use App\Models\SchoolSubject;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentExtracurricularController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index($school_extracurricular_id)
    {
        $school_extracurricular = SchoolExtracurricular::where('uuid', $school_extracurricular_id)->firstOrFail();

        $assessment_records = AssessmentRecord::where('school_academic_program_id', $this->school->academic_program_active->id)
            ->where('assessable_type', SchoolExtracurricular::class)
            ->where('assessable_id', $school_extracurricular->id)
            ->whereHas('module')
            ->with([
                'academic_program',
                'assessable',
                'module',
            ])
            ->latest()
            ->paginate(15);

        $data = [
            'school_extracurricular' => SchoolClassroomResource::make($school_extracurricular),
            'assessment_records' => AssessmentRecordResource::collection($assessment_records),
        ];

        return Inertia::render('School/LearningActivity/SchoolExtracurricular/AssessmentExtracurricular/Index', $data);
    }

    public function detail($school_extracurricular_id, $assessment_record_id)
    {
        $school_extracurricular = SchoolExtracurricular::where('uuid', $school_extracurricular_id)->firstOrFail();

        $assessment_record = AssessmentRecord::where('uuid', $assessment_record_id)
            ->with([
                'academic_program',
                'assessable',
                'module.aspects.learning_objective_category',
                'module.rubrics',
                'sessions.learning_objectives',
                'sessions.rubrics',
                'sessions.rubric',
            ])->firstOrFail();

        $data = [
            'school_extracurricular' => SchoolClassroomResource::make($school_extracurricular),
            'assessment_record' => AssessmentRecordResource::make($assessment_record),
        ];

        return Inertia::render('School/LearningActivity/SchoolExtracurricular/AssessmentExtracurricular/Detail', $data);
    }

    public function optionAssessmentModule()
    {
        // todo:modified by school
        $school_curriculum = $this->school->academic_program_active->curriculum;

        $assessment_modules = $school_curriculum->assessment_modules()->where('type', 'EXTRACURRICULAR');

        if (request()->has('search')) {
            $assessment_modules->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(AssessmentModuleResource::collection($assessment_modules->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_extracurricular = SchoolExtracurricular::where('uuid', request('school_extracurricular_id'))->firstOrFail();
            $assessment_module = AssessmentModule::where('uuid', request('assessment_module_id'))->firstOrFail();

            $assessment_record_created = AssessmentRecord::updateOrCreate(
                [
                    'school_academic_program_id' => $this->school->academic_program_active->id,
                    'assessable_type' => SchoolExtracurricular::class,
                    'assessable_id' => $school_extracurricular->id,
                    'module_id' => $assessment_module->id,
                ],
                [
                    'name' => request('name'),
                ]
            );

            foreach ($assessment_module->aspects()->where('use_sessions', true)->get() as $aspect) {
                foreach (range(1, $aspect->total_sessions) as $session) {
                    $assessment_record_created->sessions()->firstOrCreate([
                        'aspect_id' => $aspect->id,
                        'sort_order' => $session,
                    ], [
                        'name' => 'Sesi ' . $session,
                        'portion_score' => 100,
                    ]);
                }
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian berhasil disimpan.',
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
            $assessment_record = AssessmentRecord::where('uuid', request('assessment_record_id'))->firstOrFail();

            $assessment_record->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian berhasil dihapus.',
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
