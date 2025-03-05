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
        if (!Schema::hasTable('offices')) {
            Schema::create('offices', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->string('name');
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('areas')) {
            Schema::create('areas', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->morphs('model');
                $table->string('name');
                $table->string('phone')->nullable();
                $table->string('email')->nullable();
                $table->string('hotline')->nullable();
                $table->text('address')->nullable();
                $table->string('logo')->nullable();
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('positions')) {
            Schema::create('positions', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('area_id')->constrained('areas');
                $table->string('name');
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('employees')) {
            Schema::create('employees', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('profile_id')->constrained('profiles');
                $table->string('identity_number')->unique();
                $table->date('start_date')->nullable();
                $table->date('end_date')->nullable();
                $table->string('status'); // PERMANENT, CONTRACT, PROBATION, DAILY, PART_TIME
                $table->timestamps();
                $table->softDeletes();
            });
        }

        if (!Schema::hasTable('employee_assignments')) {
            Schema::create('employee_assignments', function (Blueprint $table) {
                $table->id();
                $table->uuid('uuid')->unique();
                $table->foreignId('employee_id')->constrained('employees');
                $table->foreignId('area_id')->constrained('areas');
                $table->foreignId('position_id')->constrained('positions');
                $table->timestamps();
                $table->softDeletes();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::dropIfExists('employee_assignments');
        // Schema::dropIfExists('employees');
        // Schema::dropIfExists('positions');
        // Schema::dropIfExists('areas');
        // Schema::dropIfExists('offices');
    }
};
