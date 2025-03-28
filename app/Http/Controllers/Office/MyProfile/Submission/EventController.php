<?php

namespace App\Http\Controllers\Office\MyProfile\Submission;

use App\Http\Controllers\Controller;
use App\Http\Resources\SubmissionResource;
use App\Models\Employee;
use App\Models\SubEvent;
use App\Models\Submission;
use App\Services\SubmissionStoreService;
use App\Services\SubmissionUpdateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Inertia\Inertia;

class EventController extends Controller
{
    public function index()
    {
        $submissions = Submission::whereHas('submitter.profile.user', function ($user) {
            $user->where('id', Auth::user()->id);
        })->whereHas('group', function ($group) {
            $group->where('code', 'EVENT');
        });

        if (request()->has('search')) {
            $submissions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $submissions = $submissions->with('approvals.approver.profile')
            ->with('approvals.delegate.profile')
            ->with('event.items')
            ->with('event.objectives')
            ->with('event.transportations')
            ->with('event.participants')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'submissions' => SubmissionResource::collection($submissions),
        ];

        return Inertia::render('Office/MyProfile/Submission/Event/Index', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $submitter = Employee::where('profile_id', Auth::user()->profile_id)->firstOrFail();

            $submissionService = new SubmissionStoreService('EVENT', $submitter);

            if (!$submissionService->hasSubmitterAssignmentArea()) {
                throw new Exception('Anda belum ditempatkan di area manapun.', 400);
            }

            $submission_created = $submissionService->createSubmission();

            $sub_event_created = SubEvent::updateOrCreate([
                'submission_id' => $submission_created->id,
            ], [
                'title' => request('title'),
                'place' => request('place'),
                'start_datetime' => request('datetime_range')[0],
                'end_datetime' => request('datetime_range')[1],
                'description' => request('description'),
                'bill_amount' => request('bill_amount'),
            ]);

            foreach (request('items') as $item) {
                $sub_event_created->items()->create([
                    'name' => $item['name'],
                    'quantity' => $item['quantity'],
                    'unit' => $item['unit'],
                    'price' => $item['price'],
                    'bill_amount' => $item['bill_amount'],
                    'description' => $item['description'],
                ]);
            }

            foreach (request('objectives') as $objective) {
                $sub_event_created->objectives()->create([
                    'title' => $objective['title'],
                    'description' => $objective['description'],
                    'remark' => $objective['remark'],
                ]);
            }

            foreach (request('transportations') as $transportation) {
                $sub_event_created->transportations()->create([
                    'type' => $transportation['type'],
                    'quantity' => $transportation['quantity'],
                    'unit_cost' => $transportation['unit_cost'],
                ]);
            }

            foreach (request('participants') as $participant) {
                $sub_event_created->participants()->create([
                    'type' => $participant['type'],
                    'quantity' => $participant['quantity'],
                ]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Permintaan berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function update()
    {
        DB::beginTransaction();

        try {
            $submissionService = new SubmissionUpdateService(request('submission_id'));

            $submission = $submissionService->updateSubmission();

            $submission->event->update([
                'title' => request('title'),
                'place' => request('place'),
                'start_datetime' => request('datetime_range')[0],
                'end_datetime' => request('datetime_range')[1],
                'description' => request('description'),
                'bill_amount' => request('bill_amount'),
            ]);

            $item_ids = [];
            foreach (request('items') as $item) {
                $item_created = $submission->event->items()->updateOrCreate([
                    'uuid' => $item['sub_event_item_id']
                ], [
                    'name' => $item['name'],
                    'quantity' => $item['quantity'],
                    'unit' => $item['unit'],
                    'price' => $item['price'],
                    'bill_amount' => $item['bill_amount'],
                    'description' => $item['description'],
                ]);

                array_push($item_ids, $item_created->id);
            }
            $submission->event->items()
                ->whereNotIn('id', $item_ids)
                ->delete();

            $objective_ids = [];
            foreach (request('objectives') as $objective) {
                $objective_created = $submission->event->objectives()->updateOrCreate([
                    'uuid' => $objective['sub_event_objective_id']
                ], [
                    'title' => $objective['title'],
                    'description' => $objective['description'],
                    'remark' => $objective['remark'],
                ]);

                array_push($objective_ids, $objective_created->id);
            }
            $submission->event->objectives()
                ->whereNotIn('id', $objective_ids)
                ->delete();

            $transportation_ids = [];
            foreach (request('transportations') as $transportation) {
                $transportation_created = $submission->event->transportations()->updateOrCreate([
                    'uuid' => $transportation['sub_event_transportation_id']
                ], [
                    'type' => $transportation['type'],
                    'quantity' => $transportation['quantity'],
                    'unit_cost' => $transportation['unit_cost'],
                ]);

                array_push($transportation_ids, $transportation_created->id);
            }
            $submission->event->transportations()
                ->whereNotIn('id', $transportation_ids)
                ->delete();

            $participant_ids = [];
            foreach (request('participants') as $participant) {
                $participant_created = $submission->event->participants()->updateOrCreate([
                    'uuid' => $participant['sub_event_participant_id']
                ], [
                    'type' => $participant['type'],
                    'quantity' => $participant['quantity'],
                ]);

                array_push($participant_ids, $participant_created->id);
            }
            $submission->event->participants()
                ->whereNotIn('id', $participant_ids)
                ->delete();


            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Permintaan berhasil disimpan.',
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
            $submission = Submission::where('uuid', request('submission_id'))->firstOrFail();

            $submission->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Permintaan berhasil dihapus.',
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
