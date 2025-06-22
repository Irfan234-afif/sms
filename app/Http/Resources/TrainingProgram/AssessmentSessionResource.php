<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentSessionResource extends JsonResource
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
            'indicator_id' => $this->indicator_id,
            'name' => $this->name,
            'description' => $this->description,
            'max_score' => $this->max_score !== null ? (float) $this->max_score : null,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'rubrics' => $this->whenLoaded('rubrics', function () {
                return AssessmentRubricResource::collection($this->rubrics);
            }),
        ];
    }
} 