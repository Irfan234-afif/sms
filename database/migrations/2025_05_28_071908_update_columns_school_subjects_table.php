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
        Schema::table('school_subjects', function (Blueprint $table) {
            $table->dropForeign(['school_subject_group_id']);
        });

        Schema::table('school_subjects', function (Blueprint $table) {
            $table->foreignId('school_subject_group_id')->nullable()->change();
            $table->text('description')->nullable()->change();
        });

        Schema::table('school_subjects', function (Blueprint $table) {
            $table->foreign('school_subject_group_id')->references('id')->on('school_subject_groups');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('school_subjects', function (Blueprint $table) {
            $table->dropForeign(['school_subject_group_id']);
        });

        Schema::table('school_subjects', function (Blueprint $table) {
            $table->foreignId('school_subject_group_id')->nullable(false)->change();
            $table->string('description')->nullable(false)->change();
        });

        Schema::table('school_subjects', function (Blueprint $table) {
            $table->foreign('school_subject_group_id')->references('id')->on('school_subject_groups');
        });
    }
};
