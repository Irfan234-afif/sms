<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubDesignItemResource extends JsonResource
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
            'due_date' => $this->due_date,
            'description' => $this->description,
            'attachment' => $this->attachment,
            'attachment_path' => $this->attachment ? '/storage/attachments/' . $this->attachment : 'https://salonlfc.com/wp-content/uploads/2018/01/attachment-not-found-scaled.png',
        ];
    }
}
