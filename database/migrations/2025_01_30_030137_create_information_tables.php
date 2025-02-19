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
        Schema::create('families', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('name');
            $table->string('relation'); // FATHER, MOTHER, ETC
            $table->string('national_identity_number')->nullable()->unique();
            $table->string('birth_place');
            $table->date('birth_date');
            $table->string('education')->nullable();
            $table->string('occupation')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('academic_records', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('title');
            $table->string('institution');
            $table->string('attachment')->nullable();
            $table->date('graduation_date');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('training_records', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('title');
            $table->string('institution');
            $table->string('attachment')->nullable();
            $table->date('completion_date');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('specializations', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('type');
            $table->string('major');
            $table->string('minor');
            $table->string('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('experiences', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('position');
            $table->string('institution');
            $table->date('start_date');
            $table->date('end_date');
            $table->text('reason_out');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('certifications', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('type');
            $table->string('subject');
            $table->string('institution');
            $table->string('attachment')->nullable();
            $table->date('certification_date');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('community_involvements', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('title');
            $table->string('location');
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->string('position');
            $table->text('responsibility');
            $table->string('status')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('honor_prizes', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('title');
            $table->string('level');
            $table->date('award_date');
            $table->string('institution');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('language_skills', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('profile_id')->constrained('profiles')->cascadeOnDelete();
            $table->string('title');
            $table->string('reading');
            $table->string('writing');
            $table->string('speaking');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('attachments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->morphs('model');
            $table->string('title');
            $table->string('file_name')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attachments');
        Schema::dropIfExists('language_skills');
        Schema::dropIfExists('honor_prizes');
        Schema::dropIfExists('community_involvements');
        Schema::dropIfExists('certifications');
        Schema::dropIfExists('experiences');
        Schema::dropIfExists('specializations');
        Schema::dropIfExists('training_records');
        Schema::dropIfExists('academic_records');
        Schema::dropIfExists('families');
    }
};
