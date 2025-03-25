<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostCategoryResource;
use App\Models\PostCategory;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class PostCategoryController extends Controller
{
    public function index()
    {
        $post_categories = PostCategory::query();

        if (request()->has('search')) {
            $post_categories->where('name', 'like', '%' . request('search') . '%');
        }

        $post_categories = $post_categories->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'post_categories' => PostCategoryResource::collection($post_categories)
        ];

        return Inertia::render('Office/ICC/Publication/PostCategory/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $post_category = PostCategory::where('uuid', request('post_category_id'))->first();

            PostCategory::updateOrCreate(
                [
                    'id' => $post_category ? $post_category->id : null,
                ],
                [
                    'name' => request('name'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kategori Posting berhasil disimpan.',
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
            $post_category = PostCategory::where('uuid', request('post_category_id'))->firstOrFail();

            $post_category->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kategori Posting berhasil dihapus.',
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
