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
        Schema::create('submission_groups', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name')->unique();
            $table->string('code')->unique();
            $table->string('reference_code')->unique();
            $table->integer('reference_number');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('submission_approvers', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_group_id')->constrained('submission_groups');
            $table->foreignId('area_id')->constrained('areas');
            $table->foreignId('employee_id')->constrained('employees');
            $table->integer('sort_number');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('submissions', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_group_id')->constrained('submission_groups');
            $table->foreignId('area_id')->constrained('areas');
            $table->foreignId('employee_id')->constrained('employees');
            $table->string('reference_number')->unique();
            $table->dateTime('datetime');
            $table->string('status'); // APPROVED, REJECTED, PENDING
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('submission_approvals', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->foreignId('employee_id')->constrained('employees');
            $table->integer('sort_number');
            $table->dateTime('datetime')->nullable();
            $table->string('status'); // APPROVED, REJECTED, PENDING
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_install_repairs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->foreignId('employee_assigned_id')->nullable()->constrained('employees');
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_install_repair_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_install_repair_id')->constrained('sub_install_repairs');
            $table->string('name');
            $table->integer('quantity')->default(0);
            $table->string('unit')->nullable();
            $table->date('due_date')->nullable();
            $table->text('description')->nullable();
            $table->string('status'); // APPROVED, REJECTED, PENDING
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_designs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_design_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_design_id')->constrained('sub_designs');
            $table->string('title');
            $table->date('due_date')->nullable();
            $table->string('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_documentations', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->string('title');
            $table->string('place')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_broadcasts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->date('date_schedule')->nullable();
            $table->longText('content');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_media_posts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->string('title');
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_cards', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->date('due_date')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_vehicles', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->string('name');
            $table->string('description')->nullable();
            $table->date('use_date')->nullable();
            $table->date('return_date')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_materials', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_material_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_material_id')->constrained('sub_materials');
            $table->string('name');
            $table->integer('quantity')->nullable();
            $table->string('unit')->nullable();
            $table->decimal('price', 15, 2)->default(0);
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->longText('attachment')->nullable();
            $table->date('due_date')->nullable();
            $table->string('status_approval_ga')->nullable();
            $table->string('status_approval_fa')->nullable();
            $table->text('reason')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_events', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->string('title');
            $table->string('place');
            $table->date('use_date');
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_event_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_event_id')->constrained('sub_events');
            $table->string('name');
            $table->integer('quantity')->default(0);
            $table->string('unit')->nullable();
            $table->decimal('price', 15, 2)->default(0);
            $table->decimal('bill_amount', 15, 2)->default(0);
            $table->string('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_attendances', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->string('type'); // LATE, HOME
            $table->date('date');
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_equipments', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_equipment_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_equipment_id')->constrained('sub_equipments');
            $table->string('name');
            $table->integer('quantity')->default(0);
            $table->date('due_date')->nullable();
            $table->text('description')->nullable();
            $table->string('status'); // APPROVED, REJECTED, PENDING
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_outstations', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->date('start_date');
            $table->date('end_date');
            $table->string('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_leaves', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->string('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_resignations', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('submission_id')->constrained('submissions');
            $table->date('entry_date');
            $table->date('out_date');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('sub_resignation_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('sub_resignation_id')->constrained('sub_resignations');
            $table->string('title');
            $table->text('description')->nullable();
            $table->foreignId('employee_checker_id')->nullable()->constrained('employees');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sub_resignation_items');
        Schema::dropIfExists('sub_resignations');
        Schema::dropIfExists('sub_leaves');
        Schema::dropIfExists('sub_outstations');
        Schema::dropIfExists('sub_equipment_items');
        Schema::dropIfExists('sub_equipments');
        Schema::dropIfExists('sub_attendances');
        Schema::dropIfExists('sub_event_items');
        Schema::dropIfExists('sub_events');
        Schema::dropIfExists('sub_material_items');
        Schema::dropIfExists('sub_materials');
        Schema::dropIfExists('sub_vehicles');
        Schema::dropIfExists('sub_cards');
        Schema::dropIfExists('sub_media_posts');
        Schema::dropIfExists('sub_broadcasts');
        Schema::dropIfExists('sub_documentations');
        Schema::dropIfExists('sub_design_items');
        Schema::dropIfExists('sub_designs');
        Schema::dropIfExists('sub_install_repair_items');
        Schema::dropIfExists('sub_install_repairs');
        Schema::dropIfExists('submission_approvals');
        Schema::dropIfExists('submissions');
        Schema::dropIfExists('submission_approvers');
        Schema::dropIfExists('submission_groups');
    }
};
