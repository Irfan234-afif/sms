<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('training_programs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->string('type');
            $table->string('level');
            $table->text('description')->nullable();
            $table->enum('status', ['draft', 'active', 'inactive'])->default('draft');
            $table->timestamps();
        });

        Schema::create('training_program_phases', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_id')->constrained()->onDelete('cascade');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('draft');
            $table->timestamps();
        });

        Schema::create('phase_modules', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_phase_id')->constrained()->onDelete('cascade');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('draft');
            $table->timestamps();
        });

        Schema::create('phase_module_materials', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('phase_module_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->enum('type', ['link', 'video', 'text', 'document']);
            $table->text('content')->nullable();
            $table->string('file_path')->nullable();
            $table->integer('order')->default(0);
            $table->enum('status', ['draft', 'active', 'inactive'])->default('draft');
            $table->timestamps();
        });

        Schema::create('phase_module_quizzes', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('phase_module_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->text('description')->nullable();
            $table->integer('passing_score');
            $table->integer('time_limit')->nullable(); // in minutes
            $table->enum('status', ['draft', 'active', 'inactive'])->default('draft');
            $table->timestamps();
        });

        Schema::create('phase_module_quiz_questions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('phase_module_quiz_id')->constrained()->onDelete('cascade');
            $table->text('question');
            $table->enum('type', ['multiple_choice', 'true_false', 'essay']);
            $table->integer('points')->default(1);
            $table->integer('order')->default(0);
            $table->timestamps();
        });
        
        Schema::create('phase_module_quiz_question_options', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('phase_module_quiz_question_id')
                  ->constrained('phase_module_quiz_questions', 'id', 'tmqqo_tmqq_id_foreign')
                  ->onDelete('cascade');
            $table->text('option_text');
            $table->boolean('is_correct')->default(false);
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('training_programs');
        Schema::dropIfExists('training_program_phases');
        Schema::dropIfExists('phase_modules');
        Schema::dropIfExists('training_module_materials');
        Schema::dropIfExists('training_module_quizzes');
        Schema::dropIfExists('training_module_quiz_questions');
        Schema::dropIfExists('training_module_quiz_question_options');
    }
};
