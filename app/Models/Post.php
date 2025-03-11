<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'author_id',
        'category_id',
        'type',
        'title',
        'slug',
        'content',
        'thumbnail',
        'published_at',
        'status',
    ];

    public function author()
    {
        return $this->belongsTo(User::class, 'author_id')->withTrashed();
    }

    public function category()
    {
        return $this->belongsTo(PostCategory::class, 'category_id')->withTrashed();
    }
}
