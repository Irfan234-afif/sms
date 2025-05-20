<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('assessment_modules', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_curriculum_id')->constrained('school_curriculums');
            $table->string('name');
            $table->longText('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('module_id')->constrained('assessment_modules');
            $table->string('name');
            $table->longText('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_rubric_scales', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('rubric_id')->constrained('assessment_rubrics');
            $table->decimal('score', 5, 2)->nullable();
            $table->string('predicate')->nullable();
            $table->longText('narrative')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_aspects', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('module_id')->constrained('assessment_modules');
            $table->string('name');
            $table->integer('sort_number');
            $table->boolean('use_session')->default(false);
            $table->boolean('use_final_score')->default(false);
            $table->string('final_score_method')->nullable();
            $table->boolean('use_learning_objective')->default(false);
            $table->foreignId('learning_objective_category_id')->nullable()->constrained('learning_objective_categories');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_final_rules', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('module_id')->constrained('assessment_modules');
            $table->string('name');
            $table->integer('sort_number');
            $table->boolean('use_score')->default(false);
            $table->string('score_type')->nullable();
            $table->boolean('use_predicate')->default(false);
            $table->string('predicate_type')->nullable();
            $table->boolean('use_narrative')->default(false);
            $table->string('narrative_type')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_rule_scores', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('final_rule_id')->constrained('assessment_final_rules');
            $table->foreignId('aspect_id')->constrained('assessment_aspects');
            $table->decimal('portion_score', 5, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_rule_narratives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('final_rule_id')->constrained('assessment_final_rules');
            $table->foreignId('aspect_id')->constrained('assessment_aspects');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_records', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_academic_program_id')->constrained('school_academic_programs');
            $table->foreignId('school_classroom_id')->constrained('school_classrooms');
            $table->foreignId('school_subject_id')->nullable()->constrained('school_subjects');
            $table->foreignId('module_id')->constrained('assessment_modules');
            $table->string('name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('record_id')->constrained('assessment_records');
            $table->foreignId('aspect_id')->constrained('assessment_aspects');
            $table->foreignId('learning_objective_id')->nullable()->constrained('learning_objectives');
            $table->string('name');
            $table->integer('sort_number');
            $table->string('type')->nullable();
            $table->foreignId('rubric_id')->nullable()->constrained('assessment_rubrics');
            $table->date('date')->nullable();
            $table->decimal('portion_score', 5, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_students', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('record_id')->constrained('assessment_records');
            $table->foreignId('student_id')->constrained('students');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_aspect_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('assessment_student_id')->constrained('assessment_students');
            $table->foreignId('session_id')->constrained('assessment_sessions');
            $table->decimal('score', 5, 2)->nullable();
            $table->decimal('final_score', 5, 2)->nullable();
            $table->string('predicate')->nullable();
            $table->text('narrative')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('assessment_final_results', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('assessment_student_id')->constrained('assessment_students');
            $table->foreignId('final_rule_id')->constrained('assessment_final_rules');
            $table->decimal('score', 5, 2)->nullable();
            $table->string('predicate')->nullable();
            $table->text('narrative')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('assessment_final_results');
        Schema::dropIfExists('assessment_aspect_sessions');
        Schema::dropIfExists('assessment_students');
        Schema::dropIfExists('assessment_sessions');
        Schema::dropIfExists('assessment_records');
        Schema::dropIfExists('assessment_rule_narratives');
        Schema::dropIfExists('assessment_rule_scores');
        Schema::dropIfExists('assessment_final_rules');
        Schema::dropIfExists('assessment_aspects');
        Schema::dropIfExists('assessment_rubric_scales');
        Schema::dropIfExists('assessment_rubrics');
        Schema::dropIfExists('assessment_modules');
    }
};
