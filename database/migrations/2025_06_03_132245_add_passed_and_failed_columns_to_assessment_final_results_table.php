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
        Schema::table('assessment_final_results', function (Blueprint $table) {
            $table->string('predicate_passed')->nullable()->after('learning_objective_failed_id');
            $table->string('predicate_failed')->nullable()->after('predicate_passed');
            $table->longText('narrative_passed')->nullable()->after('final_predicate');
            $table->longText('narrative_failed')->nullable()->after('narrative_passed');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('assessment_final_results', function (Blueprint $table) {
            $table->dropColumn([
                'predicate_passed',
                'predicate_failed',
                'narrative_passed',
                'narrative_failed',
            ]);
        });
    }
};
