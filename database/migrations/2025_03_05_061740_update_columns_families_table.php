<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('families', function (Blueprint $table) {
            $indexes = DB::select("SHOW INDEX FROM families WHERE Column_name = 'national_identity_number' AND Non_unique = 0");
            if (!empty($indexes)) {
                $table->dropUnique('families_national_identity_number_unique'); // Sesuaikan dengan nama yang ditemukan
            }
            $table->renameColumn('national_identity_number', 'national_id');
            $table->string('avatar')->nullable()->after('name');
            $table->string('birth_place')->nullable()->change();
            $table->string('birth_date')->nullable()->change();
            $table->string('religion')->nullable()->after('birth_date');
            $table->json('languages')->nullable()->after('religion');
            $table->string('phone')->nullable()->after('languages');
            $table->string('address')->nullable()->after('phone');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('families', function (Blueprint $table) {
            $table->renameColumn('national_id', 'national_identity_number');
            $table->unique('national_identity_number');
            $table->dropColumn(['avatar', 'religion', 'languages', 'phone', 'address']);
            $table->string('birth_place')->nullable(false)->change();
            $table->string('birth_date')->nullable(false)->change();
        });
    }
};
