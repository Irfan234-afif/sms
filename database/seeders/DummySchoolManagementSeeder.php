<?php

namespace Database\Seeders;

use App\Models\Employee;
use App\Models\School;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DummySchoolManagementSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $school_curriculums = json_decode(file_get_contents('database/data/dummy/school_curriculum.json'));
        $school_clubs = json_decode(file_get_contents('database/data/dummy/school_club.json'));
        $school_extracurriculars = json_decode(file_get_contents('database/data/dummy/school_extracurricular.json'));

        // Create school major
        if (App::environment(['local', 'testing'])) {
            $schools = School::where('use_major', true)->get();
            $this->command->warn('Create school major');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    $school_majors = ['IPA', 'IPS'];

                    foreach ($school_majors as $school_major) {
                        $school->majors()->firstOrCreate([
                            'title' => $school_major,
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
        // Create school subject group
        if (App::environment(['local', 'testing'])) {
            $schools = School::get();
            $this->command->warn('Create school subject group');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    $school_subject_groups = ['A', 'B', 'C'];

                    foreach ($school_subject_groups as $school_subject_group) {
                        $school->subject_groups()->firstOrCreate([
                            'title' => $school_subject_group,
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
        // Create school subject
        if (App::environment(['local', 'testing'])) {
            $schools = School::get();
            $this->command->warn('Create school subject');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                $level = $school->level->code;
                $school_subjects = json_decode(file_get_contents("database/data/dummy/subject-$level.json"));
                DB::beginTransaction();

                try {
                    foreach ($school_subjects as $school_subject) {
                        $school->subjects()->firstOrCreate([
                            'title' => $school_subject->title,
                        ], [
                            'school_subject_group_id' => $school->subject_groups()->inRandomOrder()->first()->id,
                            'description' => $school_subject->description,
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
        // Create school classroom
        if (App::environment(['local', 'testing'])) {
            $schools = School::get();
            $this->command->warn('Create school classroom');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    foreach ($school->grades as $school_grade) {
                        $groups = ['A', 'B'];
                        foreach ($groups as $group) {
                            if ($school->use_major) {
                                foreach ($school->majors as $school_major) {
                                    $school->classrooms()->firstOrCreate([
                                        'school_grade_id' => $school_grade->id,
                                        'school_major_id' => $school_major->id,
                                        'title' => $school_major->id . ' ' . $school_grade->title . ' ' . $group,
                                    ], [
                                        'homeroom_teacher_id' => Employee::inRandomOrder()->first()->id,
                                        'capacity' => rand(30, 50),
                                    ]);
                                }
                            } else {
                                $school->classrooms()->firstOrCreate([
                                    'school_grade_id' => $school_grade->id,
                                    'title' => $school_grade->title . ' ' . $group,
                                ], [
                                    'homeroom_teacher_id' => Employee::inRandomOrder()->first()->id,
                                    'capacity' => rand(30, 50),
                                ]);
                            }
                        }
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
        // Create school extracurricular
        if (App::environment(['local', 'testing'])) {
            $schools = School::get();
            $this->command->warn('Create school extracurricular');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    foreach ($school_extracurriculars as $school_extracurricular) {
                        $school->extracurriculars()->firstOrCreate([
                            'title' => $school_extracurricular->title,
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
        // Create school club
        if (App::environment(['local', 'testing'])) {
            $schools = School::get();
            $this->command->warn('Create school club');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    foreach ($school_clubs as $school_club) {
                        $school->clubs()->firstOrCreate([
                            'title' => $school_club->title,
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
