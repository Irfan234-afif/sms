<?php

namespace Database\Seeders;

use App\Models\Profile;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use PDO;

class DefaultUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data default
        $users = json_decode(file_get_contents('database/data/default/user.json'));

        if (App::environment(['local', 'testing', 'production'])) {
            // create user
            $this->command->warn('Create user');
            $this->command->getOutput()->progressStart(count($users));
            foreach ($users as $user) {
                DB::beginTransaction();

                try {
                    $profile_created = Profile::updateOrCreate([
                        'name' => $user->name,
                        'email' => $user->email,
                    ]);

                    $user_created = User::firstOrCreate([
                        'profile_id' => $profile_created->id,
                    ], [
                        'name' => $user->name,
                        'email' => $user->email,
                        'password' => $user->password,
                        'email_verified_at' => now(),
                        'remember_token' => Str::random(10),
                    ]);

                    $user_created->syncRoles($user->roles);

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
