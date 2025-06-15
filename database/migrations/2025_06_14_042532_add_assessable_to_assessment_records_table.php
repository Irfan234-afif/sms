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
        Schema::table('assessment_records', function (Blueprint $table) {
            $table->string('assessable_type')->nullable()->after('school_subject_id');
            $table->unsignedBigInteger('assessable_id')->nullable()->after('assessable_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('assessment_records', function (Blueprint $table) {
            $table->dropColumn(['assessable_type', 'assessable_id']);
        });
    }
};
