<?php

namespace App\Http\Controllers\School\LearningActivity\Entity;

use App\Http\Controllers\Controller;
use App\Http\Resources\AssessmentActivity\AssessmentRecordResource;
use App\Http\Resources\SchoolClassroomResource;
use App\Models\AssessmentFinalResult;
use App\Models\AssessmentRecord;
use App\Models\AssessmentStudent;
use App\Models\School;
use App\Models\SchoolClassroom;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class AssessmentStudentController extends Controller
{
    private $school;

    public function __construct()
    {
        $active_school = Session::get('active_school');
        $this->school = School::where('uuid', $active_school?->uuid)->firstOrFail();
    }

    public function index($school_classroom_id, $assessment_record_id)
    {
        $school_classroom = SchoolClassroom::where('uuid', $school_classroom_id)->firstOrFail();

        $assessment_record = AssessmentRecord::where('uuid', $assessment_record_id)
            ->with([
                'academic_program',
                'classroom',
                'subject',
                'module.aspects.learning_objective_category',
                'module.rubrics',
                'sessions.learning_objectives',
                'sessions.rubric',
                'students.student.profile',
                'students.aspect_results.aspect',
                'students.aspect_results.sessions.session.learning_objectives',
                'students.aspect_results.sessions.session.rubric',
                'students.final_results.final_rule',
            ])->firstOrFail();

        $students = $school_classroom->members;


        DB::beginTransaction();

        try {
            foreach ($students as $student) {
                $assessment_student_created = AssessmentStudent::updateOrCreate([
                    'record_id' => $assessment_record->id,
                    'student_id' => $student->id,
                ]);

                foreach ($assessment_record->module->aspects as $aspect) {
                    $assessment_aspect_result_created =  $assessment_student_created->aspect_results()->updateOrCreate([
                        'aspect_id' => $aspect->id,
                    ]);

                    foreach ($assessment_record->sessions()->where('aspect_id', $aspect->id)->get() as $session) {
                        $assessment_aspect_result_created->sessions()->updateOrCreate([
                            'session_id' => $session->id,
                        ]);
                    }
                }

                foreach ($assessment_record->module->final_rules as $final_rule) {
                    AssessmentFinalResult::updateOrCreate([
                        'assessment_student_id' => $assessment_student_created->id,
                        'final_rule_id' => $final_rule->id,
                    ]);
                }
            }

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();
            throw new Exception($th->getMessage(), 1);
        }

        $data = [
            'school_classroom' => SchoolClassroomResource::make($school_classroom),
            'assessment_record' => AssessmentRecordResource::make($assessment_record),
        ];

        return Inertia::render('School/LearningActivity/SchoolClassroom/AssessmentSubject/AssessmentStudent/Detail', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Penilaian berhasil diperbarui.',
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
