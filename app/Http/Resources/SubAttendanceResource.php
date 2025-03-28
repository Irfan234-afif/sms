<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubAttendanceResource extends JsonResource
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
            'type' => $this->type,
            'date' => $this->date,
            'description' => $this->description,
            'attachment' => $this->attachment,
            'attachment_path' => $this->attachment ? '/storage/attachments/' . $this->attachment : 'https://salonlfc.com/wp-content/uploads/2018/01/attachment-not-found-scaled.png',
        ];
    }
}
