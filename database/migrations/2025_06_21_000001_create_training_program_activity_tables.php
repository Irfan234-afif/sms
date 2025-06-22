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
        // Tabel utama untuk Training Program Activity
        Schema::create('training_program_activities', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->text('description')->nullable();
            $table->foreignId('training_program_id')->nullable()->constrained('training_programs')->onDelete('cascade');
            $table->foreignId('submission_id')->nullable()->constrained('submissions')->onDelete('cascade');
            $table->date('start_date');
            $table->date('end_date');
            $table->enum('status', ['PLANNED', 'ONGOING', 'COMPLETED'])->default('PLANNED');
            $table->string('location')->nullable();
            $table->string('external_provider')->nullable(); // untuk training eksternal
            $table->foreignId('created_by')->constrained('profiles')->onDelete('cascade');
            $table->timestamps();
        });

        // Tabel untuk peserta activity
        Schema::create('tp_activity_participants', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('activity_id')->constrained('training_program_activities')->onDelete('cascade');
            $table->foreignId('profile_id')->constrained('profiles')->onDelete('cascade');
            $table->date('enrollment_date');
            $table->date('completion_date')->nullable();
            $table->decimal('overall_progress', 5, 2)->default(0);
            $table->boolean('certificate_issued')->default(false);
            $table->string('certificate_number')->nullable();
            $table->timestamps();
            
            $table->unique(['activity_id', 'profile_id'], 'tp_activity_participants_unique');
        });

        // Tabel untuk progress phase per participant
        Schema::create('tp_participant_phase_progress', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('participant_id')->constrained('tp_activity_participants')->onDelete('cascade');
            $table->foreignId('phase_id')->constrained('training_program_phases')->onDelete('cascade');
            $table->timestamp('started_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->decimal('progress_percentage', 5, 2)->default(0);
            $table->timestamps();
            
            $table->unique(['participant_id', 'phase_id'], 'tp_participant_phase_unique');
        });

        // Tabel untuk progress module per participant
        Schema::create('tp_participant_module_progress', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('participant_id')->constrained('tp_activity_participants')->onDelete('cascade');
            $table->foreignId('module_id')->constrained('phase_modules')->onDelete('cascade');
            $table->timestamp('started_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->enum('status', ['NOT_STARTED', 'IN_PROGRESS', 'COMPLETED'])->default('NOT_STARTED');
            $table->decimal('progress_percentage', 5, 2)->default(0);
            $table->timestamps();
            
            $table->unique(['participant_id', 'module_id'], 'tp_participant_module_unique');
        });

        // Tabel untuk tracking material yang sudah dilihat
        Schema::create('tp_material_progress', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('participant_id')->constrained('tp_activity_participants')->onDelete('cascade');
            $table->foreignId('material_id')->constrained('phase_module_materials')->onDelete('cascade');
            $table->timestamp('viewed_at')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->integer('time_spent')->default(0); // dalam detik
            $table->timestamps();
            
            $table->unique(['participant_id', 'material_id'], 'tp_material_progress_unique');
        });

        // Tabel untuk quiz attempts
        Schema::create('tp_quiz_attempts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('participant_id')->constrained('tp_activity_participants')->onDelete('cascade');
            $table->foreignId('quiz_id')->constrained('phase_module_quizzes')->onDelete('cascade');
            $table->integer('attempt_number');
            $table->decimal('score', 5, 2)->nullable();
            $table->boolean('passed')->default(false);
            $table->timestamp('started_at');
            $table->timestamp('completed_at')->nullable();
            $table->json('answers')->nullable(); // menyimpan jawaban peserta
            $table->timestamps();
        });

        // Tabel untuk assessment results
        Schema::create('tp_assessment_results', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('participant_id')->constrained('tp_activity_participants')->onDelete('cascade');
            $table->foreignId('assessment_id')->constrained('module_assessments')->onDelete('cascade');
            $table->foreignId('assessor_id')->constrained('profiles')->onDelete('cascade');
            $table->json('scores'); // menyimpan skor per indicator
            $table->decimal('final_score', 5, 2)->nullable();
            $table->text('feedback')->nullable();
            $table->timestamp('assessed_at');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tp_assessment_results');
        Schema::dropIfExists('tp_quiz_attempts');
        Schema::dropIfExists('tp_material_progress');
        Schema::dropIfExists('tp_participant_module_progress');
        Schema::dropIfExists('tp_participant_phase_progress');
        Schema::dropIfExists('tp_activity_participants');
        Schema::dropIfExists('training_program_activities');
    }
};