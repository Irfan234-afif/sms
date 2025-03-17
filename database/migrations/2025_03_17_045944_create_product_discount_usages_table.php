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

        Schema::table('products', function (Blueprint $table) {
            $table->foreignId('area_id')->nullable()->constrained('areas')->after('uuid');
            $table->boolean('is_active')->default(false)->after('price');
        });

        Schema::create('discounts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->string('code')->unique();
            $table->string('type');
            $table->text('description')->nullable();
            $table->decimal('value', 15, 2)->default(0);
            $table->dateTime('starts_at')->nullable();
            $table->dateTime('ends_at')->nullable();
            $table->integer('quota')->nullable();
            $table->integer('used_quota')->default(0);
            $table->boolean('is_active')->default(false);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('discount_usages', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('area_id')->constrained('areas');
            $table->foreignId('discount_id')->constrained('discounts');
            $table->timestamps();
        });

        Schema::create('transaction_discounts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('transaction_id')->constrained('transactions');
            $table->foreignId('discount_id')->constrained('discounts');
            $table->string('type');
            $table->decimal('value', 15, 2)->default(0);
            $table->decimal('amount_discount', 15, 2)->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaction_discounts');
        Schema::dropIfExists('discount_usages');
        Schema::dropIfExists('discounts');
        Schema::table('products', function (Blueprint $table) {
            $table->dropForeign(['area_id']);
            $table->dropColumn(['area_id', 'is_active']);
        });
    }
};
