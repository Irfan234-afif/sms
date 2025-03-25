<?php

namespace App\Http\Controllers\School\Setting\Entity;

use App\Http\Controllers\Controller;
use App\Models\School;
use App\Models\SchoolAcademicProgram;
use App\Models\SchoolCurriculum;
use App\Models\SchoolYear;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;

class SchoolAcademicProgramController extends Controller
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
            $school_year = SchoolYear::where('uuid', request('school_year_id'))->firstOrFail();
            $school_curriculum = SchoolCurriculum::where('uuid', request('school_curriculum_id'))->firstOrFail();
            $school_academic_program = SchoolAcademicProgram::where('uuid', request('school_academic_program_id'))->firstOrFail();

            $school_academic_program_created = SchoolAcademicProgram::updateOrCreate(
                [
                    'id' => $school_academic_program ? $school_academic_program->id : null,
                    'school_id' => $this->school->id,
                    'school_year_id' => $school_year->id,
                ],
                [
                    'school_curriculum_id' => $school_curriculum->id,
                    'name' => request('name'),
                    'is_active' => request('is_active'),
                ]
            );

            if ($school_academic_program_created->is_active == true) {
                $this->school->academic_programs()
                    ->whereNotIn('id', [$school_academic_program_created->id])
                    ->update(['is_active' => false]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Program Akademi berhasil disimpan.',
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
            $school_academic_program = SchoolAcademicProgram::where('uuid', request('school_academic_program_id'))->firstOrFail();

            $school_academic_program->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Program Akademi berhasil dihapus.',
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
