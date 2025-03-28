<?php

namespace App\Services;

use App\Models\Submission;
use Illuminate\Support\Str;

class SubmissionUpdateService
{
    protected $submission;

    public function __construct($submission_id)
    {
        $this->submission = Submission::where('uuid', $submission_id)->firstOrFail();
    }

    public function updateSubmission()
    {
        $this->submission->update([
            'status' => request('status'),
        ]);

        if ($this->submission->status == 'PENDING' && !$this->submission->approvals()->exists()) {
            $this->createSubmissionApproval($this->submission);
        }

        return $this->submission;
    }

    public function createSubmissionApproval($submission)
    {
        $submission_approvers = $submission->group->approvers()
            ->where('area_id', $submission->area_id)
            ->get();

        foreach ($submission_approvers as $submission_approver) {
            $submission->approvals()->updateOrCreate([
                'sort_number' => $submission_approver->sort_number,
            ], [
                'approver_id' => $submission_approver->approver_id,
                'status' => 'PENDING',
            ]);
        }
    }
}
