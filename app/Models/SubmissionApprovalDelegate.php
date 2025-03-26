<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubmissionApprovalDelegate extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_approver_id',
        'delegate_id',
    ];

    public function delegate()
    {
        return $this->belongsTo(Employee::class, 'delegate_id');
    }
}
