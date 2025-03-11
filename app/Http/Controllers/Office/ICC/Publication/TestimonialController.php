<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\TestimonialResource;
use App\Models\Testimonial;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class TestimonialController extends Controller
{
    public function index()
    {
        $testimonials = Testimonial::query();

        if (request()->has('search')) {
            $testimonials->where('name', 'like', '%' . request('search') . '%');
        }

        $testimonials = $testimonials->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'testimonials' => TestimonialResource::collection($testimonials)
        ];

        return Inertia::render('Office/ICC/Publication/Testimonial/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $testimonial = Testimonial::where('uuid', request('testimonial_id'))->first();

            Testimonial::updateOrCreate(
                [
                    'id' => $testimonial ? $testimonial->id : null,
                ],
                [
                    'name' => request('name'),
                    'type' => request('type'),
                    'relation' => request('relation'),
                    'message' => request('message'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Testimoni berhasil disimpan.',
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
            $testimonial = Testimonial::where('uuid', request('testimonial_id'))->firstOrFail();

            $testimonial->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Testimoni berhasil dihapus.',
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
