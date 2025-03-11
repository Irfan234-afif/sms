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
        Schema::create('operational_areas', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('operational_hours', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('operational_area_id')->constrained('operational_areas');
            $table->string('day');
            $table->time('open_time');
            $table->time('closed_time');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('post_categories', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('pages', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('type'); // 
            $table->string('title');
            $table->longText('content');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('author_id')->constrained('users');
            $table->foreignId('category_id')->nullable()->constrained('post_categories');
            $table->string('type'); // ARTICLE, NEWS
            $table->string('title');
            $table->string('slug')->unique();
            $table->longText('content');
            $table->string('thumbnail')->nullable();
            $table->datetime('published_at');
            $table->string('status');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('achievements', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->string('slug')->unique();
            $table->text('description')->nullable();
            $table->string('category');
            $table->string('status');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('banners', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->string('slug')->unique();
            $table->longText('content')->nullable();
            $table->string('file_name');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('careers', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->text('job_title');
            $table->text('job_description');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->datetime('start_datetime');
            $table->datetime('end_datetime');
            $table->string('location');
            $table->longText('content');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('faqs', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->text('question');
            $table->text('answer');
            $table->string('status');
            $table->integer('transaction_number')->default(0);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('galleries', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('title');
            $table->string('slug')->unique();
            $table->text('description');
            $table->string('status');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('gallery_items', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->foreignId('gallery_id')->constrained('galleries');
            $table->string('file_name');
            $table->text('description')->nullable();
            $table->boolean('is_thumbnail')->default(false);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('public_feedbacks', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('name');
            $table->string('email');
            $table->string('phone');
            $table->string('subject');
            $table->string('message');
            $table->datetime('readed_at')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('testimonials', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();
            $table->string('type'); // PARENT, STUDENT, TEACHER
            $table->string('name');
            $table->string('relation');
            $table->text('message');
            $table->string('avatar')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('testimonials');
        Schema::dropIfExists('public_feedbacks');
        Schema::dropIfExists('gallery_items');
        Schema::dropIfExists('galleries');
        Schema::dropIfExists('faqs');
        Schema::dropIfExists('events');
        Schema::dropIfExists('careers');
        Schema::dropIfExists('banners');
        Schema::dropIfExists('achievements');
        Schema::dropIfExists('posts');
        Schema::dropIfExists('pages');
        Schema::dropIfExists('post_categories');
        Schema::dropIfExists('operational_hours');
        Schema::dropIfExists('operational_areas');
    }
};
