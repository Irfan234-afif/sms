<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Gallery extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'title',
        'slug',
        'description',
        'status',
    ];

    public function items()
    {
        return $this->hasMany(GalleryItem::class, 'gallery_id');
    }
}
