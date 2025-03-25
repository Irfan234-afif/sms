<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\CareerResource;
use App\Models\Career;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class CareerController extends Controller
{
    public function index()
    {
        $careers = Career::query();

        if (request()->has('search')) {
            $careers->where('job_title', 'like', '%' . request('search') . '%');
        }

        $careers = $careers->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'careers' => CareerResource::collection($careers)
        ];

        return Inertia::render('Office/ICC/Publication/Career/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $career = Career::where('uuid', request('career_id'))->first();

            Career::updateOrCreate(
                [
                    'id' => $career ? $career->id : null,
                ],
                [
                    'job_title' => request('job_title'),
                    'job_description' => request('job_description'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karir berhasil disimpan.',
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
            $career = Career::where('uuid', request('career_id'))->firstOrFail();

            $career->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karir berhasil dihapus.',
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
