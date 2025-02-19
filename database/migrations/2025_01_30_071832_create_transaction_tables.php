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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->string('code');
            $table->string('type'); // SYSTEM
            $table->decimal('price', 15, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });
        // todo: paid off calculation
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('customer_id')->constrained('users');
            $table->string('type'); // SALES, PURCHASE
            $table->string('sub_type'); // ADMISSION_STUDENT_FORM
            $table->string('reference_number')->unique();
            $table->dateTime('due_date');
            $table->decimal('total_amount', 15, 2)->default(0);
            $table->decimal('discount_amount', 15, 2)->default(0);
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->decimal('paid_amount', 15, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('transaction_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('transaction_id')->constrained('transactions');
            $table->foreignId('product_id')->constrained('products');
            $table->decimal('price', 15, 2)->default(0);
            $table->integer('quantity')->default(0);
            $table->decimal('total_amount', 15, 2)->default(0);
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->json('options')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
        // todo: field amount
        Schema::create('transaction_payments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('transaction_id')->constrained('transactions');
            $table->string('reference_number')->unique();
            $table->string('type'); // ONLINE, OFFLINE
            $table->decimal('amount', 15, 2)->default(0);
            $table->json('options')->nullable();
            $table->string('status');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaction_payments');
        Schema::dropIfExists('transaction_items');
        Schema::dropIfExists('transactions');
        Schema::dropIfExists('products');
    }
};
