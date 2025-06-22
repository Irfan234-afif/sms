<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('module_assessments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('phase_module_id')->constrained('phase_modules')->onDelete('cascade');
            $table->string('title');
            $table->text('description')->nullable();
            $table->enum('calculation_method', ['AVERAGE', 'SUM'])->default('AVERAGE');
            $table->integer('passing_score')->default(70);
            $table->string('status')->default('active');
            $table->integer('order')->default(0);
            $table->timestamps();
        });

        Schema::create('assessment_group_indicators', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('module_assessment_id')->constrained()->onDelete('cascade');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
        });

        Schema::create('assessment_indicators', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('assessment_group_indicator_id')->constrained()->onDelete(action: 'cascade');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
        });

        Schema::create('assessment_indicator_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('assessment_indicator_id')->constrained()->onDelete('cascade');
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
        });

        Schema::create('assessment_indicator_session_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('assessment_indicator_session_id')
                  ->constrained('assessment_indicator_sessions', 'id', 'aissr_ais_id_foreign')
                  ->onDelete('cascade');
            $table->string('level');
            $table->text('description')->nullable();
            $table->integer('score')->default(0);
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('module_assessments');
        Schema::dropIfExists('assessment_group_indicators');
        Schema::dropIfExists('assessment_indicators');
        Schema::dropIfExists('assessment_indicator_sessions');
        Schema::dropIfExists('assessment_indicator_session_rubrics');
    }
};
