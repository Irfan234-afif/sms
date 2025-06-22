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
        Schema::table('tp_assessment_results', function (Blueprint $table) {
            // Add unique constraint to prevent duplicate assessment results
            $table->unique(
                ['participant_id', 'activity_assessment_id'], 
                'unique_participant_activity_assessment'
            );
            
            // Add index for better query performance
            $table->index('activity_assessment_id', 'idx_activity_assessment');
            $table->index('master_assessment_id', 'idx_master_assessment');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tp_assessment_results', function (Blueprint $table) {
            $table->dropUnique('unique_participant_activity_assessment');
            $table->dropIndex('idx_activity_assessment');
            $table->dropIndex('idx_master_assessment');
        });
    }
};
