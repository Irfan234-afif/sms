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
        Schema::create('school_curriculums', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->string('title');
            $table->string('code');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('learning_objective_categories', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_curriculum_id')->constrained('school_curriculums');
            $table->foreignId('parent_id')->nullable()->constrained('learning_objective_categories');
            $table->string('title');
            $table->string('code');
            $table->json('options')->nullable();
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('learning_objectives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_curriculum_id')->constrained('school_curriculums');
            $table->foreignId('category_id')->constrained('learning_objective_categories');
            $table->foreignId('parent_id')->nullable()->constrained('learning_objectives');
            $table->foreignId('school_year_id')->nullable()->constrained('school_years');
            $table->foreignId('school_phase_id')->nullable()->constrained('school_phases');
            $table->foreignId('school_grade_id')->nullable()->constrained('school_grades');
            $table->foreignId('school_subject_id')->nullable()->constrained('school_subjects');
            $table->longText('title');
            $table->longText('code');
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('learning_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_curriculum_id')->constrained('school_curriculums');
            $table->string('title');
            $table->string('code');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('learning_rubric_scales', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('rubric_id')->constrained('learning_rubrics');
            $table->string('title');
            $table->decimal('value', 8, 2);
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('subject_thresholds', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_subject_id')->constrained('school_subjects');
            $table->foreignId('school_year_id')->nullable()->constrained('school_years');
            $table->foreignId('school_grade_id')->nullable()->constrained('school_grades');
            $table->decimal('minimum_value', 8, 2);
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('subject_threshold_scales', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('threshold_id')->constrained('subject_thresholds');
            $table->decimal('value', 8, 2);
            $table->string('predicate');
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('subject_threshold_narratives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('threshold_id')->constrained('subject_thresholds');
            $table->decimal('value', 8, 2);
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_objective_categories', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('extracurricular_id')->constrained('school_extracurriculars');
            $table->foreignId('parent_id')->nullable()->constrained('extracurricular_objective_categories');
            $table->string('title');
            $table->string('code');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_objectives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('extracurricular_id')->constrained('school_extracurriculars');
            $table->foreignId('category_id')->constrained('extracurricular_objective_categories');
            $table->foreignId('parent_id')->nullable()->constrained('extracurricular_objectives');
            $table->foreignId('school_year_id')->nullable()->constrained('school_years');
            $table->longText('title');
            $table->longText('code');
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('extracurricular_id')->constrained('school_extracurriculars');
            $table->string('title');
            $table->string('code');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_rubric_scales', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('rubric_id')->constrained('extracurricular_rubrics');
            $table->string('title');
            $table->decimal('value', 8, 2);
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_thresholds', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('extracurricular_id')->constrained('school_extracurriculars');
            $table->foreignId('school_year_id')->nullable()->constrained('school_years');
            $table->decimal('minimum_value', 8, 2);
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_threshold_scales', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('threshold_id')->constrained('extracurricular_thresholds');
            $table->decimal('value', 8, 2);
            $table->string('predicate');
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });

        Schema::create('extracurricular_threshold_narratives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('threshold_id')->constrained('extracurricular_thresholds');
            $table->decimal('value', 8, 2);
            $table->longText('narrative');
            $table->timestamps();
            $table->softDeletesTz();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('extracurricular_threshold_narratives');
        Schema::dropIfExists('extracurricular_threshold_scales');
        Schema::dropIfExists('extracurricular_thresholds');
        Schema::dropIfExists('extracurricular_rubric_scales');
        Schema::dropIfExists('extracurricular_rubrics');
        Schema::dropIfExists('extracurricular_objectives');
        Schema::dropIfExists('extracurricular_objective_categories');
        Schema::dropIfExists('subject_threshold_narratives');
        Schema::dropIfExists('subject_threshold_scales');
        Schema::dropIfExists('subject_thresholds');
        Schema::dropIfExists('learning_rubric_scales');
        Schema::dropIfExists('learning_rubrics');
        Schema::dropIfExists('learning_objectives');
        Schema::dropIfExists('learning_objective_categories');
        Schema::dropIfExists('school_curriculums');
    }
};
