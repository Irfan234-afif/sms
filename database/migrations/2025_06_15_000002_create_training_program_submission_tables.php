<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Main training program submissions table
        Schema::create('training_program_submissions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            
            // Submission workflow integration
            $table->foreignId('submission_id')->nullable()->constrained('submissions')->onDelete('cascade');
            $table->foreignId('submitter_id')->constrained('employees')->onDelete('cascade');
            $table->string('reference_number')->unique();
            
            // Training type and references
            $table->enum('training_type', ['internal', 'external'])->default('internal');
            $table->foreignId('training_program_id')->nullable()->constrained('training_programs')->onDelete('set null');
            
            // External training fields (when training_type = 'external')
            $table->string('external_training_title')->nullable();
            $table->string('external_training_provider')->nullable();
            $table->text('external_training_description')->nullable();
            $table->string('external_training_location')->nullable();
            $table->string('external_training_method')->nullable(); // online, offline, hybrid
            
            // Schedule information
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->time('daily_start_time')->nullable();
            $table->time('daily_end_time')->nullable();
            $table->json('training_days')->nullable(); // ["monday", "tuesday", etc]
            
            // Submission details
            $table->text('justification')->nullable();
            $table->text('expected_outcomes')->nullable();
            $table->decimal('total_budget', 15, 2)->default(0);
            
            // Status and workflow
            $table->dateTime('datetime');
            
            $table->timestamps();
            $table->softDeletes();
        });

        // Goals/learning outcomes (Knowledge, Skill, Attitude)
        Schema::create('training_program_submission_goals', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_submission_id')->constrained('training_program_submissions', 'id', 'tps_goals_submission_fk')->onDelete('cascade');
            
            $table->enum('goal_type', ['knowledge', 'skill', 'attitude']);
            $table->text('description');
            $table->text('success_indicator')->nullable();
            $table->integer('order')->default(0);
            
            $table->timestamps();
        });

        // Budget breakdown with categories
        Schema::create('training_program_submission_budget_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_submission_id')->constrained('training_program_submissions', 'id', 'tps_budget_submission_fk')->onDelete('cascade');
            
            $table->enum('category', [
                'venue', 'instructor_fee', 'material', 'equipment', 
                'transportation', 'accommodation', 'meal', 'certification', 'other'
            ]);
            $table->string('item_name');
            $table->text('description')->nullable();
            $table->integer('quantity')->default(1);
            $table->decimal('unit_price', 15, 2)->default(0);
            $table->decimal('total_price', 15, 2)->default(0);
            $table->text('notes')->nullable();
            
            $table->timestamps();
        });

        // Participants (multiple participants per submission)
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

        // Document attachments
        Schema::create('training_program_submission_attachments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('training_program_submission_id')->constrained('training_program_submissions', 'id', 'tps_attachment_submission_fk')->onDelete('cascade');
            
            $table->string('file_name');
            $table->string('file_path');
            $table->string('file_type')->nullable();
            $table->bigInteger('file_size')->nullable(); // in bytes
            $table->enum('attachment_type', [
                'proposal', 'brochure', 'curriculum', 'quotation', 'agreement', 'other'
            ])->default('other');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('training_program_submission_attachments');
        Schema::dropIfExists('training_program_submission_participants');
        Schema::dropIfExists('training_program_submission_budget_items');
        Schema::dropIfExists('training_program_submission_goals');
        Schema::dropIfExists('training_program_submissions');
    }
}; 