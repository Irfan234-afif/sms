<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PublicFeedback extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $table = 'public_feedbacks';

    protected $fillable = [
        'name',
        'email',
        'phone',
        'subject',
        'message',
        'readed_at',
    ];
}
