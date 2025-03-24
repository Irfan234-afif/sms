<?php

namespace App\Console\Commands\MigrateSchoolAction;

use App\Models\LearningObjective;
use App\Models\LearningObjectiveCategory;
use App\Models\LearningRubric;
use App\Models\LearningRubricScale;
use App\Models\School;
use App\Models\SchoolCurriculum;
use App\Models\SchoolGrade;
use App\Models\SchoolPhase;
use App\Models\SchoolSubject;
use App\Models\SchoolYear;
use App\Models\SubjectThreshold;
use App\Models\SubjectThresholdNarrative;
use App\Models\SubjectThresholdScale;
use Exception;

class MigrateSchoolTeachingProgramAcademic
{
    public static function execute($school)
    {
        $school_data = self::getJsonFile($school);

        self::parseSchoolCurriculum($school, $school_data->teaching_programs->school_curriculums);
        self::parseSchoolSubjectTreshold($school, $school_data->teaching_programs->school_subject_predicates);
    }

    private static function parseSchoolCurriculum($school, $school_curriculums)
    {
        foreach ($school_curriculums as $school_curriculum) {
            $school_curriculum_created = SchoolCurriculum::firstOrCreate([
                'school_id' => $school->id,
                'code' => $school_curriculum->code,
            ], [
                'title' => $school_curriculum->name,
            ]);
            // set component learnings
            self::parseLearningObjectiveCategories($school_curriculum_created, $school_curriculum->components->learning_objective_categories);
            self::parseLearningObjectives($school, $school_curriculum_created, $school_curriculum->components->learning_objectives);
            self::parseLearningRubrics($school_curriculum_created, $school_curriculum->components->rubrics);
        }
    }

    private static function parseLearningObjectiveCategories($school_curriculum_created, $learning_objective_categories)
    {
        foreach ($learning_objective_categories as $learning_objective_category) {
            $learning_objective_category_created = LearningObjectiveCategory::firstOrCreate([
                'school_curriculum_id' => $school_curriculum_created->id,
                'code' => $learning_objective_category->code,
            ], [
                'title' => $learning_objective_category->name,
                'options' => $learning_objective_category->options,
            ]);

            foreach ($learning_objective_category->childs as $child) {
                LearningObjectiveCategory::firstOrCreate([
                    'school_curriculum_id' => $school_curriculum_created->id,
                    'parent_id' => $learning_objective_category_created->id,
                    'code' => $child->code,
                ], [
                    'title' => $child->name,
                    'options' => $child->options,
                ]);
            }
        }
    }

    private static function parseLearningObjectives($school, $school_curriculum_created, $learning_objectives)
    {
        foreach ($learning_objectives as $learning_objective) {
            $learning_objective_category_group = LearningObjectiveCategory::where('school_curriculum_id', $school_curriculum_created->id)
                ->where('title', $learning_objective->learning_component_title)
                ->first();

            if ($learning_objective_category_group) {
                $school_year_group = $learning_objective->school_year_title === '_UNKNOWN'
                    ? SchoolYear::where('start_year', $learning_objective->school_year_title)->first()
                    : SchoolYear::where('start_year', $learning_objective->school_year_title)->firstOrFail();

                $school_phase_group = $learning_objective->school_phase_title === '_UNKNOWN'
                    ? SchoolPhase::where('school_level_id', $school->school_level_id)
                    ->where('title', self::getEnglishPhase($learning_objective->school_phase_title))
                    ->first()
                    : SchoolPhase::where('school_level_id', $school->school_level_id)
                    ->where('title', self::getEnglishPhase($learning_objective->school_phase_title))
                    ->firstOrFail();

                $school_grade_group = $learning_objective->school_grade_title === '_UNKNOWN'
                    ? SchoolGrade::where('school_level_id', $school->school_level_id)
                    ->where('title', $learning_objective->school_grade_title)
                    ->first()
                    : SchoolGrade::where('school_level_id', $school->school_level_id)
                    ->where('title', $learning_objective->school_grade_title)
                    ->firstOrFail();

                $school_subject_group = $learning_objective->school_subject_title === '_UNKNOWN'
                    ? SchoolSubject::where('school_id', $school->id)
                    ->where('title', $learning_objective->school_subject_title)
                    ->first()
                    : SchoolSubject::where('school_id', $school->id)
                    ->where('title', $learning_objective->school_subject_title)
                    ->firstOrFail();

                $learning_objective_created = LearningObjective::firstOrCreate([
                    'category_id' => $learning_objective_category_group->id,
                    'school_curriculum_id' => $school_curriculum_created->id,
                    'school_year_id' => $school_year_group ? $school_year_group->id : null,
                    'school_phase_id' => $school_phase_group ? $school_phase_group->id : null,
                    'school_grade_id' => $school_grade_group ? $school_grade_group->id : null,
                    'school_subject_id' => $school_subject_group ? $school_subject_group->id : null,
                    'code' => $learning_objective->code,
                ], [
                    'title' => $learning_objective->title,
                    'narrative' => $learning_objective->narrative,
                ]);
            }

            foreach ($learning_objective->childs as $child) {
                $learning_objective_category_child = LearningObjectiveCategory::where('school_curriculum_id', $school_curriculum_created->id)
                    ->where('title', $child->learning_component_title)
                    ->first();

                if ($learning_objective_category_child) {
                    $school_year_child = $child->school_year_title === '_UNKNOWN'
                        ? SchoolYear::where('start_year', $child->school_year_title)->first()
                        : SchoolYear::where('start_year', $child->school_year_title)->firstOrFail();

                    $school_phase_child = $child->school_phase_title === '_UNKNOWN'
                        ? SchoolPhase::where('school_level_id', $school->school_level_id)
                        ->where('title', self::getEnglishPhase($child->school_phase_title))
                        ->first()
                        : SchoolPhase::where('school_level_id', $school->school_level_id)
                        ->where('title', self::getEnglishPhase($child->school_phase_title))
                        ->firstOrFail();

                    $school_grade_child = $child->school_grade_title === '_UNKNOWN'
                        ? SchoolGrade::where('school_level_id', $school->school_level_id)
                        ->where('title', $child->school_grade_title)
                        ->first()
                        : SchoolGrade::where('school_level_id', $school->school_level_id)
                        ->where('title', $child->school_grade_title)
                        ->firstOrFail();

                    $school_subject_child = $child->school_subject_title === '_UNKNOWN'
                        ? SchoolSubject::where('school_id', $school->id)
                        ->where('title', $child->school_subject_title)
                        ->first()
                        : SchoolSubject::where('school_id', $school->id)
                        ->where('title', $child->school_subject_title)
                        ->firstOrFail();

                    LearningObjective::firstOrCreate([
                        'category_id' => $learning_objective_category_child->id,
                        'school_curriculum_id' => $school_curriculum_created->id,
                        'school_year_id' => $school_year_child ? $school_year_child->id : null,
                        'school_phase_id' => $school_phase_child ? $school_phase_child->id : null,
                        'school_grade_id' => $school_grade_child ? $school_grade_child->id : null,
                        'school_subject_id' => $school_subject_child ? $school_subject_child->id : null,
                        'parent_id' => $learning_objective_created->id,
                        'code' => $child->code,
                    ], [
                        'title' => $child->title,
                        'narrative' => $child->narrative,
                    ]);
                }
            }
        }
    }

    private static function parseLearningRubrics($school_curriculum_created, $learning_rubrics)
    {
        foreach ($learning_rubrics as $learning_rubric) {
            $learning_rubric_created = LearningRubric::firstOrCreate([
                'school_curriculum_id' => $school_curriculum_created->id,
                'code' => $learning_rubric->code,
            ], [
                'title' => $learning_rubric->title,
            ]);

            foreach ($learning_rubric->scales as $scale) {
                LearningRubricScale::firstOrCreate([
                    'rubric_id' => $learning_rubric_created->id,
                    'title' => $scale->title,
                ], [
                    'narrative' => $scale->narrative,
                    'value' => $scale->value,
                ]);
            }
        }
    }

    private static function parseSchoolSubjectTreshold($school, $school_subject_tresholds)
    {
        foreach ($school_subject_tresholds as $school_subject_treshold) {
            $school_year = $school_subject_treshold->school_year_title === '_UNKNOWN'
                ? SchoolYear::where('start_year', $school_subject_treshold->school_year_title)->first()
                : SchoolYear::where('start_year', $school_subject_treshold->school_year_title)->firstOrFail();

            $school_grade = $school_subject_treshold->school_grade_title === '_UNKNOWN'
                ? SchoolGrade::where('school_level_id', $school->school_level_id)
                ->where('title', $school_subject_treshold->school_grade_title)
                ->first()
                : SchoolGrade::where('school_level_id', $school->school_level_id)
                ->where('title', $school_subject_treshold->school_grade_title)
                ->firstOrFail();

            $school_subject = $school_subject_treshold->school_subject_title === '_UNKNOWN'
                ? SchoolSubject::where('school_id', $school->id)
                ->where('title', $school_subject_treshold->school_subject_title)
                ->first()
                : SchoolSubject::where('school_id', $school->id)
                ->where('title', $school_subject_treshold->school_subject_title)
                ->firstOrFail();

            $school_subject_treshold_created = SubjectThreshold::firstOrCreate([
                'school_year_id' => $school_year ? $school_year->id : null,
                'school_grade_id' => $school_grade ? $school_grade->id : null,
                'school_subject_id' => $school_subject ? $school_subject->id : null,
            ], [
                'minimum_value' => $school_subject_treshold->minimum_value,
            ]);

            foreach ($school_subject_treshold->scales as $scale) {
                SubjectThresholdScale::firstOrCreate([
                    'threshold_id' => $school_subject_treshold_created->id,
                    'value' => $scale->value,
                ], [
                    'predicate' => $scale->predicate,
                    'narrative' => $scale->narrative,
                ]);
            }

            foreach ($school_subject_treshold->lowest_narratives as $lowest_narrative) {
                SubjectThresholdNarrative::firstOrCreate([
                    'threshold_id' => $school_subject_treshold_created->id,
                    'value' => $lowest_narrative->value,
                ], [
                    'narrative' => $lowest_narrative->narrative,
                ]);
            }
        }
    }

    private static function getEnglishPhase($n)
    {
        $phases = [
            "Fase Pondasi" => "Foundation Phase",
            "Fase A" => "Phase A",
            "Fase B" => "Phase B",
            "Fase C" => "Phase C",
            "Fase D" => "Phase D",
            "Fase E" => "Phase E",
            "Fase F" => "Phase F"
        ];

        if (!$phases[$n]) {
            dd("Unknown Key $n");
        }

        return $phases[$n] ?? "Unknown Phase";
    }

    private static function getJsonFile($school)
    {
        $schoolFiles = [
            'KB & TK Happy Holy Kids' => 'database/data/import/schools_teaching_program_academic/school_happy_holy_kids.json',
            'SDK Harapan Bangsa' => 'database/data/import/schools_teaching_program_academic/school_sdk_harapan_bangsa.json',
            'SMPK Harapan Bangsa' => 'database/data/import/schools_teaching_program_academic/school_smpk_harapan_bangsa.json',
            'SMAK Harapan Bangsa' => 'database/data/import/schools_teaching_program_academic/school_smak_harapan_bangsa.json',
        ];

        if (!isset($schoolFiles[$school->area->name])) {
            throw new Exception('School data not found');
        }

        return json_decode(file_get_contents($schoolFiles[$school->area->name]));
    }
}
