<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubmissionApprover extends Model
{
    use GenerateUuid, SoftDeletes;

    public function approver()
    {
        return $this->belongsTo(Employee::class, 'approver_id');
    }

    public function delegates()
    {
        return $this->hasMany(SubmissionApprovalDelegate::class, 'submission_approver_id');
    }
}
