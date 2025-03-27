<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\Experience;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class ExperienceController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            Experience::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'position' => request('position'),
                'reason_out' => request('reason_out'),
                'institution' => request('institution'),
                'start_date' => request('start_date'),
                'end_date' => request('end_date'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Data Berhasil disimpan'
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

            Experience::findOrFail(request('id'))->delete();

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
