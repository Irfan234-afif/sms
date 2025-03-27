<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\Certification;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class CertificationController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            $certification_created = Certification::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'type' => request('type'),
                'subject' => request('subject'),
                'institution' => request('institution'),
                'certification_date' => request('certification_date'),
            ]);

            // remove file
            if (null == request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $certification_created->attachment);

                $certification_created->attachment = null;
                $certification_created->save();
            }
            // replace file
            if (null != request()->file('attachment')) {
                Storage::disk('public')->delete('attachment/' . $certification_created->attachment);

                $filename = 'academic-record-' . Uuid::uuid1();
                $extension = request()->attachment->extension();
                $attachment = $filename . '.' . $extension;
                request()->attachment->storeAs('attachment', $attachment, 'public');

                $certification_created->attachment = $attachment;
                $certification_created->save();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Sertifikat Berhasil disimpan'
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

            Certification::findOrFail(request('id'))->delete();

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
