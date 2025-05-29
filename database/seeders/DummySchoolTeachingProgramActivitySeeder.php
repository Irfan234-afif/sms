<?php

namespace Database\Seeders;

use App\Models\LearningObjective;
use App\Models\LearningObjectiveCategory;
use App\Models\School;
use App\Models\SchoolAcademicProgram;
use App\Models\SchoolCurriculum;
use App\Models\SchoolYear;
use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DummySchoolTeachingProgramActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public $faker;

    public function run(): void
    {
        $school_curriculums = json_decode(file_get_contents('database/data/dummy/school_curriculum.json'));
        $this->faker = Factory::create();

        // Create school curriculum
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create school curriculum');
            $this->command->getOutput()->progressStart(count($school_curriculums));
            foreach ($school_curriculums as $school_curriculum) {
                DB::beginTransaction();

                try {
                    foreach ($school_curriculums as $school_curriculum) {
                        $school = School::whereHas('level', function ($level) use ($school_curriculum) {
                            $level->where('code', $school_curriculum->school_level_code);
                        })->firstOrFail();

                        $school_curriculum_created = SchoolCurriculum::updateOrCreate([
                            'school_id' => $school->id,
                            'code' => $school_curriculum->code,
                        ], [
                            'title' => $school_curriculum->title,
                        ]);

                        // learning objective category
                        $this->createLearningObjectiveCategory($school_curriculum_created, $school_curriculum->learning_objective_categories);

                        // assessment module
                        $this->createAssessmentModule($school_curriculum_created, $school_curriculum->assessment_modules);
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

        // Create school academic program
        if (App::environment(['local', 'testing'])) {
            $schools = School::whereIn('id', [1, 2, 3, 4])->get();
            $school_year = SchoolYear::latest()->first();
            $this->command->warn('Create school academic program');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    SchoolAcademicProgram::updateOrCreate([
                        'school_id' => $school->id,
                        'school_year_id' => $school_year->id,
                        'school_curriculum_id' => $school->curriculums()->first()->id,
                    ], [
                        'name' => 'Program Ajaran' . ' ' . $school_year->start_year . ' ' . $school_year->end_year,
                        'is_active' => true,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }

        // Fill learning objective
        if (App::environment(['local', 'testing'])) {
            $schools = School::whereIn('id', [1, 2, 3, 4])->get();
            $this->command->warn('Fill learning objective');
            $this->command->getOutput()->progressStart(count($schools));
            foreach ($schools as $school) {
                DB::beginTransaction();

                try {
                    // fill learning objective
                    $this->fillLearningObjective($school);

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

    private function createLearningObjectiveCategory($school_curriculum, $learning_objective_categories)
    {
        foreach ($learning_objective_categories as $learning_objective_category) {
            $learning_objective_category_created = $school_curriculum->learning_objective_categories()->updateOrCreate([
                'code' => $learning_objective_category->code,
            ], [
                'title' => $learning_objective_category->title,
                'options' => $learning_objective_category->options,
            ]);

            foreach ($learning_objective_category->childs as $child) {
                $learning_objective_category_created->childs()->updateOrCreate([
                    'school_curriculum_id' => $school_curriculum->id,
                    'code' => $child->code,
                ], [
                    'title' => $child->title,
                    'options' => $child->options,
                ]);
            }
        }
    }

    private function createAssessmentModule($school_curriculum, $assessment_modules)
    {
        foreach ($assessment_modules as $assessment_module) {
            $assessment_module_created = $school_curriculum->assessment_modules()->updateOrCreate([
                'name' => $assessment_module->name,
            ], [
                'type' => $assessment_module->type,
                'description' => $assessment_module->description,
            ]);
            // aspects
            foreach ($assessment_module->aspects as $aspect) {
                $assessment_module_created->aspects()->updateOrCreate([
                    'name' => $aspect->name,
                ], [
                    'sort_order' => $aspect->sort_order,
                    'use_sessions' => $aspect->use_sessions,
                    'total_sessions' => $aspect->total_sessions,
                    'use_final_score' => $aspect->use_final_score,
                    'final_score_method' => $aspect->final_score_method,
                    'use_learning_objective' => $aspect->use_learning_objective,
                    'learning_objective_category_id' => LearningObjectiveCategory::where('school_curriculum_id', $school_curriculum->id)->where('code', $aspect->learning_objective_category_code)->first()?->id,
                ]);
            }
            // rubrics
            foreach ($assessment_module->rubrics as $rubric) {
                $assessment_rubric_created = $assessment_module_created->rubrics()->updateOrCreate([
                    'name' => $rubric->name,
                ], [
                    'description' => $rubric->description,
                ]);
                // scales
                foreach ($rubric->scales as $scale) {
                    $assessment_rubric_created->scales()->updateOrCreate([
                        'score' => $scale->score,
                    ], [
                        'predicate' => $scale->predicate,
                        'narrative' => $scale->narrative,
                    ]);
                }
            }
            // thresholds
            foreach ($assessment_module->thresholds as $threshold) {
                $assessment_threshold_created = $assessment_module_created->thresholds()->updateOrCreate([
                    'name' => $threshold->name,
                ], [
                    'description' => $threshold->description,
                ]);
                // scales
                foreach ($threshold->scales as $scale) {
                    $assessment_threshold_created->scales()->updateOrCreate([
                        'score' => $scale->score,
                    ], [
                        'status' => $scale->status,
                        'predicate' => $scale->predicate,
                        'narrative' => $scale->narrative,
                    ]);
                }
            }
            // final_rules
            foreach ($assessment_module->final_rules as $final_rule) {
                $assessment_final_rule_created =  $assessment_module_created->final_rules()->updateOrCreate([
                    'name' => $final_rule->name,
                ], [
                    'sort_order' => $final_rule->sort_order,
                    'use_score' => $final_rule->use_score,
                    'score_method' => $final_rule->score_method,
                    'use_predicate' => $final_rule->use_predicate,
                    'predicate_method' => $final_rule->predicate_method,
                    'use_narrative' => $final_rule->use_narrative,
                    'narrative_method' => $final_rule->narrative_method,
                ]);

                foreach ($final_rule->final_scores as $final_score) {
                    $assessment_final_rule_created->scores()->updateOrCreate([
                        'aspect_id' => $assessment_module_created->aspects()->where('name', $final_score->aspect_name)->first()->id,
                    ], [
                        'portion_score' => $final_score->portion_score,
                    ]);
                }

                foreach ($final_rule->final_narratives as $final_narrative) {
                    $assessment_final_rule_created->narratives()->updateOrCreate([
                        'aspect_id' => $assessment_module_created->aspects()->where('name', $final_narrative->aspect_name)->first()->id,
                    ]);
                }
            }
        }
    }

    private function fillLearningObjective($school)
    {
        $school_curriculum = $school->academic_program_active->curriculum;

        foreach ($school_curriculum->learning_objective_categories as $category) {
            $options = $category->options;

            $school_years = $options['scope_school_year'] ? [$school->academic_program_active->year] : [null];
            $school_phases      = $options['scope_school_phase'] ? $school->level->phases : [null];
            $school_grades      = $options['scope_school_grade'] ? $school->level->grades : [null];
            $school_subjects    = $options['scope_school_subject'] ? $school->subjects : [null];

            foreach ($school_years as $year) {
                foreach ($school_phases as $phase) {
                    foreach ($school_grades as $grade) {
                        foreach ($school_subjects as $subject) {
                            foreach (range(1, 25) as $index) {
                                $learning_objective_parent = null;
                                if ($category->parent) {
                                    $parent_options = $category->parent->options;

                                    $learning_objective_parent = LearningObjective::where([
                                        'school_curriculum_id' => $school_curriculum->id,
                                        'category_id' => $category->parent->id,
                                        'school_phase_id' => $parent_options['scope_school_phase'] ? $phase->id : null,
                                        'school_grade_id' => $parent_options['scope_school_grade'] ? $grade->id : null,
                                        'school_subject_id' => $parent_options['scope_school_subject'] ? $subject->id : null,
                                        'school_year_id' => $parent_options['scope_school_year'] ? $year->id : null,
                                    ])->firstOrFail();
                                }

                                LearningObjective::updateOrCreate([
                                    'school_curriculum_id' => $school_curriculum->id,
                                    'category_id' => $category->id,
                                    'school_phase_id' => $phase?->id,
                                    'school_grade_id' => $grade?->id,
                                    'school_subject_id' => $subject?->id,
                                    'school_year_id' => $year?->id,
                                    'code' => $category->code . '-' . $index,
                                ], [
                                    'parent_id' => $learning_objective_parent?->id,
                                    'title' => $category->title . ' ' . $this->faker->sentence,
                                    'narrative' => $this->faker->paragraph,
                                ]);
                            }
                        }
                    }
                }
            }
        }
    }
}
