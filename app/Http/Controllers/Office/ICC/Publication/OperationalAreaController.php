<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\OperationalAreaResource;
use App\Models\OperationalArea;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class OperationalAreaController extends Controller
{
    public function index()
    {
        $operational_areas = OperationalArea::query();

        if (request()->has('search')) {
            $operational_areas->where('name', 'like', '%' . request('search') . '%');
        }

        $operational_areas = $operational_areas->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'operational_areas' => OperationalAreaResource::collection($operational_areas)
        ];

        return Inertia::render('Office/ICC/Publication/OperationalArea/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $operational_area = OperationalArea::where('uuid', request('operational_area_id'))->first();

            OperationalArea::updateOrCreate(
                [
                    'id' => $operational_area ? $operational_area->id : null,
                ],
                [
                    'name' => request('name'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Area Operasional berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function delete()
    {
        DB::beginTransaction();

        try {
            $operational_area = OperationalArea::where('uuid', request('operational_area_id'))->firstOrFail();

            $operational_area->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Area Operasional berhasil dihapus.',
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
