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
        // Add missing fields to phase_module_quiz_questions table
        Schema::table('phase_module_quiz_questions', function (Blueprint $table) {
            $table->text('explanation')->nullable()->after('order');
            $table->text('correct_answer')->nullable()->after('explanation');
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active')->after('correct_answer');
        });

        // Update quiz questions type enum to include multiple_select
        Schema::table('phase_module_quiz_questions', function (Blueprint $table) {
            $table->enum('type', ['multiple_choice', 'multiple_select', 'true_false', 'essay'])->change();
        });

        // Add missing fields to phase_module_quiz_question_options table
        Schema::table('phase_module_quiz_question_options', function (Blueprint $table) {
            $table->text('explanation')->nullable()->after('order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('phase_module_quiz_questions', function (Blueprint $table) {
            $table->dropColumn(['explanation', 'correct_answer', 'status']);
        });

        // Revert quiz questions type enum to original
        Schema::table('phase_module_quiz_questions', function (Blueprint $table) {
            $table->enum('type', ['multiple_choice', 'true_false', 'essay'])->change();
        });

        Schema::table('phase_module_quiz_question_options', function (Blueprint $table) {
            $table->dropColumn('explanation');
        });
    }
};
