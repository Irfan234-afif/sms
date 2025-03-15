<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GalleryItemResource extends JsonResource
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
            'image' => $this->image,
            'image_path' => $this->image ? '/storage/galleries/' . $this->image : null,
            'description' => $this->description,
            'is_thumbnail' => (bool) $this->is_thumbnail,
        ];
    }
}
