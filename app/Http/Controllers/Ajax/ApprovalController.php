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

            $submission = $submission_approval->submission;

            $approvals = $submission->approvals;

            $total = $approvals->count();
            $approved_count = $approvals->where('status', 'APPROVED')->count();
            $rejected_count = $approvals->where('status', 'REJECTED')->count();

            if ($rejected_count > 0) {
                $submission->update([
                    'status' => 'REJECTED',
                ]);
            } elseif ($approved_count === $total) {
                $submission->update([
                    'status' => 'APPROVED',
                ]);
            } else {
                $submission->update([
                    'status' => 'PENDING',
                ]);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Persetujuan berhasil diperbarui.',
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
