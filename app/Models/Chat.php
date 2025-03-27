<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;

class Chat extends Model
{
    use GenerateUuid;

    protected $fillable = [
        'model_id',
        'model_type',
        'sender_id',
        'message',
        'sent_at',
    ];

    public function model()
    {
        return $this->morphTo();
    }

    public function sender()
    {
        return $this->belongsTo(User::class, 'sender_id');
    }

    public function reads()
    {
        return $this->belongsTo(ChatRead::class, 'chat_id');
    }
}
