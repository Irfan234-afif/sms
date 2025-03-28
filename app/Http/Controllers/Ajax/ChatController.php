<?php

namespace App\Http\Controllers\Ajax;

use App\Http\Controllers\Controller;
use App\Http\Resources\ChatResource;
use App\Models\Chat;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ChatController extends Controller
{
    public function getChats()
    {
        $chats = Chat::where('model_id', request('model_id'))
            ->where('model_type', request('model_type'))
            ->with('sender')
            ->with('reads.reader')
            ->get();

        return response()->json(ChatResource::collection($chats), 200);
    }

    public function sendChat()
    {
        DB::beginTransaction();

        try {
            Chat::create([
                'model_id' => request('model_id'),
                'model_type' => request('model_type'),
                'sender_id' => Auth::user()->id,
                'message' => request('message'),
                'sent_at' => request('sent_at'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pesan Berhasil dikirim.',
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
