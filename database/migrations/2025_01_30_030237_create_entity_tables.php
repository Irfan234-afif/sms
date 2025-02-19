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
        Schema::create('school_levels', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->string('code')->unique();
            $table->integer('sort_number');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_phases', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_level_id')->constrained('school_levels');
            $table->string('title');
            $table->integer('sort_number');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_grades', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('school_level_id')->constrained('school_levels');
            $table->foreignId('school_phase_id')->constrained('school_phases');
            $table->string('title');
            $table->integer('sort_number');
            $table->timestampsTz();
            $table->softDeletes();
        });

        Schema::create('school_years', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->boolean('is_active')->default(false);
            $table->timestampsTz();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('school_years');
        Schema::dropIfExists('school_grades');
        Schema::dropIfExists('school_phases');
        Schema::dropIfExists('school_levels');
    }
};
