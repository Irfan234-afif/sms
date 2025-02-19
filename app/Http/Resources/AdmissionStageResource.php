<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AdmissionStageResource extends JsonResource
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
            'type' => $this->type,
            'sort_number' => $this->sort_number,
            'statuses' => $this->whenLoaded('statuses', fn() => AdmissionStageStatusResource::collection($this->statuses)),
        ];
    }
}
