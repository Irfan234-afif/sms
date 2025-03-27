<?php

namespace App\Services;

use App\Models\Submission;
use App\Models\SubmissionGroup;
use Illuminate\Support\Str;

class SubmissionStoreService
{
    protected $group, $submitter;

    public function __construct($group, $submitter)
    {
        $this->group = SubmissionGroup::where('code', $group)->firstOrFail();
        $this->submitter = $submitter;
    }


    public function hasSubmitterAssignmentArea()
    {
        return (bool) $this->submitter->assignments()->exists();
    }

    public function generateReferenceNumber()
    {
        $reference_number = sprintf("SUB/%s/%011d", $this->group->reference_code, $this->group->reference_number);

        $this->group->increment('reference_number', 1);

        return $reference_number;
    }

    public function createSubmission()
    {
        $submission_created = Submission::create([
            'submission_group_id' => $this->group->id,
            'submitter_id' => $this->submitter->id,
            'area_id' => $this->submitter->assignments()->first()->area_id,
            'reference_number' => $this->generateReferenceNumber(),
            'datetime' => request('datetime'),
            'status' => request('status'),
        ]);

        if ($submission_created->status == 'PENDING') {
            $this->createSubmissionApproval($submission_created);
        }

        return $submission_created;
    }

    public function createSubmissionApproval($submission_created)
    {
        $submission_approvers = $this->group->approvers()
            ->where('area_id', $submission_created->area_id)
            ->get();

        foreach ($submission_approvers as $submission_approver) {
            $submission_created->approvals()->updateOrCreate([
                'sort_number' => $submission_approver->sort_number,
            ], [
                'approver_id' => $submission_approver->approver_id,
                'status' => 'PENDING',
            ]);
        }
    }
}
