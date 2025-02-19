<?php

namespace Database\Seeders;

use App\Models\Area;
use App\Models\Office;
use App\Models\Position;
use App\Models\School;
use App\Models\SchoolLevel;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DefaultOrganizationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data default
        $offices = json_decode(file_get_contents('database/data/default/office.json'));
        $schools = json_decode(file_get_contents('database/data/default/school.json'));
        $positions = json_decode(file_get_contents('database/data/default/position.json'));

        if (App::environment(['local', 'testing', 'production'])) {
            // create school
            $this->command->warn('Create school');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {

                    $school_level = SchoolLevel::where('code', $school->level)->firstOrFail();

                    $school_created = School::firstOrCreate([
                        'school_level_id' => $school_level->id,
                    ], [
                        'use_major' => $school->use_major,
                        'use_subject' => $school->use_subject,
                    ]);

                    $school_created->area()->firstOrCreate([
                        'name' => $school->name,
                    ], [
                        'email' => $school->email,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
            // create office
            $this->command->warn('Create office');
            $this->command->getOutput()->progressStart(count($offices));
            foreach ($offices as $office) {
                DB::beginTransaction();

                try {
                    $office_created = Office::firstOrCreate([
                        'name' => $office->name,
                    ]);

                    $office_created->area()->firstOrCreate([
                        'name' => $office->name,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
            // create position
            $this->command->warn('Create position');
            $this->command->getOutput()->progressStart(count($positions));
            foreach ($positions as $position) {
                DB::beginTransaction();

                try {
                    $area = Area::where('name', $position->area)->firstOrFail();

                    Position::firstOrCreate([
                        'area_id' => $area->id,
                        'name' => $position->name,
                    ]);


                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();
                    dd($position->area);
                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
    }
}
