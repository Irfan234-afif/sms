<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentIndicatorResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'group_indicator_id' => $this->group_indicator_id,
            'name' => $this->name,
            'description' => $this->description,
            'weight' => $this->weight !== null ? (float) $this->weight : null,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'sessions' => $this->whenLoaded('sessions', function () {
                return AssessmentSessionResource::collection($this->sessions);
            }),
        ];
    }
} 