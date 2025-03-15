<?php

namespace Database\Seeders;

use App\Models\Achievement;
use App\Models\Career;
use App\Models\Event;
use App\Models\Faq;
use App\Models\Gallery;
use App\Models\OperationalArea;
use App\Models\OperationalHour;
use App\Models\Post;
use App\Models\PostCategory;
use App\Models\Testimonial;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DummyPublicationActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public $faker;

    public function run(): void
    {
        $this->faker = Factory::create();
        $days = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];
        // Create operational area
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create operational area');
            $this->command->getOutput()->progressStart(10);
            foreach (range(1, 10) as $index) {
                DB::beginTransaction();

                try {
                    OperationalArea::create([
                        'name' => $this->faker->company,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create operational hour
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create operational hour');
            $this->command->getOutput()->progressStart(10);
            foreach (range(1, 10) as $index) {
                DB::beginTransaction();

                try {
                    OperationalHour::create([
                        'operational_area_id' => OperationalArea::inRandomOrder()->first()->id,
                        'day' => $days[rand(0, count($days) - 1)],
                        'open_time' => date('h:i:s'),
                        'closed_time' => date('h:i:s'),
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create post category
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create post category');
            $this->command->getOutput()->progressStart(10);
            foreach (range(1, 10) as $index) {
                DB::beginTransaction();

                try {
                    PostCategory::create([
                        'name' => $this->faker->text,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create post
        if (App::environment(['local', 'testing'])) {
            $post_types = ['ARTICLE', 'NEWS', 'ADMISSION_INFORMATION'];
            $post_status = ['DRAFT', 'PUBLISHED'];
            $this->command->warn('Create post');
            $this->command->getOutput()->progressStart(200);
            foreach (range(1, 200) as $index) {
                $title = $this->faker->text;

                DB::beginTransaction();

                try {
                    Post::create([
                        'author_id' => User::inRandomOrder()->first()->id,
                        'category_id' => PostCategory::inRandomOrder()->first()->id,
                        'type' => Arr::random($post_types),
                        'title' => $title,
                        'slug' => Str::slug($title, '-'),
                        'content' => $this->faker->paragraph,
                        'published_at' => now(),
                        'status' => Arr::random($post_status),
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create achievement
        if (App::environment(['local', 'testing'])) {
            $achievement_category = ['STUDENT', 'TEACHER'];
            $achievement_status = ['DRAFT', 'PUBLISHED'];
            $this->command->warn('Create achievement');
            $this->command->getOutput()->progressStart(50);
            foreach (range(1, 50) as $index) {
                $title = $this->faker->text;

                DB::beginTransaction();

                try {
                    Achievement::create([
                        'title' => $title,
                        'slug' => Str::slug($title, '-'),
                        'description' => $this->faker->paragraph,
                        'category' => Arr::random($achievement_category),
                        'status' => Arr::random($achievement_status),
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create career
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create career');
            $this->command->getOutput()->progressStart(15);
            foreach (range(1, 15) as $index) {
                DB::beginTransaction();

                try {
                    Career::create([
                        'job_title' => $this->faker->jobTitle,
                        'job_description' => $this->faker->text,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create event
        if (App::environment(['local', 'testing'])) {
            $this->command->warn('Create event');
            $this->command->getOutput()->progressStart(100);
            foreach (range(1, 100) as $index) {
                $title = $this->faker->text;

                DB::beginTransaction();

                try {
                    Event::create([
                        'title' => $title,
                        'start_datetime' => now(),
                        'end_datetime' => now()->addHours(rand(1, 12)),
                        'location' => $this->faker->address,
                        'content' => $this->faker->paragraph,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create faq
        if (App::environment(['local', 'testing'])) {
            $faq_status = ['DRAFT', 'PUBLISHED'];
            $this->command->warn('Create faq');
            $this->command->getOutput()->progressStart(15);
            foreach (range(1, 15) as $index) {
                DB::beginTransaction();

                try {
                    Faq::create([
                        'question' => $this->faker->text,
                        'answer' => $this->faker->text,
                        'status' => Arr::random($faq_status),
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create gallery
        if (App::environment(['local', 'testing'])) {
            $gallery_status = ['DRAFT', 'PUBLISHED'];
            $this->command->warn('Create gallery');
            $this->command->getOutput()->progressStart(200);
            foreach (range(1, 200) as $index) {
                $title = $this->faker->text;

                DB::beginTransaction();

                try {
                    $gallery_created = Gallery::create([
                        'title' => $title,
                        'slug' => Str::slug($title, '-'),
                        'description' => $this->faker->text,
                        'status' => Arr::random($gallery_status),
                    ]);

                    foreach (range(1, rand(5, 15)) as $item_index) {
                        $gallery_created->items()->create([
                            'image' => '-',
                            'description' => $this->faker->text,
                        ]);
                    }

                    $gallery_created->items()->inRandomOrder()->first()->update([
                        'is_thumbnail' => true,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Create testimonial
        if (App::environment(['local', 'testing'])) {
            $testimonial_type = ['STUDENT', 'TEACHER', 'PARENT'];
            $this->command->warn('Create testimonial');
            $this->command->getOutput()->progressStart(150);
            foreach (range(1, 150) as $index) {
                $title = $this->faker->text;

                DB::beginTransaction();

                try {
                    Testimonial::create([
                        'type' => Arr::random($testimonial_type),
                        'name' => $this->faker->name,
                        'relation' => $this->faker->jobTitle,
                        'message' => $this->faker->text,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
    }
}
