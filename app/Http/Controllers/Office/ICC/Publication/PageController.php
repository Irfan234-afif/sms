<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\PageResource;
use App\Models\Page;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class PageController extends Controller
{
    public function index()
    {
        $pages = Page::query();

        if (request()->has('search')) {
            $pages->where('title', 'like', '%' . request('search') . '%');
        }

        $pages = $pages->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'pages' => PageResource::collection($pages)
        ];

        return Inertia::render('Office/ICC/Publication/Page/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $page = Page::where('uuid', request('page_id'))->first();

            Page::updateOrCreate(
                [
                    'id' => $page ? $page->id : null,
                ],
                [
                    'type' => request('type'),
                    'title' => request('title'),
                    'content' => request('content'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Halaman berhasil disimpan.',
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
