<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Faq extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'question',
        'answer',
        'status',
        'transaction_number',
    ];
}
