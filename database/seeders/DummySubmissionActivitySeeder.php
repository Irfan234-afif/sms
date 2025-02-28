<?php

namespace Database\Seeders;

use App\Models\Area;
use App\Models\Employee;
use App\Models\SubMaterial;
use App\Models\Submission;
use App\Models\SubmissionGroup;
use Carbon\Carbon;
use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DummySubmissionActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public $faker;

    public function run(): void
    {
        $areas = Area::get();
        $submission_groups = SubmissionGroup::get();
        $this->faker = Factory::create();

        if (App::environment(['local', 'testing', 'production'])) {
            // assign approvers
            $this->command->warn('Assign approvers');
            $this->command->getOutput()->progressStart(count($areas));
            foreach ($areas as $area) {
                DB::beginTransaction();

                try {
                    foreach ($submission_groups as $submission_group) {
                        foreach (range(1, rand(3, 6)) as $approver_index) {
                            $approver = Employee::whereHas('profile.user')->inRandomOrder()->first();
                            $submission_approver_created = $submission_group->approvers()->updateOrCreate([
                                'sort_number' => $approver_index,
                            ], [
                                'area_id' => $area->id,
                                'approver_id' => $approver->id,
                            ]);

                            foreach (range(1, rand(1, 3)) as $delegate_index) {
                                $delegate = Employee::whereHas('profile.user')->inRandomOrder()->first();
                                $submission_approver_created->delegates()->updateOrCreate([
                                    'delegate_id' => $delegate->id,
                                ]);
                            }
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
            // create submission
            $this->command->warn('Create submission');
            $this->command->getOutput()->progressStart(count($submission_groups));
            foreach ($submission_groups as $submission_group) {
                DB::beginTransaction();

                try {
                    if ($submission_group->code == 'MATERIAL') {
                        foreach (range(1, 1000) as $index) {
                            $submitter = Employee::whereHas('profile.user')->inRandomOrder()->first();
                            $area = $submitter->assignments()->inRandomOrder()->first()?->area;
                            $reference_number = sprintf("SUB/%s/%011d", $submission_group->reference_code, $submission_group->reference_number);
                            if ($area) {
                                $submission_approvers = $submission_group->approvers()->where('area_id', $area->id);

                                $submission_created = Submission::create([
                                    'submission_group_id' => $submission_group->id,
                                    'submitter_id' => $submitter->id,
                                    'area_id' => $area->id,
                                    'reference_number' => $reference_number,
                                    'datetime' => now(),
                                    'status' => Arr::random(['APPROVED', 'REJECTED', 'PENDING', 'DRAFT']),
                                ]);

                                $sub_material_created = SubMaterial::updateOrCreate([
                                    'submission_id' => $submission_created->id,
                                ], [
                                    'bill_amount' => rand(100000, 250000),
                                ]);

                                $sub_material_item_created = $sub_material_created->items()->create([
                                    'reference_number' =>  'ITEM-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                                    'name' => $this->faker->word,
                                    'quantity' => rand(1, 10),
                                    'unit' => 'PIECE',
                                    'price' => rand(500, 2000) / 100,
                                    'bill_amount' => rand(1000, 5000) / 100,
                                    'due_date' => Carbon::now()->addDays(rand(1, 30)),
                                    'description' => $this->faker->word,
                                    'status' => Arr::random(['REJECTED', 'ORDERED', 'DELIVERED', 'RECEIVED', 'CANCELED', 'PENDING', 'DRAFT']),
                                ]);

                                // chat logs
                                foreach (range(1, rand(3, 5)) as $index) {
                                    $sub_material_item_created->chats()->create([
                                        'sender_id' => Arr::random([
                                            $submitter->profile->user->id,
                                            $submission_approvers->inRandomOrder()->first()?->approver?->profile?->user?->id
                                                ?? $submitter->profile->user->id
                                        ]),
                                        'message' => $this->faker->paragraph,
                                        'is_read' => rand(0, 1),
                                    ]);
                                }
                                // approvers
                                foreach ($submission_approvers->get() as $submission_approver) {
                                    $submission_created->approvals()->updateOrCreate([
                                        'sort_number' => $submission_approver->sort_number,
                                    ], [
                                        'approver_id' => $submission_approver->approver_id,
                                        'datetime' => now(),
                                        'status' => Arr::random(['APPROVED', 'REJECTED', 'PENDING']),
                                    ]);
                                }

                                $submission_group->increment('reference_number', 1);
                            }
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
