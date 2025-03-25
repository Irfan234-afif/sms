<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\PostCategoryResource;
use App\Http\Resources\PostResource;
use App\Models\Post;
use App\Models\PostCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class ArticleController extends Controller
{
    public function index()
    {
        $posts = Post::where('type', 'ARTICLE');

        if (request()->has('search')) {
            $posts->where('title', 'like', '%' . request('search') . '%');
        }

        $posts = $posts->with('author')
            ->with('category')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'posts' => PostResource::collection($posts)
        ];

        return Inertia::render('Office/ICC/Publication/Article/Index', $data);
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

            $post_created = Post::updateOrCreate(
                [
                    'id' => $post ? $post->id : null,
                ],
                [
                    'author_id' => $post ? $post->author_id : Auth::user()->id,
                    'category_id' => $post_category ? $post_category->id : null,
                    'type' => 'ARTICLE',
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . Uuid::uuid1(), '-'),
                    'content' => request('content'),
                    'published_at' => now(),
                    'status' => request('status'),
                ]
            );

            if (request()->hasFile('thumbnail_file')) {
                $file = request()->file('thumbnail_file');

                $filename = 'article-thumbnail' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('thumbnails', $filename, 'public');

                if ($post_created->thumbnail) {
                    Storage::disk('public')->delete('thumbnails/' . $post_created->thumbnail);
                }

                $post_created->thumbnail = $filename;

                $post_created->save();
            }

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
