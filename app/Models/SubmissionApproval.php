<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubmissionApproval extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'approver_id',
        'delegate_id',
        'is_delegated',
        'sort_number',
        'datetime',
        'status',
    ];

    public function submission()
    {
        return $this->belongsTo(Submission::class, 'submission_id');
    }

    public function approver()
    {
        return $this->belongsTo(Employee::class, 'approver_id');
    }

    public function delegate()
    {
        return $this->belongsTo(Employee::class, 'delegate_id');
    }
}
