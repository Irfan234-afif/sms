<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
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
            'author' => $this->whenLoaded('author', fn() => UserResource::make($this->author)),
            'category' => $this->whenLoaded('category', fn() => PostCategoryResource::make($this->category)),
            'title' => $this->title,
            'slug' => $this->slug,
            'thumbnail' => $this->thumbnail,
            'thumbnail_path' => $this->thumbnail ? '/storage/thumbnails/' . $this->thumbnail : 'https://www.cvent-assets.com/brand-page-guestside-site/assets/images/venue-card-placeholder.png',
            'content' => $this->content,
            'published_at' => $this->published_at,
            'status' => $this->status,
        ];
    }
}
