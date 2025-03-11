<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\AchievementResource;
use App\Models\Achievement;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class AchievementController extends Controller
{
    public function index()
    {
        $achievements = Achievement::query();

        if (request()->has('search')) {
            $achievements->where('title', 'like', '%' . request('search') . '%');
        }

        $achievements = $achievements->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'achievements' => AchievementResource::collection($achievements)
        ];

        return Inertia::render('Office/ICC/Publication/Achievement/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $achievement = Achievement::where('uuid', request('achievement_id'))->first();

            Achievement::updateOrCreate(
                [
                    'id' => $achievement ? $achievement->id : null,
                ],
                [
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . Uuid::uuid1(), '-'),
                    'description' => request('description'),
                    'category' => request('category'),
                    'status' => request('status'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pencapaian berhasil disimpan.',
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
            $achievement = Achievement::where('uuid', request('achievement_id'))->firstOrFail();

            $achievement->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pencapaian berhasil dihapus.',
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
