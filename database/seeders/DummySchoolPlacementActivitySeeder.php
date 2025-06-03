<?php

namespace Database\Seeders;

use App\Models\School;
use App\Models\SchoolClassroomMember;
use App\Models\SchoolClubMember;
use App\Models\SchoolExtracurricularMember;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DummySchoolPlacementActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public $schools;

    public function run(): void
    {
        $this->schools = School::get();

        // Placement student at member entity
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Placement student at member entity');
            $this->command->getOutput()->progressStart(count($this->schools));
            foreach ($this->schools as $school) {
                DB::beginTransaction();

                try {
                    $students = $school->students()->whereNotNull('school_grade_id')->get();

                    foreach ($students as $student) {
                        $school_classroom = $school->classrooms()->where('school_grade_id', $student->school_grade_id)->inRandomOrder()->firstOrFail();
                        $school_extracurricular = $school->extracurriculars()->inRandomOrder()->firstOrFail();
                        $school_club = $school->clubs()->inRandomOrder()->firstOrFail();

                        SchoolClassroomMember::updateOrCreate([
                            'school_classroom_id' => $school_classroom->id,
                            'student_id' => $student->id,
                        ]);

                        SchoolExtracurricularMember::updateOrCreate([
                            'school_extracurricular_id' => $school_extracurricular->id,
                            'student_id' => $student->id,
                            'school_classroom_id' => $school_classroom->id,
                        ]);

                        SchoolClubMember::updateOrCreate([
                            'school_club_id' => $school_club->id,
                            'student_id' => $student->id,
                            'school_classroom_id' => $school_classroom->id,
                        ]);
                    }

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
    }
}
