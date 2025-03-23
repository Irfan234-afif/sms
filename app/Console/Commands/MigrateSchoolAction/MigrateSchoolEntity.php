<?php

namespace App\Console\Commands\MigrateSchoolAction;

use App\Models\SchoolClassroom;
use App\Models\SchoolClub;
use App\Models\SchoolExtracurricular;
use App\Models\SchoolGrade;
use App\Models\SchoolMajor;
use App\Models\SchoolSubject;
use App\Models\SchoolSubjectGroup;
use App\Models\SchoolYear;
use Exception;

class MigrateSchoolEntity
{
    public static function execute($school)
    {
        $school_data = self::getJsonFile($school);

        self::parseSchoolYear($school_data->entities->school_years);
        self::parseSchoolMajor($school, $school_data->entities->school_majors);
        self::parseSchoolSubject($school, $school_data->entities->school_subjects);
        self::parseSchoolClassroom($school, $school_data->entities->school_classrooms);
        self::parseSchoolExtracurricular($school, $school_data->entities->school_extracurriculars);
        self::parseSchoolClub($school, $school_data->entities->school_clubs);
    }

    private static function parseSchoolYear($school_years)
    {
        foreach ($school_years as $school_year) {
            SchoolYear::firstOrCreate([
                'start_year' => $school_year->start_year,
            ], [
                'name' => $school_year->title,
                'start_year' => $school_year->start_year,
                'end_year' => $school_year->end_year,
            ]);
        }
    }

    private static function parseSchoolMajor($school, $school_majors)
    {
        foreach ($school_majors as $school_major) {
            SchoolMajor::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_major->name,
            ], [
                'title' => $school_major->name,
            ]);
        }
    }

    private static function parseSchoolSubject($school, $school_subjects)
    {
        foreach ($school_subjects as $school_subject) {
            $school_subject_group = SchoolSubjectGroup::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_subject->group_name,
            ]);

            SchoolSubject::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_subject->name,
            ], [
                'school_subject_group_id' => $school_subject_group->id,
                'alternative_title' => $school_subject->alternative_name,
                'description' => '-',
            ]);
        }
    }

    private static function parseSchoolClassroom($school, $school_classrooms)
    {
        foreach ($school_classrooms as $school_classroom) {
            $school_grade = SchoolGrade::where('school_level_id', $school->school_level_id)
                ->where('title', $school_classroom->grade_name)
                ->firstOrFail();
            $school_major = SchoolMajor::where('school_id', $school->id)
                ->where('title', $school_classroom->major_name)
                ->first();

            SchoolClassroom::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_classroom->name,
            ], [
                'school_grade_id' => $school_grade->id,
                'school_major_id' => $school_major ? $school_major->id : null,
                'capacity' => $school_classroom->capacity,
            ]);
        }
    }

    private static function parseSchoolExtracurricular($school, $school_extracurriculars)
    {
        foreach ($school_extracurriculars as $school_extracurricular) {
            SchoolExtracurricular::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_extracurricular->name,
            ], [
                'title' => $school_extracurricular->name,
            ]);
        }
    }

    private static function parseSchoolClub($school, $school_clubs)
    {
        foreach ($school_clubs as $school_club) {
            SchoolClub::firstOrCreate([
                'school_id' => $school->id,
                'title' => $school_club->name,
            ], [
                'title' => $school_club->name,
            ]);
        }
    }

    private static function getJsonFile($school)
    {
        $schoolFiles = [
            'KB & TK Happy Holy Kids' => 'database/data/import/schools_entity/school_happy_holy_kids.json',
            'SDK Harapan Bangsa' => 'database/data/import/schools_entity/school_sdk_harapan_bangsa.json',
            'SMPK Harapan Bangsa' => 'database/data/import/schools_entity/school_smpk_harapan_bangsa.json',
            'SMAK Harapan Bangsa' => 'database/data/import/schools_entity/school_smak_harapan_bangsa.json',
        ];

        if (!isset($schoolFiles[$school->area->name])) {
            throw new Exception('School data not found');
        }

        return json_decode(file_get_contents($schoolFiles[$school->area->name]));
    }
}
