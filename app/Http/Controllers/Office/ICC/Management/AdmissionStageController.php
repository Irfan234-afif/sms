<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolResource;
use App\Models\AdmissionStage;
use App\Models\School;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStageController extends Controller
{
    public function index()
    {
        $schools = School::query();

        if (request()->has('search')) {
            $schools->whereHas('area', function ($area) {
                $area->where('name', 'like', '%' . request('search') . '%');
            });
        }

        $schools = $schools->with('area')
            ->with('level')
            ->with('admission_stages.statuses')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'schools' => SchoolResource::collection($schools)
        ];

        return Inertia::render('Office/ICC/Management/AdmissionStage/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school = School::where('uuid', request('school'))->firstOrFail();
            // stages
            $existingStageIds = [];
            foreach (request('admission_stages') as $stage) {
                $admission_stage_created = $school->admission_stages()
                    ->updateOrCreate([
                        'uuid' => $stage['admission_stage_id'],
                    ], [
                        'type' => $stage['type'],
                        'title' => $stage['title'],
                        'sort_number' => $stage['sort_number'],
                    ]);
                // statuses
                $existingStageStatusIds = [];
                foreach ($stage['statuses'] as $status) {
                    $admission_stage_status_created = $admission_stage_created->statuses()
                        ->updateOrCreate([
                            'uuid' => $status['admission_stage_status_id'],
                        ], [
                            'title' => $status['title'],
                            'sort_number' => $status['sort_number'],
                            'is_finished' => $status['is_finished'],
                        ]);

                    array_push($existingStageStatusIds, $admission_stage_status_created->uuid);
                }

                $admission_stage_created->statuses()
                    ->whereNotIn('uuid', $existingStageStatusIds)
                    ->delete();


                array_push($existingStageIds, $admission_stage_created->uuid);
            }

            $school->admission_stages()
                ->whereNotIn('uuid', $existingStageIds)
                ->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Tahap pendaftaran berhasil diperbarui.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
}
