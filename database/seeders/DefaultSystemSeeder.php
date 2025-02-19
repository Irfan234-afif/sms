<?php

namespace Database\Seeders;

use App\Models\Office;
use App\Models\SchoolLevel;
use App\Models\SubmissionGroup;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;

class DefaultSystemSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data default
        $roles = json_decode(file_get_contents('database/data/default/role.json'));
        $submission_groups = json_decode(file_get_contents('database/data/default/submission_group.json'));
        $school_levels = json_decode(file_get_contents('database/data/default/school_level.json'));

        if (App::environment(['local', 'testing', 'production'])) {
            // create role
            $this->command->warn('Create role');
            $this->command->getOutput()->progressStart(count($roles));
            foreach ($roles as $role) {
                DB::beginTransaction();

                try {

                    Role::firstOrCreate([
                        'name' => $role->name,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
            // create submission group
            $this->command->warn('Create submission group');
            $this->command->getOutput()->progressStart(count($submission_groups));
            foreach ($submission_groups as $submission_group) {
                DB::beginTransaction();

                try {

                    SubmissionGroup::firstOrCreate([
                        'name' => $submission_group->name,
                        'code' => $submission_group->code,
                    ], [
                        'reference_code' => $submission_group->reference_code,
                        'reference_number' => $submission_group->reference_number,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
            // create school level
            $this->command->warn('Create school level');
            $this->command->getOutput()->progressStart(count($school_levels));
            foreach ($school_levels as $school_level) {
                DB::beginTransaction();

                try {

                    $school_level_created = SchoolLevel::firstOrCreate([
                        'title' => $school_level->title,
                        'code' => $school_level->code,
                    ], [
                        'sort_number' => $school_level->sort_number,
                    ]);
                    // phase
                    foreach ($school_level->phases as $school_phase) {
                        $school_phase_created = $school_level_created->phases()->firstOrCreate([
                            'title' => $school_phase->title,
                        ], [
                            'sort_number' => $school_phase->sort_number,
                        ]);
                        // grade
                        foreach ($school_phase->grades as $school_grade) {
                            $school_phase_created->grades()->firstOrCreate([
                                'school_level_id' => $school_level_created->id,
                                'title' => $school_grade->title,
                            ], [
                                'sort_number' => $school_grade->sort_number,
                            ]);
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
    }
}
