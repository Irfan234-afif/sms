<?php

namespace App\Console\Commands\MigrateSchoolAction;

use App\Models\Profile;
use App\Models\SchoolClassroom;
use App\Models\SchoolClassroomMember;
use App\Models\SchoolClub;
use App\Models\SchoolClubMember;
use App\Models\SchoolExtracurricular;
use App\Models\SchoolExtracurricularMember;
use App\Models\SchoolGrade;
use App\Models\Student;
use Illuminate\Support\Str;
use Exception;

class MigrateSchoolPerson
{
    public static function execute($school)
    {
        $school_data = self::getJsonFile($school);

        self::parseStudent($school, $school_data->persons->students);
        self::parseSchoolClassroomMember($school, $school_data->persons->school_classroom_members);
        self::parseSchoolExtracurricularMember($school, $school_data->persons->school_extracurricular_members);
        self::parseSchoolClubMember($school, $school_data->persons->school_club_members);
    }

    private static function parseStudent($school, $students)
    {
        foreach ($students as $student) {
            $school_grade = SchoolGrade::where('school_level_id', $school->school_level_id)
                ->where('title', $student->grade_name)
                ->first() ?? SchoolGrade::where('school_level_id', $school->school_level_id)
                ->orderBy('sort_number', 'ASC')
                ->first();

            $existingStudent = Student::where('school_national_id', $student->national_identity_number)->first();

            if ($existingStudent) {
                $existingStudent->profile->update([
                    'name' => $student->name,
                    'birth_place' => $student->birth_place,
                    'birth_date' => $student->birth_date,
                    'gender' => self::parseColumnEnumValue($student->gender, 'gender'),
                    'blood_type' => $student->blood_type,
                    'religion' => self::parseColumnEnumValue($student->religion, 'religion'),
                    'phone' => $student->phone_number,
                    'address' => self::parseColumnAddressValue($student),
                    'postal_code' => $student->postal_code,
                ]);

                $existingStudent->profile->families()->updateOrCreate(
                    ['relation' => 'FATHER'],
                    [
                        'name' => $student->father_name,
                        'national_id' => $student->father_nationality_id,
                        'languages' => [],
                        'phone' => $student->father_phone,
                        'email' => $student->father_email,
                        'occupation' => $student->father_occupation,
                    ]
                );

                $existingStudent->profile->families()->updateOrCreate(
                    ['relation' => 'MOTHER'],
                    [
                        'name' => $student->mother_name,
                        'national_id' => $student->mother_nationality_id,
                        'languages' => [],
                        'phone' => $student->mother_phone,
                        'email' => $student->mother_email,
                        'occupation' => $student->mother_occupation,
                    ]
                );

                $existingStudent->update([
                    'school_id' => $school->id,
                    'school_grade_id' => $school_grade->id,
                ]);
            } else {
                $profile_created = Profile::create([
                    'name' => $student->name,
                    'birth_place' => $student->birth_place,
                    'birth_date' => $student->birth_date,
                    'gender' => self::parseColumnEnumValue($student->gender, 'gender'),
                    'blood_type' => $student->blood_type,
                    'religion' => self::parseColumnEnumValue($student->religion, 'religion'),
                    'phone' => $student->phone_number,
                    'address' => self::parseColumnAddressValue($student),
                    'postal_code' => $student->postal_code,
                ]);

                $profile_created->families()->updateOrCreate(
                    ['relation' => 'FATHER'],
                    [
                        'name' => $student->father_name,
                        'national_id' => $student->father_nationality_id,
                        'languages' => [],
                        'phone' => $student->father_phone,
                        'email' => $student->father_email,
                        'occupation' => $student->father_occupation,
                    ]
                );

                $profile_created->families()->updateOrCreate(
                    ['relation' => 'MOTHER'],
                    [
                        'name' => $student->mother_name,
                        'national_id' => $student->mother_nationality_id,
                        'languages' => [],
                        'phone' => $student->mother_phone,
                        'email' => $student->mother_email,
                        'occupation' => $student->mother_occupation,
                    ]
                );

                Student::create([
                    'school_national_id' => $student->national_identity_number,
                    'profile_id' => $profile_created->id,
                    'school_id' => $school->id,
                    'school_grade_id' => $school_grade->id,
                ]);
            }
        }
    }

    private static function parseSchoolClassroomMember($school, $school_classroom_members)
    {
        foreach ($school_classroom_members as $school_classroom_member) {
            $school_classroom = SchoolClassroom::where('school_id', $school->id)
                ->where('title', $school_classroom_member->school_classroom_name)
                ->firstOrFail();

            $student = Student::where('school_id', $school->id)
                ->where('school_national_id', $school_classroom_member->student_national_identity_number)
                ->first();

            if ($student && $school_classroom) {
                SchoolClassroomMember::updateOrCreate(
                    [
                        'school_classroom_id' => $school_classroom->id,
                        'student_id' => $student->id,
                    ]
                );
            }
        }
    }

    private static function parseSchoolExtracurricularMember($school, $school_extracurricular_members)
    {
        foreach ($school_extracurricular_members as $school_extracurricular_member) {
            $school_extracurricular = SchoolExtracurricular::where('school_id', $school->id)
                ->where('title', $school_extracurricular_member->school_extracurricular_name)
                ->firstOrFail();

            $student = Student::where('school_id', $school->id)
                ->where('school_national_id', $school_extracurricular_member->student_national_identity_number)
                ->first();

            if ($student && $student->active_school_classroom && $school_extracurricular) {
                SchoolExtracurricularMember::updateOrCreate(
                    [
                        'school_extracurricular_id' => $school_extracurricular->id,
                        'student_id' => $student->id,
                        'school_classroom_id' => $student->active_school_classroom->first()->id,
                    ]
                );
            }
        }
    }

    private static function parseSchoolClubMember($school, $school_club_members)
    {
        foreach ($school_club_members as $school_club_member) {
            $school_club = SchoolClub::where('school_id', $school->id)
                ->where('title', $school_club_member->school_club_name)
                ->firstOrFail();

            $student = Student::where('school_id', $school->id)
                ->where('school_national_id', $school_club_member->student_national_identity_number)
                ->first();

            if ($student && $student->active_school_classroom && $school_club) {
                SchoolClubMember::updateOrCreate(
                    [
                        'school_club_id' => $school_club->id,
                        'student_id' => $student->id,
                        'school_classroom_id' => $student->active_school_classroom->first()->id,
                    ]
                );
            }
        }
    }

    private static function parseColumnEnumValue($value, $column)
    {
        if ($column == 'gender') {
            return Str::upper($value);
        }

        if ($column == 'religion') {
            if ($value == 'buddha') {
                return 'BUDDHIST';
            }

            if ($value == 'protestant') {
                return 'CHRISTIAN';
            }

            return Str::upper($value);
        }
    }

    private static function parseColumnAddressValue($student)
    {
        $address_parts = [];

        if (!empty($student->address)) {
            $address_parts[] = ucfirst(strtolower($student->address));
        }

        if (!empty($student->village_name)) {
            $address_parts[] = "Kel. " . ucwords(strtolower($student->village_name));
        }

        if (!empty($student->district_name)) {
            $address_parts[] = "Kec. " . ucwords(strtolower($student->district_name));
        }

        if (!empty($student->regency_name)) {
            $address_parts[] = ucwords(strtolower($student->regency_name));
        }

        if (!empty($student->province_name)) {
            $address_parts[] = ucwords(strtolower($student->province_name));
        }

        return implode(', ', $address_parts);
    }

    private static function getJsonFile($school)
    {
        $schoolFiles = [
            'KB & TK Happy Holy Kids' => 'database/data/import/schools_person/school_happy_holy_kids.json',
            'SDK Harapan Bangsa' => 'database/data/import/schools_person/school_sdk_harapan_bangsa.json',
            'SMPK Harapan Bangsa' => 'database/data/import/schools_person/school_smpk_harapan_bangsa.json',
            'SMAK Harapan Bangsa' => 'database/data/import/schools_person/school_smak_harapan_bangsa.json',
        ];

        if (!isset($schoolFiles[$school->area->name])) {
            throw new Exception('School data not found');
        }

        return json_decode(file_get_contents($schoolFiles[$school->area->name]));
    }
}
