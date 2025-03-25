<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Http\Resources\ProductResource;
use App\Models\Area;
use App\Models\Product;
use App\Models\School;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStudentPriceController extends Controller
{
    public function index()
    {
        $products = Product::where('code', 'ADMISSION_STUDENT_FORM');

        if (request()->has('search')) {
            $products->where('name', 'like', '%' . request('search') . '%');
        }

        $products = $products->with('area')
            ->latest()
            ->paginate(15);


        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'products' => ProductResource::collection($products),
        ];

        return Inertia::render('Office/ICC/Management/AdmissionStudentPrice/Index', $data);
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
            $area = Area::where('uuid', request('area_id'))->firstOrFail();

            $product_created = Product::create([
                'area_id' => $area->id,
                'name' => request('name'),
                'code' => "ADMISSION_STUDENT_FORM",
                'type' => "SYSTEM",
                'price' => request('price'),
                'is_active' => request('is_active'),
            ]);

            if ($product_created->is_active == true) {
                Product::whereNotIn('id', [$product_created->id])
                    ->where('area_id', $product_created->area_id)
                    ->where('code', 'ADMISSION_STUDENT_FORM')
                    ->update([
                        'is_active' => false,
                    ]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Harga Formulir berhasil ditambahkan.',
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
            $product = Product::where('uuid', request('product_id'))->firstOrFail();
            $area = Area::where('uuid', request('area_id'))->firstOrFail();

            $product->update([
                'area_id' => $area->id,
                'name' => request('name'),
                'price' => request('price'),
                'is_active' => request('is_active'),
            ]);

            if ($product->is_active == true) {
                Product::whereNotIn('id', [$product->id])
                    ->where('area_id', $product->area_id)
                    ->where('code', 'ADMISSION_STUDENT_FORM')
                    ->update([
                        'is_active' => false,
                    ]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Harga Formulir berhasil diperbarui.',
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
