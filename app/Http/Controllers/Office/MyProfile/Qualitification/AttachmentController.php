<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\Attachment;
use App\Models\Profile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class AttachmentController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            $attachment_created = Attachment::updateOrCreate([
                'id' => request('id'),
            ], [
                'model_id' => request('model_id'),
                'model_type' => Profile::class,
                'title' => request('title'),
            ]);

            // remove file
            if (null == request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $attachment_created->attachment);

                $attachment_created->file_name = null;
                $attachment_created->save();
            }
            // replace file
            if (null != request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $attachment_created->attachment);

                $filename = 'attachment-' . Uuid::uuid1();
                $extension = request()->attachment->extension();
                $attachment = $filename . '.' . $extension;
                request()->attachment->storeAs('attachment', $attachment, 'public');

                $attachment_created->file_name = $attachment;
                $attachment_created->save();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Lampiran Berhasil disimpan'
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

            Attachment::findOrFail(request('id'))->delete();

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
