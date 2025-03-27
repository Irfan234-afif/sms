<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\CommunityInvolvement;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class CommunityInvolvementController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            CommunityInvolvement::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'title' => request('title'),
                'location' => request('location'),
                'start_date' => request('start_date'),
                'end_date' => request('end_date'),
                'position' => request('position'),
                'responsibility' => request('responsibility'),
                'status' => request('status'),
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

            CommunityInvolvement::findOrFail(request('id'))->delete();

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
