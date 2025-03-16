<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EventResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'title' => $this->title,
            'thumbnail' => $this->thumbnail,
            'thumbnail_path' => $this->thumbnail ? '/storage/thumbnails/' . $this->thumbnail : 'https://www.cvent-assets.com/brand-page-guestside-site/assets/images/venue-card-placeholder.png',
            'start_datetime' => $this->start_datetime,
            'end_datetime' => $this->end_datetime,
            'location' => $this->location,
            'content' => $this->content,
        ];
    }
}
