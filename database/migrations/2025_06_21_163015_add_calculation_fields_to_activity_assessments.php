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
        Schema::table('activity_assessments', function (Blueprint $table) {
            $table->enum('calculation_method', ['AVERAGE', 'SUM'])->default('AVERAGE')->after('description');
            $table->integer('passing_score')->default(70)->after('calculation_method');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('activity_assessments', function (Blueprint $table) {
            $table->dropColumn(['calculation_method', 'passing_score']);
        });
    }
};
