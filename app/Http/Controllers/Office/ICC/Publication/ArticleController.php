<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostCategoryResource;
use App\Http\Resources\PostResource;
use App\Models\Post;
use App\Models\PostCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class ArticleController extends Controller
{
    public function index()
    {
        $posts = Post::query();

        if (request()->has('search')) {
            $posts->where('day', 'like', '%' . request('search') . '%');
        }

        $posts = $posts->with('group')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'posts' => PostResource::collection($posts)
        ];

        return Inertia::render('Office/ICC/Publication/Post/Index', $data);
    }

    public function optionPostCategory()
    {
        $post_categories = PostCategory::query();

        if (request()->has('search')) {
            $post_categories->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(PostCategoryResource::collection($post_categories->latest()->get()), 200);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $post = Post::where('uuid', request('post_id'))->first();
            $post_category = PostCategory::where('uuid', request('post_category_id'))->first();

            Post::updateOrCreate(
                [
                    'id' => $post ? $post->id : null,
                ],
                [
                    'post_category_id' => $post_category->id,
                    'type' => 'ARTICLE',
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . Uuid::uuid1(), '-'),
                    'content' => request('content'),
                    'thumbnail' => request('thumbnail'),
                    'published_at' => request('published_at'),
                    'status' => request('status'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Artikel berhasil disimpan.',
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
            $post = Post::where('uuid', request('post_id'))->firstOrFail();

            $post->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Artikel berhasil dihapus.',
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
