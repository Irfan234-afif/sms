<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\Family;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class FamilyController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            Family::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'name' => request('name'),
                'national_id' => request('national_id'),
                'relation' => request('relation'),
                'birth_place' => request('birth_place'),
                'birth_date' => request('birth_date'),
                'education' => request('education'),
                'occupation' => request('occupation'),
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

            Family::findOrFail(request('id'))->delete();

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
