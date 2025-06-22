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
        Schema::table('phase_module_quizzes', function (Blueprint $table) {
            $table->dropColumn('time_limit');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('phase_module_quizzes', function (Blueprint $table) {
            $table->integer('time_limit')->nullable()->after('passing_score');
        });
    }
};
