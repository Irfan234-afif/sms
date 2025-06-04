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
        Schema::create('assessment_aspect_session_rubrics', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('aspect_session_id')->constrained('assessment_aspect_sessions');
            $table->foreignId('session_rubric_id')->constrained('assessment_session_rubrics');
            $table->foreignId('rubric_scale_id')->nullable()->constrained('assessment_rubric_scales');
            $table->decimal('score', 5, 2)->nullable();
            $table->string('predicate')->nullable();
            $table->longText('narrative')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('assessment_aspect_session_rubrics');
    }
};
