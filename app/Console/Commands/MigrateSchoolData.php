<?php

namespace App\Console\Commands;

use App\Console\Commands\MigrateSchoolAction\MigrateSchoolEntity;
use App\Console\Commands\MigrateSchoolAction\MigrateSchoolPerson;
use App\Console\Commands\MigrateSchoolAction\MigrateSchoolTeachingProgramAcademic;
use App\Models\School;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class MigrateSchoolData extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:migrate-school-data';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $schools = School::get();

        $this->info('migrating school entity...');
        try {
            DB::beginTransaction();

            $this->withProgressBar($schools, function ($school) {
                MigrateSchoolEntity::execute($school);
            });

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;

            $this->error("error to execute:$th->getMessage()");
        }
        $this->newLine();
        $this->info('migrating school person...');
        try {
            DB::beginTransaction();

            $this->withProgressBar($schools, function ($school) {
                MigrateSchoolPerson::execute($school);
            });

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;

            $this->error("error to execute:$th->getMessage()");
        }
        $this->newLine();
        // $this->info('migrating school teaching program academic...');
        // try {
        //     DB::beginTransaction();

        //     $this->withProgressBar($schools, function ($school) {
        //         MigrateSchoolTeachingProgramAcademic::execute($school);
        //     });

        //     DB::commit();
        // } catch (\Throwable $th) {
        //     DB::rollBack();

        //     throw $th;

        //     $this->error("error to execute:$th->getMessage()");
        // }
        // $this->newLine();
    }
}
