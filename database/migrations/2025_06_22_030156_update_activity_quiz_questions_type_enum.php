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
        // Add missing fields to activity_quiz_questions table
        Schema::table('activity_quiz_questions', function (Blueprint $table) {
            $table->integer('points')->default(1)->after('order');
            $table->text('explanation')->nullable()->after('points');
            $table->text('correct_answer')->nullable()->after('explanation');
            $table->enum('status', ['draft', 'active', 'inactive'])->default('active')->after('correct_answer');
        });

        // Update activity_quiz_questions type enum to include multiple_select
        Schema::table('activity_quiz_questions', function (Blueprint $table) {
            $table->enum('type', ['multiple_choice', 'multiple_select', 'true_false', 'essay'])->change();
        });

        // Add missing fields to activity_quiz_question_options table
        Schema::table('activity_quiz_question_options', function (Blueprint $table) {
            $table->text('explanation')->nullable()->after('order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('activity_quiz_questions', function (Blueprint $table) {
            $table->dropColumn(['points', 'explanation', 'correct_answer', 'status']);
        });

        // Revert to original enum values
        Schema::table('activity_quiz_questions', function (Blueprint $table) {
            $table->enum('type', ['multiple_choice', 'true_false', 'essay'])->change();
        });

        Schema::table('activity_quiz_question_options', function (Blueprint $table) {
            $table->dropColumn('explanation');
        });
    }
};
