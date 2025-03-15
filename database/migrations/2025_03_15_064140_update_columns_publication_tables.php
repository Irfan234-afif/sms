<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Mengubah nama kolom pada tabel banners
        Schema::table('banners', function (Blueprint $table) {
            $table->renameColumn('file_name', 'image');
        });

        // Mengubah tipe data jika diperlukan (gunakan DB::statement jika tidak menggunakan doctrine/dbal)
        DB::statement("ALTER TABLE banners MODIFY COLUMN image VARCHAR(255)");

        // Mengubah nama kolom pada tabel gallery_items
        Schema::table('gallery_items', function (Blueprint $table) {
            $table->renameColumn('file_name', 'image');
        });

        // Mengubah tipe data jika diperlukan
        DB::statement("ALTER TABLE gallery_items MODIFY COLUMN image VARCHAR(255)");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Mengembalikan nama kolom pada tabel banners
        Schema::table('banners', function (Blueprint $table) {
            $table->renameColumn('image', 'file_name');
        });

        DB::statement("ALTER TABLE banners MODIFY COLUMN file_name VARCHAR(255)");

        // Mengembalikan nama kolom pada tabel gallery_items
        Schema::table('gallery_items', function (Blueprint $table) {
            $table->renameColumn('image', 'file_name');
        });

        DB::statement("ALTER TABLE gallery_items MODIFY COLUMN file_name VARCHAR(255)");
    }
};
