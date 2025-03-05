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
        if (!Schema::hasTable('schools')) {
            Schema::create('schools', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_level_id')->constrained('school_levels');
                $table->foreignId('headmaster_id')->nullable()->constrained('employees');
                $table->boolean('use_major')->default(false);
                $table->boolean('use_subject')->default(false);
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_majors')) {
            Schema::create('school_majors', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->string('title'); // todo: change title to name
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_classrooms')) {
            Schema::create('school_classrooms', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('school_grade_id')->constrained('school_grades');
                $table->foreignId('school_major_id')->nullable()->constrained('school_majors');
                $table->foreignId('homeroom_teacher_id')->nullable()->constrained('employees');
                $table->string('title'); // todo: change title to name
                $table->integer('capacity')->default(0);
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_extracurriculars')) {
            Schema::create('school_extracurriculars', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('mentor_id')->nullable()->constrained('employees');
                $table->string('title'); // todo: change title to name
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_clubs')) {
            Schema::create('school_clubs', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('mentor_id')->nullable()->constrained('employees');
                $table->string('title'); // todo: change title to name
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('students')) {
            Schema::create('students', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('profile_id')->constrained('profiles');
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('school_grade_id')->constrained('school_grades');
                $table->string('school_national_id')->unique();
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('student_guardians')) {
            Schema::create('student_guardians', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('student_id')->constrained('students');
                $table->foreignId('guardian_id')->constrained('users');
                $table->timestampsTz();
            });
        }

        // todo: remove table student_schools for future
        if (!Schema::hasTable('student_schools')) {
            Schema::create('student_schools', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('school_classroom_id')->constrained('school_classrooms');
                $table->foreignId('student_id')->constrained('students');
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_classroom_members')) {
            Schema::create('school_classroom_members', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_classroom_id')->constrained('school_classrooms');
                $table->foreignId('student_id')->constrained('students');
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_extracurricular_members')) {
            Schema::create('school_extracurricular_members', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_extracurricular_id')->constrained('school_extracurriculars');
                $table->foreignId('student_id')->constrained('students');
                $table->foreignId('school_classroom_id')->constrained('school_classrooms');
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_club_members')) {
            Schema::create('school_club_members', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_club_id')->constrained('school_clubs');
                $table->foreignId('student_id')->constrained('students');
                $table->foreignId('school_classroom_id')->constrained('school_classrooms');
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_subject_groups')) {
            Schema::create('school_subject_groups', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->string('title');
                $table->timestampsTz();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('school_subjects')) {
            Schema::create('school_subjects', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('school_id')->constrained('schools');
                $table->foreignId('school_subject_group_id')->constrained('school_subject_groups');
                $table->string('title');
                $table->string('description');
                $table->timestampsTz();
                $table->softDeletes();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::dropIfExists('school_subjects');
        // Schema::dropIfExists('school_subject_groups');
        // Schema::dropIfExists('school_club_members');
        // Schema::dropIfExists('school_extracurricular_members');
        // Schema::dropIfExists('school_classroom_members');
        // Schema::dropIfExists('student_schools');
        // Schema::dropIfExists('student_guardians');
        // Schema::dropIfExists('students');
        // Schema::dropIfExists('school_clubs');
        // Schema::dropIfExists('school_extracurriculars');
        // Schema::dropIfExists('school_classrooms');
        // Schema::dropIfExists('school_majors');
        // Schema::dropIfExists('schools');
    }
};
