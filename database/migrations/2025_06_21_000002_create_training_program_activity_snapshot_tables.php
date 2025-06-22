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
        // 1. Snapshot Training Program metadata
        Schema::create('activity_training_programs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_id')->constrained('training_program_activities')->onDelete('cascade');
            $table->foreignId('master_training_program_id')->nullable()->constrained('training_programs')->onDelete('set null');
            $table->string('name');
            $table->string('type');
            $table->string('level');
            $table->text('description')->nullable();
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active');
            $table->timestamps();
        });

        // 2. Snapshot Phases
        Schema::create('activity_phases', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_training_program_id')->constrained('activity_training_programs')->onDelete('cascade');
            $table->foreignId('master_phase_id')->nullable()->constrained('training_program_phases')->onDelete('set null');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active');
            $table->timestamps();
        });

        // 3. Snapshot Modules
        Schema::create('activity_modules', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_phase_id')->constrained('activity_phases')->onDelete('cascade');
            $table->foreignId('master_module_id')->nullable()->constrained('phase_modules')->onDelete('set null');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active');
            $table->timestamps();
        });

        // 4. Snapshot Materials
        Schema::create('activity_materials', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_module_id')->constrained('activity_modules')->onDelete('cascade');
            $table->foreignId('master_material_id')->nullable()->constrained('phase_module_materials')->onDelete('set null');
            $table->string('title');
            $table->text('description')->nullable();
            $table->enum('type', ['text', 'video', 'document', 'link'])->default('text');
            $table->text('content')->nullable();
            $table->string('url')->nullable();
            $table->string('file_path')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active');
            $table->timestamps();
        });

        // 5. Snapshot Quizzes
        Schema::create('activity_quizzes', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_module_id')->constrained('activity_modules')->onDelete('cascade');
            $table->foreignId('master_quiz_id')->nullable()->constrained('phase_module_quizzes')->onDelete('set null');
            $table->string('title');
            $table->text('description')->nullable();
            $table->decimal('passing_score', 5, 2)->default(70.00);
            $table->integer('max_attempts')->default(3);
            $table->boolean('show_results')->default(true);
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active');
            $table->timestamps();
        });

        // 6. Snapshot Quiz Questions
        Schema::create('activity_quiz_questions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_quiz_id')->constrained('activity_quizzes')->onDelete('cascade');
            $table->foreignId('master_question_id')->nullable()->constrained('phase_module_quiz_questions')->onDelete('set null');
            $table->text('question_text');
            $table->enum('type', ['multiple_choice', 'true_false', 'essay'])->default('multiple_choice');
            $table->integer('order')->default(0);
            $table->timestamps();
        });

        // 7. Snapshot Quiz Question Options
        Schema::create('activity_quiz_question_options', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->unsignedBigInteger('activity_quiz_question_id');
            $table->unsignedBigInteger('master_option_id')->nullable();
            $table->text('option_text');
            $table->boolean('is_correct')->default(false);
            $table->integer('order')->default(0);
            $table->timestamps();
            
            $table->foreign('activity_quiz_question_id', 'act_opt_quest_fk')->references('id')->on('activity_quiz_questions')->onDelete('cascade');
            $table->foreign('master_option_id', 'act_opt_mst_fk')->references('id')->on('phase_module_quiz_question_options')->onDelete('set null');
        });

        // 8. Snapshot Assessments
        Schema::create('activity_assessments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_module_id')->constrained('activity_modules')->onDelete('cascade');
            $table->foreignId('master_assessment_id')->nullable()->constrained('module_assessments')->onDelete('set null');
            $table->string('title');
            $table->text('description')->nullable();
            $table->timestamps();
        });

        // 9. Snapshot Assessment Group Indicators
        Schema::create('activity_assessment_group_indicators', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->unsignedBigInteger('activity_assessment_id');
            $table->unsignedBigInteger('master_group_indicator_id')->nullable();
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
            
            $table->foreign('activity_assessment_id', 'act_grp_ind_ass_fk')->references('id')->on('activity_assessments')->onDelete('cascade');
            $table->foreign('master_group_indicator_id', 'act_grp_ind_mst_fk')->references('id')->on('assessment_group_indicators')->onDelete('set null');
        });

        // 10. Snapshot Assessment Indicators
        Schema::create('activity_assessment_indicators', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->unsignedBigInteger('activity_group_indicator_id');
            $table->unsignedBigInteger('master_indicator_id')->nullable();
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
            
            $table->foreign('activity_group_indicator_id', 'act_ind_grp_fk')->references('id')->on('activity_assessment_group_indicators')->onDelete('cascade');
            $table->foreign('master_indicator_id', 'act_ind_mst_fk')->references('id')->on('assessment_indicators')->onDelete('set null');
        });

        // 11. Snapshot Assessment Indicator Sessions
        Schema::create('activity_assessment_indicator_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->unsignedBigInteger('activity_indicator_id');
            $table->unsignedBigInteger('master_session_id')->nullable();
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
            
            $table->foreign('activity_indicator_id', 'act_sess_ind_fk')->references('id')->on('activity_assessment_indicators')->onDelete('cascade');
            $table->foreign('master_session_id', 'act_sess_mst_fk')->references('id')->on('assessment_indicator_sessions')->onDelete('set null');
        });

        // 12. Snapshot Assessment Rubrics
        Schema::create('activity_assessment_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->unsignedBigInteger('activity_session_id');
            $table->unsignedBigInteger('master_rubric_id')->nullable();
            $table->string('level');
            $table->text('description');
            $table->decimal('score', 5, 2);
            $table->integer('order')->default(0);
            $table->timestamps();
            
            $table->foreign('activity_session_id', 'act_rub_sess_fk')->references('id')->on('activity_assessment_indicator_sessions')->onDelete('cascade');
            $table->foreign('master_rubric_id', 'act_rub_mst_fk')->references('id')->on('assessment_indicator_session_rubrics')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('activity_assessment_rubrics');
        Schema::dropIfExists('activity_assessment_indicator_sessions');
        Schema::dropIfExists('activity_assessment_indicators');
        Schema::dropIfExists('activity_assessment_group_indicators');
        Schema::dropIfExists('activity_assessments');
        Schema::dropIfExists('activity_quiz_question_options');
        Schema::dropIfExists('activity_quiz_questions');
        Schema::dropIfExists('activity_quizzes');
        Schema::dropIfExists('activity_materials');
        Schema::dropIfExists('activity_modules');
        Schema::dropIfExists('activity_phases');
        Schema::dropIfExists('activity_training_programs');
    }
}; 