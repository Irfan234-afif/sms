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
        Schema::table('learning_objectives', function (Blueprint $table) {
            $table->string('objectiveable_type')->nullable()->after('school_subject_id');
            $table->unsignedBigInteger('objectiveable_id')->nullable()->after('objectiveable_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('learning_objectives', function (Blueprint $table) {
            $table->dropColumn(['objectiveable_type', 'objectiveable_id']);
        });
    }
};
