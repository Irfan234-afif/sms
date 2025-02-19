<?php

namespace Database\Seeders;

use App\Models\SchoolYear;
use App\Models\AdmissionStudentQuota;
use App\Models\Product;
use App\Models\School;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class MasterSchoolSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data master
        $school_years = json_decode(file_get_contents('database/data/master/school_year.json'));

        if (App::environment(['local', 'testing'])) {
            // create school year
            $this->command->warn('Create school year');
            $this->command->getOutput()->progressStart(count($school_years));
            foreach ($school_years as $school_year) {
                DB::beginTransaction();

                try {
                    // temp seed
                    $school_year_created = SchoolYear::firstOrCreate([
                        'name' => $school_year->name,
                    ], [
                        'is_active' => $school_year->is_active,
                    ]);

                    $schools = School::get();

                    foreach ($schools as $school) {
                        foreach ($school->grades as $school_grade) {
                            AdmissionStudentQuota::firstOrCreate([
                                'school_id' => $school->id,
                                'school_year_id' => $school_year_created->id,
                                'school_grade_id' => $school_grade->id,
                            ], [
                                'max_quota' => rand(150, 200),
                                'used_quota' => rand(50, 150),
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
