<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Http\Resources\DiscountResource;
use App\Models\Area;
use App\Models\Discount;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStudentDiscountController extends Controller
{
    public function index()
    {
        $discounts = Discount::query();

        if (request()->has('search')) {
            $discounts->where('name', 'like', '%' . request('search') . '%');
        }

        $discounts = $discounts->with('usages')
            ->latest()
            ->paginate(15);


        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'discounts' => DiscountResource::collection($discounts),
        ];

        return Inertia::render('Office/ICC/Management/AdmissionStudentDiscount/Index', $data);
    }


    public function optionArea()
    {
        $areas = Area::whereHasMorph('model', School::class);

        if (request()->has('search')) {
            $areas->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(AreaResource::collection($areas->latest()->get()), 200);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $area_ids = Area::whereIn('uuid', request('area_ids'))->pluck('id')->toArray();

            $discount_created = Discount::create([
                'name' => request('name'),
                'code' => request('code'),
                'description' => request('description'),
                'type' => request('type'),
                'value' => request('value'),
                'starts_at' => request('starts_at'),
                'ends_at' => request('ends_at'),
                'quota' => request('quota'),
                'is_active' => request('is_active'),
            ]);

            $discount_created->syncWithUuid('usages', $area_ids);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Diskon berhasil ditambahkan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function update()
    {
        DB::beginTransaction();

        try {
            $discount = Discount::where('uuid', request('discount_id'))->firstOrFail();
            $area_ids = Area::whereIn('uuid', request('area_ids'))->pluck('id')->toArray();

            $discount->update([
                'name' => request('name'),
                'code' => request('code'),
                'description' => request('description'),
                'type' => request('type'),
                'value' => request('value'),
                'starts_at' => request('starts_at'),
                'ends_at' => request('ends_at'),
                'quota' => request('quota'),
                'is_active' => request('is_active'),
            ]);

            $discount->syncWithUuid('usages', $area_ids);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Diskon berhasil diperbarui.',
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
            $discount = Discount::where('uuid', request('discount_id'))->firstOrFail();

            $discount->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Tahun ajaran berhasil dihapus.',
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
