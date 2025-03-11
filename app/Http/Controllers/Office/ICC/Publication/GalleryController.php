<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\FaqResource;
use App\Models\Gallery;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class GalleryController extends Controller
{
    public function index()
    {
        $galleries = Gallery::query();

        if (request()->has('search')) {
            $galleries->where('title', 'like', '%' . request('search') . '%');
        }

        $galleries = $galleries->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'galleries' => FaqResource::collection($galleries)
        ];

        return Inertia::render('Office/ICC/Publication/Gallery/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $gallery = Gallery::where('uuid', request('gallery_id'))->first();

            Gallery::updateOrCreate(
                [
                    'id' => $gallery ? $gallery->id : null,
                ],
                [
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . Uuid::uuid1(), '-'),
                    'description' => request('description'),
                    'status' => request('status'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Galeri berhasil disimpan.',
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
            $gallery = Gallery::where('uuid', request('gallery_id'))->firstOrFail();

            $gallery->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Galeri berhasil dihapus.',
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
