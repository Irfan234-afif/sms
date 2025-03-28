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
        Schema::table('sub_attendances', function (Blueprint $table) {
            $table->longText('description')->change();
            $table->string('attachment')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sub_attendances', function (Blueprint $table) {
            $table->text('description')->change();
            $table->dropColumn('attachment');
        });
    }
};
