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
        Schema::table('tp_quiz_attempts', function (Blueprint $table) {
            // Manual grading columns
            $table->timestamp('graded_at')->nullable()->after('completed_at');
            $table->unsignedBigInteger('grader_id')->nullable()->after('graded_at');
            $table->text('grader_feedback')->nullable()->after('grader_id');
            $table->json('manual_scores')->nullable()->after('grader_feedback');
            
            // Add foreign key for grader
            $table->foreign('grader_id')->references('id')->on('profiles')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tp_quiz_attempts', function (Blueprint $table) {
            $table->dropForeign(['grader_id']);
            $table->dropColumn(['graded_at', 'grader_id', 'grader_feedback', 'manual_scores']);
        });
    }
};
