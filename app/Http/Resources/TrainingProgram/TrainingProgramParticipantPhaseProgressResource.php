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
        // Determine which phase to use based on available relationships
        $phase = null;
        $phaseData = null;

        // Priority: activityPhase > masterPhase > phase (legacy)
        if ($this->relationLoaded('activityPhase') && $this->activityPhase) {
            $phase = $this->activityPhase;
            $phaseData = [
                'id' => $phase->id,
                'uuid' => $phase->uuid,
                'name' => $phase->name,
                'description' => $phase->description,
                'order' => $phase->order,
                'status' => $phase->status,
                'type' => 'activity_phase',
            ];
        } elseif ($this->relationLoaded('masterPhase') && $this->masterPhase) {
            $phase = $this->masterPhase;
            $phaseData = [
                'id' => $phase->id,
                'uuid' => $phase->uuid,
                'name' => $phase->name,
                'description' => $phase->description,
                'order' => $phase->order,
                'status' => $phase->status,
                'type' => 'master_phase',
            ];
        } elseif ($this->relationLoaded('phase') && $this->phase) {
            $phase = $this->phase;
            $phaseData = [
                'id' => $phase->id,
                'uuid' => $phase->uuid,
                'name' => $phase->name,
                'description' => $phase->description,
                'order' => $phase->order,
                'status' => $phase->status,
                'type' => 'legacy_phase',
            ];
        }

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'participant_id' => $this->participant_id,
            'activity_phase_id' => $this->activity_phase_id,
            'master_phase_id' => $this->master_phase_id,
            'old_phase_id' => $this->old_phase_id,
            // Legacy field for backward compatibility
            'phase_id' => $this->old_phase_id ?? $this->master_phase_id ?? $this->activity_phase_id,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'progress_percentage' => (float) $this->progress_percentage,
            
            // Relations
            'phase' => $phaseData,
            'activity_phase' => $this->whenLoaded('activityPhase', function () {
                return $this->activityPhase ? [
                    'id' => $this->activityPhase->id,
                    'uuid' => $this->activityPhase->uuid,
                    'name' => $this->activityPhase->name,
                    'description' => $this->activityPhase->description,
                    'order' => $this->activityPhase->order,
                    'status' => $this->activityPhase->status,
                ] : null;
            }),
            'master_phase' => $this->whenLoaded('masterPhase', function () {
                return $this->masterPhase ? [
                    'id' => $this->masterPhase->id,
                    'uuid' => $this->masterPhase->uuid,
                    'name' => $this->masterPhase->name,
                    'description' => $this->masterPhase->description,
                    'order' => $this->masterPhase->order,
                    'status' => $this->masterPhase->status,
                ] : null;
            }),
            
            // Computed properties
            'is_completed' => method_exists($this, 'isCompleted') ? $this->isCompleted() : ($this->completed_at !== null),
            'is_started' => $this->started_at !== null,
            'duration_days' => $this->started_at && $this->completed_at
                ? $this->started_at->diffInDays($this->completed_at)
                : null,
        ];
    }
}