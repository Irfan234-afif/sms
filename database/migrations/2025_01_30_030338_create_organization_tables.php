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
        // office
        Schema::create('offices', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('areas', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->morphs('model');
            $table->string('name');
            $table->string('phone')->nullable();
            $table->string('email')->nullable();
            $table->string('hotline')->nullable();
            $table->text('address')->nullable();
            $table->string('logo')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('positions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('area_id')->constrained('areas');
            $table->string('name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles');
            $table->string('identity_number')->unique();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->string('status'); // PERMANENT, CONTRACT, PROBATION, DAILY, PART_TIME
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('employee_assignments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('employee_id')->constrained('employees');
            $table->foreignId('area_id')->constrained('areas');
            $table->foreignId('position_id')->constrained('positions');
            $table->timestamps();
            $table->softDeletes();
        });
        //  school
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

        Schema::create('school_majors', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->string('title');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_classrooms', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->foreignId('school_grade_id')->constrained('school_grades');
            $table->foreignId('school_major_id')->nullable()->constrained('school_majors');
            $table->foreignId('homeroom_teacher_id')->nullable()->constrained('employees');
            $table->string('title');
            $table->integer('capacity')->default(0);
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_extracurriculars', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->foreignId('mentor_id')->nullable()->constrained('employees');
            $table->string('title');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_clubs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->foreignId('mentor_id')->nullable()->constrained('employees');
            $table->string('title');
            $table->timestampsTz();
            $table->softDeletes();
        });

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

        Schema::create('student_guardians', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('student_id')->constrained('students');
            $table->foreignId('guardian_id')->constrained('users');
            $table->timestampsTz();
        });
        // remove for future
        Schema::create('student_schools', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->foreignId('school_classroom_id')->constrained('school_classrooms');
            $table->foreignId('student_id')->constrained('students');
            $table->timestampsTz();
            $table->softDeletes();
        });


        Schema::create('school_extracurricular_members', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_extracurricular_id')->constrained('school_extracurriculars');
            $table->foreignId('student_id')->constrained('students');
            $table->foreignId('school_classroom_id')->constrained('school_classrooms');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_club_members', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_club_id')->constrained('school_clubs');
            $table->foreignId('student_id')->constrained('students');
            $table->foreignId('school_classroom_id')->constrained('school_classrooms');
            $table->timestampsTz();
            $table->softDeletes();
        });
        Schema::create('school_subject_groups', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_id')->constrained('schools');
            $table->string('title');
            $table->timestampsTz();
            $table->softDeletes();
        });

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

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('school_subjects');
        Schema::dropIfExists('school_subject_groups');
        Schema::dropIfExists('school_club_members');
        Schema::dropIfExists('school_extracurricular_members');
        Schema::dropIfExists('student_schools');
        Schema::dropIfExists('student_guardians');
        Schema::dropIfExists('students');
        Schema::dropIfExists('school_clubs');
        Schema::dropIfExists('school_extracurriculars');
        Schema::dropIfExists('school_classrooms');
        Schema::dropIfExists('school_majors');
        Schema::dropIfExists('schools');
        Schema::dropIfExists('employee_assignments');
        Schema::dropIfExists('employees');
        Schema::dropIfExists('positions');
        Schema::dropIfExists('areas');
        Schema::dropIfExists('offices');
    }
};
