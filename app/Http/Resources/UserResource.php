<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $default_avatar = '/assets/icons/user-circle.png';

        $avatar_path = $this->profile->avatar ? asset('storage/avatars/' . $this->profile->avatar)
            : $default_avatar;

        return [
            'uuid' => $this->uuid,
            'profile' => $this->whenLoaded('profile', fn() => ProfileResource::make($this->profile)),
            'name' => $this->name,
            'avatar_path' => $avatar_path,
            'email' => $this->email,
            'phone' => $this->phone,
        ];
    }
}
