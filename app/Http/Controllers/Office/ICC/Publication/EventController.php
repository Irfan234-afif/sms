<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\EventResource;
use App\Models\Event;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class EventController extends Controller
{
    public function index()
    {
        $events = Event::query();

        if (request()->has('search')) {
            $events->where('title', 'like', '%' . request('search') . '%');
        }

        $events = $events->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'events' => EventResource::collection($events)
        ];

        return Inertia::render('Office/ICC/Publication/Event/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $event = Event::where('uuid', request('event_id'))->first();

            $event_created = Event::updateOrCreate(
                [
                    'id' => $event ? $event->id : null,
                ],
                [
                    'title' => request('title'),
                    'start_datetime' => request('start_datetime'),
                    'end_datetime' => request('end_datetime'),
                    'location' => request('location'),
                    'content' => request('content'),
                ]
            );


            if (request()->hasFile('thumbnail_file')) {
                $file = request()->file('thumbnail_file');

                $filename = 'news-thumbnail' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('thumbnails', $filename, 'public');

                if ($event_created->thumbnail) {
                    Storage::disk('public')->delete('thumbnails/' . $event_created->thumbnail);
                }

                $event_created->thumbnail = $filename;

                $event_created->save();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Acara berhasil disimpan.',
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
            $event = Event::where('uuid', request('event_id'))->firstOrFail();

            $event->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Acara berhasil dihapus.',
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
