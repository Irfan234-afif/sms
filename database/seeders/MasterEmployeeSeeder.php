<?php

namespace Database\Seeders;

use App\Models\Area;
use App\Models\Employee;
use App\Models\Position;
use App\Models\Profile;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use PDO;

class MasterEmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data default
        $employees = json_decode(file_get_contents('database/data/import/employee.json'));

        if (App::environment(['local', 'testing', 'production'])) {
            // create employee
            $this->command->warn('Create employee');
            $this->command->getOutput()->progressStart(count($employees));
            foreach ($employees as $employee) {
                DB::beginTransaction();

                try {
                    $profile_created = Profile::create([
                        'national_id' => $employee->national_id,
                        'name' => $employee->name,
                        'birth_place' => $employee->birth_place,
                        'birth_date' => $employee->birth_date,
                        'gender' => $employee->gender,
                        'blood_type' => $employee->blood_type,
                        'religion' => $employee->religion,
                        'marital_status' => $employee->marital_status,
                        'address' => $employee->address,
                        'email' => $employee->email,
                    ]);

                    $employee_created = Employee::updateOrCreate([
                        'profile_id' => $profile_created->id,
                    ], [
                        'identity_number' => $employee->identity_number,
                        'start_date' => $employee->start_date,
                        'end_date' => $employee->end_date,
                        'status' => $employee->status,
                    ]);

                    if ($employee->area && $employee->position) {
                        $area = Area::where('name', $employee->area)->firstOrFail();
                        $position = $area->positions()
                            ->where('name', $employee->position)
                            ->firstOrFail();

                        $employee_created->assignments()->updateOrCreate([
                            'area_id' => $area->id,
                            'position_id' => $position->id,
                        ]);
                    }

                    if ($employee->email && $employee->password) {
                        $user_created = User::updateOrCreate([
                            'profile_id' => $profile_created->id,
                        ], [
                            'name' => $employee->name,
                            'email' => $employee->email,
                            'password' => $employee->password,
                            'email_verified_at' => now(),
                        ]);

                        $user_created->syncRoles(['Employee']);
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
