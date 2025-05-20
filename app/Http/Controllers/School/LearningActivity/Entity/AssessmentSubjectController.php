<?php

namespace App\Http\Controllers\School\LearningActivity\Entity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AssessmentModuleResource;
use App\Http\Resources\AssessmentRecordResource;
use App\Http\Resources\SchoolClassroomResource;
use App\Http\Resources\SchoolSubjectResource;
use App\Models\AssessmentModule;
use App\Models\AssessmentRecord;
use App\Models\School;
use App\Models\SchoolClassroom;
use App\Models\SchoolSubject;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentSubjectController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index($school_classroom_id)
    {
        $school_classroom = SchoolClassroom::where('uuid', $school_classroom_id)->firstOrFail();

        $assessment_records = AssessmentRecord::where('school_academic_program_id', $this->school->academic_program_active->id)
            ->where('school_classroom_id', $school_classroom->id)
            ->with([
                'academic_program',
                'classroom',
                'subject',
                'module',
            ])
            ->latest()
            ->paginate(15);

        $data = [
            'school_classroom' => SchoolClassroomResource::make($school_classroom),
            'assessment_records' => AssessmentRecordResource::collection($assessment_records),
        ];

        return Inertia::render('School/LearningActivity/SchoolClassroom/AssessmentSubject/Index', $data);
    }

    public function detail($school_classroom_id, $assessment_record_id)
    {
        $school_classroom = SchoolClassroom::where('uuid', $school_classroom_id)->firstOrFail();

        $assessment_record = AssessmentRecord::where('uuid', $assessment_record_id)
            ->with([
                'academic_program',
                'classroom',
                'subject',
                'module.aspects.learning_objective_category',
                'module.rubrics',
                'sessions.learning_objective',
                'sessions.rubric',
            ])->firstOrFail();

        $data = [
            'school_classroom' => SchoolClassroomResource::make($school_classroom),
            'assessment_record' => AssessmentRecordResource::make($assessment_record),
        ];

        return Inertia::render('School/LearningActivity/SchoolClassroom/AssessmentSubject/Detail', $data);
    }

    public function optionAssessmentModule()
    {
        // todo:modified by school
        $school_curriculum = $this->school->academic_program_active->curriculum;

        $assessment_modules = $school_curriculum->assessment_modules();

        if (request()->has('search')) {
            $assessment_modules->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(AssessmentModuleResource::collection($assessment_modules->latest()->get()), 200);
    }

    public function optionSchoolSubject()
    {
        $school_subjects = SchoolSubject::where('school_id', $this->school->id);

        if (request()->has('search')) {
            $school_subjects->where('title', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolSubjectResource::collection($school_subjects->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_classroom = SchoolClassroom::where('uuid', request('school_classroom_id'))->firstOrFail();
            $assessment_module = AssessmentModule::where('uuid', request('assessment_module_id'))->firstOrFail();
            $school_subject = SchoolSubject::where('uuid', request('school_subject_id'))->firstOrFail();

            AssessmentRecord::updateOrCreate(
                [
                    'school_academic_program_id' => $this->school->academic_program_active->id,
                    'school_classroom_id' => $school_classroom?->id,
                    'school_subject_id' => $school_subject->id,
                    'module_id' => $assessment_module->id,
                ],
                [
                    'name' => request('name'),
                ]
            );

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
