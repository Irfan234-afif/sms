<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\FaqResource;
use App\Models\Faq;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class FaqController extends Controller
{
    public function index()
    {
        $faqs = Faq::query();

        if (request()->has('search')) {
            $faqs->where('question', 'like', '%' . request('search') . '%');
        }

        $faqs = $faqs->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'faqs' => FaqResource::collection($faqs)
        ];

        return Inertia::render('Office/ICC/Publication/Faq/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $faq = Faq::where('uuid', request('faq_id'))->first();

            Faq::updateOrCreate(
                [
                    'id' => $faq ? $faq->id : null,
                ],
                [
                    'question' => request('question'),
                    'answer' => request('answer'),
                    'status' => request('status'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'FAQ berhasil disimpan.',
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
            $faq = Faq::where('uuid', request('faq_id'))->firstOrFail();

            $faq->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'FAQ berhasil dihapus.',
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
