<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramParticipantModuleProgressResource extends JsonResource
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
            'module_id' => $this->module_id,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'status' => $this->status,
            'progress_percentage' => (float) $this->progress_percentage,
            
            // Relations
            'module' => $this->whenLoaded('module', function () {
                return new PhaseModuleResource($this->module);
            }),
            
            // Computed properties
            'is_completed' => $this->isCompleted(),
            'is_in_progress' => $this->isInProgress(),
            'is_not_started' => $this->isNotStarted(),
            'duration_days' => $this->started_at && $this->completed_at
                ? $this->started_at->diffInDays($this->completed_at)
                : null,
        ];
    }
}