<?php

namespace App\Console\Commands;

use App\Console\Commands\MigrateSchoolAction\MigrateSchoolEntity;
use App\Console\Commands\MigrateSchoolAction\MigrateSchoolPerson;
use App\Console\Commands\MigrateSchoolAction\MigrateSchoolTeachingProgramAcademic;
use App\Models\AssessmentRecord;
use App\Models\LearningObjective;
use App\Models\School;
use App\Models\SchoolSubject;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class ParseDynamicModel extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:parse-dynamic-model';

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
        $this->info('parsing learning objective...');
        try {
            DB::beginTransaction();

            $learning_objectives = LearningObjective::whereNotNull('school_subject_id')->get();

            foreach ($learning_objectives as $learning_objective) {
                $learning_objective->update([
                    'objectiveable_type' => SchoolSubject::class,
                    'objectiveable_id' => $learning_objective->school_subject_id,
                ]);
            }

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;

            $this->error("error to execute:$th->getMessage()");
        }

        $this->info('parsing assessment record...');
        try {
            DB::beginTransaction();

            $assessment_records = AssessmentRecord::whereNotNull('school_subject_id')->get();

            foreach ($assessment_records as $assessment_record) {
                $assessment_record->update([
                    'assessable_type' => SchoolSubject::class,
                    'assessable_id' => $assessment_record->school_subject_id,
                ]);
            }

            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();

            throw $th;

            $this->error("error to execute:$th->getMessage()");
        }
    }
}
