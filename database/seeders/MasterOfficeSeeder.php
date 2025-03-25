<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\School;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class MasterOfficeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // data master
        $products = json_decode(file_get_contents('database/data/master/product.json'));
        $school_admission_stages = json_decode(file_get_contents('database/data/master/school_admission_stage.json'));

        if (App::environment(['local', 'testing', 'production'])) {
            // create product
            $this->command->warn('Create product');
            $this->command->getOutput()->progressStart(count($products));
            foreach ($products as $product) {
                DB::beginTransaction();

                try {
                    foreach (School::get() as $school) {
                        Product::firstOrCreate([
                            'area_id' => $school->area->id,
                            'name' => $product->name . ' ' . $school->area->name,
                            'code' => $product->code,
                        ], [
                            'type' => $product->type,
                            'price' => $product->price,
                            'is_active' => $product->is_active,
                        ]);
                    }

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
            // create admission stage
            $this->command->warn('Create admission stage');
            $this->command->getOutput()->progressStart(count($school_admission_stages));
            foreach ($school_admission_stages as $school_admission_stage) {
                DB::beginTransaction();

                try {
                    $school = School::whereHas('level', function ($level) use ($school_admission_stage) {
                        $level->where('code', $school_admission_stage->school_level);
                    })->firstOrFail();

                    foreach ($school_admission_stage->stages as $stage) {
                        $admission_stage_created = $school->admission_stages()->updateOrCreate([
                            "title" => $stage->title,
                            "type" => $stage->type,
                            "sort_number" => $stage->sort_number
                        ]);

                        foreach ($stage->statuses as $status) {
                            $admission_stage_created->statuses()->updateOrCreate([
                                "title" => $status->title,
                                "sort_number" => $status->sort_number
                            ], [
                                "color" => $status->color,
                                "is_finished" => $status->is_finished,
                            ]);
                        }
                    }

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
