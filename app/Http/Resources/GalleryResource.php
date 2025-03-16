<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GalleryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $default_thumbnail = 'https://www.cvent-assets.com/brand-page-guestside-site/assets/images/venue-card-placeholder.png';

        $thumbnail_path = optional($this->items->where('is_thumbnail', true)->first())->image
            ? asset('storage/galleries/' . $this->items->where('is_thumbnail', true)->first()->image)
            : $default_thumbnail;

        return [
            'uuid' => $this->uuid,
            'title' => $this->title,
            'slug' => $this->slug,
            'description' => $this->description,
            'status' => $this->status,
            'thumbnail_path' => $thumbnail_path,
            'items' => $this->whenLoaded('items', fn() => GalleryItemResource::collection($this->items)),
        ];
    }
}
