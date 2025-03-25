<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\OperationalAreaResource;
use App\Http\Resources\OperationalHourResource;
use App\Models\OperationalHour;
use App\Models\OperationalArea;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class OperationalHourController extends Controller
{
    public function index()
    {
        $operational_hours = OperationalHour::query();

        if (request()->has('search')) {
            $operational_hours->whereHas('area', function ($area) {
                $area->where('name', 'like', '%' . request('search') . '%');
            });
        }

        $operational_hours = $operational_hours->with('area')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'operational_hours' => OperationalHourResource::collection($operational_hours)
        ];

        return Inertia::render('Office/ICC/Publication/OperationalHour/Index', $data);
    }

    public function optionOperationalArea()
    {
        $operational_areas = OperationalArea::query();

        if (request()->has('search')) {
            $operational_areas->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(OperationalAreaResource::collection($operational_areas->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $operational_hour = OperationalHour::where('uuid', request('operational_hour_id'))->first();
            $operational_area = OperationalArea::where('uuid', request('operational_area_id'))->first();

            OperationalHour::updateOrCreate(
                [
                    'id' => $operational_hour ? $operational_hour->id : null,
                ],
                [
                    'operational_area_id' => $operational_area->id,
                    'day' => request('day'),
                    'open_time' => request('open_time'),
                    'closed_time' => request('closed_time'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Jam Operasional berhasil disimpan.',
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
            $operational_hour = OperationalHour::where('uuid', request('operational_hour_id'))->firstOrFail();

            $operational_hour->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Jam Operasional berhasil dihapus.',
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
