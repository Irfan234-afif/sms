<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\TrainingRecord;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class TrainingController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            $academic_created = TrainingRecord::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'title' => request('title'),
                'institution' => request('institution'),
                'completion_date' => request('completion_date'),
            ]);

            // remove file
            if (null == request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $academic_created->attachment);

                $academic_created->attachment = null;
                $academic_created->save();
            }
            // replace file
            if (null != request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $academic_created->attachment);

                $filename = 'academic-record-' . Uuid::uuid1();
                $extension = request()->attachment->extension();
                $attachment = $filename . '.' . $extension;
                request()->attachment->storeAs('attachment', $attachment, 'public');

                $academic_created->attachment = $attachment;
                $academic_created->save();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Pelatihan Berhasil disimpan'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'failed',
                'message' => $th->getMessage(),
            ]);
        }
    }

    public function delete()
    {
        DB::beginTransaction();

        try {

            TrainingRecord::findOrFail(request('id'))->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'failed',
                'message' => $th->getMessage(),
            ]);
        }
    }
}
