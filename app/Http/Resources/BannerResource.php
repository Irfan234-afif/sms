<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BannerResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'uuid' => $this->uuid,
            'title' => $this->title,
            'slug' => $this->slug,
            'image' => $this->image,
            'image_path' => $this->image ? '/storage/banners/' . $this->image : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
            'content' => $this->content,
        ];
    }
}
