<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SchoolResource extends JsonResource
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
            'area' => $this->whenLoaded('area', fn() => AreaResource::make($this->area)),
            'level' => $this->whenLoaded('level', fn() => SchoolLevelResource::make($this->level)),
            'grades' => $this->whenLoaded('grades', fn() => SchoolGradeResource::collection($this->grades)),
        ];
    }
}
