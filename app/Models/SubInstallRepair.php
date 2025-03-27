<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubInstallRepair extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'assigned_id',
        'description',
    ];

    public function submission()
    {
        return $this->belongsTo(Submission::class, 'submission_id');
    }

    public function assigned()
    {
        return $this->belongsTo(Employee::class, 'assigned_id');
    }

    public function items()
    {
        return $this->hasMany(SubInstallRepairItem::class, 'sub_install_repair_id');
    }
}
