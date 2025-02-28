<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AdmissionStudentPriceController extends Controller
{
    public function index()
    {
        $products = Product::where('code', 'ADMISSION_STUDENT_FORM');

        $products = $products->latest()
            ->paginate(15);


        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'products' => ProductResource::collection($products),
        ];

        return Inertia::render('Office/ICC/Management/AdmissionStudentPrice/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $product = Product::where('uuid', request('product_id'))->firstOrFail();

            $product->update([
                'price' => request('price'),
            ]);

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
