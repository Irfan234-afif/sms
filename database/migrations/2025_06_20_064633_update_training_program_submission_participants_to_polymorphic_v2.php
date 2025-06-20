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
        // Drop the old table
        Schema::dropIfExists('training_program_submission_participants');
        
        // Create the new table with polymorphic relationships
        Schema::create('training_program_submission_participants', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_submission_id')->constrained('training_program_submissions', 'id', 'tps_participant_submission_fk')->onDelete('cascade');
            
            // Polymorphic relationship for participants - with custom index names
            $table->string('participant_type');
            $table->unsignedBigInteger('participant_id');
            $table->index(['participant_type', 'participant_id'], 'tps_participant_morph_idx');
            
            $table->text('role_description')->nullable();
            $table->text('selection_reason')->nullable();
            $table->boolean('is_primary_participant')->default(false);
            $table->integer('order')->default(0);
            
            $table->timestamps();
            
            // Ensure unique participant per submission
            $table->unique(['training_program_submission_id', 'participant_type', 'participant_id'], 'tps_participant_morph_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop the new table
        Schema::dropIfExists('training_program_submission_participants');
        
        // Recreate the old table
        Schema::create('training_program_submission_participants', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_submission_id')->constrained('training_program_submissions', 'id', 'tps_participant_submission_fk')->onDelete('cascade');
            $table->foreignId('profile_id')->constrained('profiles')->onDelete('cascade');
            
            $table->text('role_description')->nullable();
            $table->text('selection_reason')->nullable();
            $table->boolean('is_primary_participant')->default(false);
            $table->integer('order')->default(0);
            
            $table->timestamps();
            
            // Ensure unique participant per submission
            $table->unique(['training_program_submission_id', 'profile_id'], 'tps_participant_unique');
        });
    }
};
