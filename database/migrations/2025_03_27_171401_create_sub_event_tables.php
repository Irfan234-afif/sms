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
        Schema::table('sub_events', function (Blueprint $table) {
            $table->dropColumn('use_date');
        });

        Schema::table('sub_events', function (Blueprint $table) {
            $table->dateTime('start_datetime')->after('place');
            $table->dateTime('end_datetime')->after('start_datetime');
            $table->longText('description')->nullable()->after('end_datetime');
        });

        Schema::create('sub_event_objectives', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_event_id')->constrained('sub_events');
            $table->string('title');
            $table->longText('description')->nullable();
            $table->longText('remark')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_event_transportations', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_event_id')->constrained('sub_events');
            $table->string('type'); // BIKE, CAR, BUS
            $table->integer('quantity')->default(0);
            $table->decimal('unit_cost', 10, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_event_participants', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_event_id')->constrained('sub_events');
            $table->string('type'); // STUDENT, TEACHER, PARENT, GUEST, SECURITY, DOCUMENTARIAN 
            $table->integer('quantity')->default(0);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sub_events', function (Blueprint $table) {
            $table->date('use_date')->nullable();
            $table->dropColumn(['start_datetime', 'end_datetime', 'description']);
        });

        Schema::dropIfExists('sub_event_objectives');
        Schema::dropIfExists('sub_event_transportations');
        Schema::dropIfExists('sub_event_participants');
    }
};
