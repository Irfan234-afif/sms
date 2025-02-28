<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Submission extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_group_id',
        'area_id',
        'submitter_id',
        'reference_number',
        'datetime',
        'status',
    ];

    public function group()
    {
        return $this->belongsTo(SubmissionGroup::class, 'submission_group_id');
    }

    public function submitter()
    {
        return $this->belongsTo(Employee::class, 'submitter_id');
    }

    public function material()
    {
        return $this->hasOne(SubMaterial::class, 'submission_id', 'id');
    }

    public function approvals()
    {
        return $this->hasMany(SubmissionApproval::class, 'submission_id');
    }
}
