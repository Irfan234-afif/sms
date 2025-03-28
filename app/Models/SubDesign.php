<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubDesign extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
    ];

    public function submission()
    {
        return $this->belongsTo(Submission::class, 'submission_id');
    }

    public function items()
    {
        return $this->hasMany(SubDesignItem::class, 'sub_design_id');
    }
}
