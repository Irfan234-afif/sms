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
        // Update tp_participant_phase_progress
        Schema::table('tp_participant_phase_progress', function (Blueprint $table) {
            // Add new activity snapshot FK
            $table->foreignId('activity_phase_id')->nullable()->constrained('activity_phases')->onDelete('cascade');
            
            // Keep master reference for tracking
            $table->foreignId('master_phase_id')->nullable()->constrained('training_program_phases')->onDelete('set null');
            
            // Rename old FK for migration
            $table->renameColumn('phase_id', 'old_phase_id');
        });

        // Update tp_participant_module_progress
        Schema::table('tp_participant_module_progress', function (Blueprint $table) {
            // Add new activity snapshot FK
            $table->foreignId('activity_module_id')->nullable()->constrained('activity_modules')->onDelete('cascade');
            
            // Keep master reference for tracking
            $table->foreignId('master_module_id')->nullable()->constrained('phase_modules')->onDelete('set null');
            
            // Rename old FK for migration
            $table->renameColumn('module_id', 'old_module_id');
        });

        // Update tp_material_progress
        Schema::table('tp_material_progress', function (Blueprint $table) {
            // Add new activity snapshot FK
            $table->foreignId('activity_material_id')->nullable()->constrained('activity_materials')->onDelete('cascade');
            
            // Keep master reference for tracking
            $table->foreignId('master_material_id')->nullable()->constrained('phase_module_materials')->onDelete('set null');
            
            // Rename old FK for migration
            $table->renameColumn('material_id', 'old_material_id');
        });

        // Update tp_quiz_attempts
        Schema::table('tp_quiz_attempts', function (Blueprint $table) {
            // Add new activity snapshot FK
            $table->foreignId('activity_quiz_id')->nullable()->constrained('activity_quizzes')->onDelete('cascade');
            
            // Keep master reference for tracking
            $table->foreignId('master_quiz_id')->nullable()->constrained('phase_module_quizzes')->onDelete('set null');
            
            // Rename old FK for migration
            $table->renameColumn('quiz_id', 'old_quiz_id');
        });

        // Update tp_assessment_results
        Schema::table('tp_assessment_results', function (Blueprint $table) {
            // Add new activity snapshot FK
            $table->foreignId('activity_assessment_id')->nullable()->constrained('activity_assessments')->onDelete('cascade');
            
            // Keep master reference for tracking
            $table->foreignId('master_assessment_id')->nullable()->constrained('module_assessments')->onDelete('set null');
            
            // Rename old FK for migration
            $table->renameColumn('assessment_id', 'old_assessment_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Reverse tp_assessment_results
        Schema::table('tp_assessment_results', function (Blueprint $table) {
            $table->dropForeign(['activity_assessment_id']);
            $table->dropForeign(['master_assessment_id']);
            $table->dropColumn(['activity_assessment_id', 'master_assessment_id']);
            $table->renameColumn('old_assessment_id', 'assessment_id');
        });

        // Reverse tp_quiz_attempts
        Schema::table('tp_quiz_attempts', function (Blueprint $table) {
            $table->dropForeign(['activity_quiz_id']);
            $table->dropForeign(['master_quiz_id']);
            $table->dropColumn(['activity_quiz_id', 'master_quiz_id']);
            $table->renameColumn('old_quiz_id', 'quiz_id');
        });

        // Reverse tp_material_progress
        Schema::table('tp_material_progress', function (Blueprint $table) {
            $table->dropForeign(['activity_material_id']);
            $table->dropForeign(['master_material_id']);
            $table->dropColumn(['activity_material_id', 'master_material_id']);
            $table->renameColumn('old_material_id', 'material_id');
        });

        // Reverse tp_participant_module_progress
        Schema::table('tp_participant_module_progress', function (Blueprint $table) {
            $table->dropForeign(['activity_module_id']);
            $table->dropForeign(['master_module_id']);
            $table->dropColumn(['activity_module_id', 'master_module_id']);
            $table->renameColumn('old_module_id', 'module_id');
        });

        // Reverse tp_participant_phase_progress
        Schema::table('tp_participant_phase_progress', function (Blueprint $table) {
            $table->dropForeign(['activity_phase_id']);
            $table->dropForeign(['master_phase_id']);
            $table->dropColumn(['activity_phase_id', 'master_phase_id']);
            $table->renameColumn('old_phase_id', 'phase_id');
        });
    }
}; 