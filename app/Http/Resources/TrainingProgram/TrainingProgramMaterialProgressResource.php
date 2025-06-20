<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramMaterialProgressResource extends JsonResource
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
            'participant_id' => $this->participant_id,
            'material_id' => $this->material_id,
            'viewed_at' => $this->viewed_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'time_spent' => $this->time_spent,
            
            // Relations
            'material' => $this->whenLoaded('material', function () {
                return new PhaseModuleMaterialResource($this->material);
            }),
            
            // Computed properties
            'is_completed' => $this->isCompleted(),
            'is_viewed' => $this->isViewed(),
            'formatted_time_spent' => $this->getFormattedTimeSpent(),
        ];
    }
}