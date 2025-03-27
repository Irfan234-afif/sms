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
        Schema::table('chats', function (Blueprint $table) {
            $table->dropColumn('is_read');
            $table->dateTime('sent_at')->nullable()->after('message');
        });

        Schema::create('chat_reads', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('chat_id')->constrained('chats');
            $table->foreignId('reader_id')->constrained('users');
            $table->dateTime('read_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chat_reads');

        Schema::table('chats', function (Blueprint $table) {
            $table->dropColumn('sent_at');
            $table->boolean('is_read')->default(false);
        });
    }
};
