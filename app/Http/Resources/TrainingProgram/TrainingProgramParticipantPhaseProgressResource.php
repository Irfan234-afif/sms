<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramParticipantPhaseProgressResource extends JsonResource
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
            'phase_id' => $this->phase_id,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'progress_percentage' => (float) $this->progress_percentage,
            
            // Relations
            'phase' => $this->whenLoaded('phase', function () {
                return new TrainingProgramPhaseResource($this->phase);
            }),
            
            // Computed properties
            'is_completed' => $this->isCompleted(),
            'is_started' => $this->started_at !== null,
            'duration_days' => $this->started_at && $this->completed_at
                ? $this->started_at->diffInDays($this->completed_at)
                : null,
        ];
    }
}