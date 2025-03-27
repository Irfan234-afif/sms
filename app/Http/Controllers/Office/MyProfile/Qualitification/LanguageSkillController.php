<?php

namespace App\Http\Controllers\Office\MyProfile\Qualitification;


use App\Http\Controllers\Controller;
use App\Models\LanguageSkill;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;
use Storage;

class LanguageSkillController extends Controller
{
    public function save()
    {
        DB::beginTransaction();

        try {

            LanguageSkill::updateOrCreate([
                'id' => request('id'),
            ], [
                'profile_id' => request('profile_id'),
                'title' => request('title'),
                'reading' => request('reading'),
                'writing' => request('writing'),
                'speaking' => request('speaking'),
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

            LanguageSkill::findOrFail(request('id'))->delete();

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
