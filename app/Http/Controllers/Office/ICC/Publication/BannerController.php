<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\BannerResource;
use App\Models\Banner;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class BannerController extends Controller
{
    public function index()
    {
        $banners = Banner::query();

        if (request()->has('search')) {
            $banners->where('title', 'like', '%' . request('search') . '%');
        }

        $banners = $banners->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'banners' => BannerResource::collection($banners)
        ];

        return Inertia::render('Office/ICC/Publication/Banner/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $banner = Banner::where('uuid', request('post_category_id'))->first();

            Banner::updateOrCreate(
                [
                    'id' => $banner ? $banner->id : null,
                ],
                [
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . Uuid::uuid1(), '-'),
                    'content' => request('content'),
                    'file_name' => request('file_name'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Spanduk berhasil disimpan.',
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
            $banner = Banner::where('uuid', request('banner_id'))->firstOrFail();

            $banner->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Spanduk berhasil dihapus.',
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
