<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // default
        $this->command->warn('Executing default seeder');
        $this->call(DefaultSystemSeeder::class);
        $this->call(DefaultOrganizationSeeder::class);
        $this->call(DefaultUserSeeder::class);
        // master
        $this->command->warn('Executing master seeder');
        $this->call(MasterOfficeSeeder::class);
        $this->call(MasterSchoolSeeder::class);
        $this->call(MasterEmployeeSeeder::class);
        // dummy
        $this->command->warn('Executing dummy seeder');
        $this->call(DummySchoolManagementSeeder::class);
        $this->call(DummyPublicationActivitySeeder::class);
        $this->call(DummySubmissionActivitySeeder::class);
        $this->call(DummyAdmissionStudentActivitySeeder::class);
        // 
    }
}
