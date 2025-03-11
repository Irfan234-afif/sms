<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\PublicFeedbackResource;
use App\Models\PublicFeedback;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class PublicFeedbackController extends Controller
{
    public function index()
    {
        $public_feedbacks = PublicFeedback::query();

        if (request()->has('search')) {
            $public_feedbacks->where('name', 'like', '%' . request('search') . '%');
        }

        $public_feedbacks = $public_feedbacks->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'public_feedbacks' => PublicFeedbackResource::collection($public_feedbacks)
        ];

        return Inertia::render('Office/ICC/Publication/PublicFeedback/Index', $data);
    }

    public function delete()
    {
        DB::beginTransaction();

        try {
            $public_feedback = PublicFeedback::where('uuid', request('public_feedback_id'))->firstOrFail();

            $public_feedback->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Masukan & Saran berhasil dihapus.',
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
