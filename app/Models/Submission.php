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
        'submitter_id',
        'area_id',
        'reference_number',
        'datetime',
        'status',
    ];

    public function group()
    {
        return $this->belongsTo(SubmissionGroup::class, 'submission_group_id');
    }

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }

    public function submitter()
    {
        return $this->belongsTo(Employee::class, 'submitter_id');
    }

    public function approvals()
    {
        return $this->hasMany(SubmissionApproval::class, 'submission_id');
    }

    public function chats()
    {
        return $this->morphMany(Chat::class, 'model');
    }

    public function install_repair()
    {
        return $this->hasOne(SubInstallRepair::class, 'submission_id', 'id');
    }

    public function design()
    {
        return $this->hasOne(SubDesign::class, 'submission_id', 'id');
    }

    public function documentation()
    {
        return $this->hasOne(SubDocumentation::class, 'submission_id', 'id');
    }

    public function broadcast()
    {
        return $this->hasOne(SubBroadcast::class, 'submission_id', 'id');
    }

    public function media_post()
    {
        return $this->hasOne(SubMediaPost::class, 'submission_id', 'id');
    }

    public function card()
    {
        return $this->hasOne(SubCard::class, 'submission_id', 'id');
    }

    public function vehicle()
    {
        return $this->hasOne(SubVehicle::class, 'submission_id', 'id');
    }

    public function material()
    {
        return $this->hasOne(SubMaterial::class, 'submission_id', 'id');
    }

    public function event()
    {
        return $this->hasOne(SubEvent::class, 'submission_id', 'id');
    }

    public function attendance()
    {
        return $this->hasOne(SubAttendance::class, 'submission_id', 'id');
    }

    public function equipment()
    {
        return $this->hasOne(SubEquipment::class, 'submission_id', 'id');
    }

    public function outstation()
    {
        return $this->hasOne(SubOutstation::class, 'submission_id', 'id');
    }

    public function leave()
    {
        return $this->hasOne(SubLeave::class, 'submission_id', 'id');
    }

    public function resignation()
    {
        return $this->hasOne(SubResignation::class, 'submission_id', 'id');
    }
}
