<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SubmissionApprovalDelegate extends Model
{
    use GenerateUuid, SoftDeletes;
}
