<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class GalleryItem extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'gallery_id',
        'image',
        'description',
        'is_thumbnail',
    ];
}
