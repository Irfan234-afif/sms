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
            'uuid' => $this->uuid,
            'title' => $this->title,
            'thumbnail' => $this->thumbnail,
            'thumbnail_path' => $this->thumbnail ? '/storage/thumbnails/' . $this->thumbnail : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
            'start_datetime' => $this->start_datetime,
            'end_datetime' => $this->end_datetime,
            'location' => $this->location,
            'content' => $this->content,
        ];
    }
}
