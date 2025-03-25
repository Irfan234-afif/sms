<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TestimonialResource extends JsonResource
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
            'type_label' => GetLabel::testimonialType($this->type),
            'name' => $this->name,
            'relation' => $this->relation,
            'message' => $this->message,
            'avatar' => $this->avatar,
            'avatar_path' => $this->avatar ? '/storage/avatars/' . $this->avatar : 'https://i0.wp.com/passivesills.com/wp-content/uploads/2020/06/User-Icon-Grey.png?fit=400%2C400&ssl=1&w=640',
        ];
    }
}
