<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubmissionGroup extends Model
{
    use SoftDeletes, GenerateUuid;

    protected $fillable = [
        'name',
        'code',
        'reference_code',
        'reference_number',
    ];

    public function approvers()
    {
        return $this->hasMany(SubmissionApprover::class, 'submission_group_id');
    }
}
