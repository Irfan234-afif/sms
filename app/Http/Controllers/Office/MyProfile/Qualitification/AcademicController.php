<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\AcademicRecord;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class AcademicController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            $academic_created = AcademicRecord::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'title' => request('title'),
                'institution' => request('institution'),
                'graduation_date' => request('graduation_date'),
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
                'message' => 'Akademik Berhasil disimpan'
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

            AcademicRecord::findOrFail(request('id'))->delete();

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
