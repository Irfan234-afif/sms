<?php

namespace App\Http\Controllers\Ajax;

use App\Http\Controllers\Controller;
use App\Models\SubmissionApproval;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ApprovalController extends Controller
{
    public function updateStatus()
    {
        DB::beginTransaction();

        try {
            $submission_approval = SubmissionApproval::where('uuid', request('submission_approval_id'))->firstOrFail();

            $submission_approval->update([
                'status' => request('status'),
            ]);

            $submission_approval->submission->update([
                'status' => request('status'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Persetujuan Berhasil diperbarui.',
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
