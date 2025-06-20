<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramQuizAttemptResource extends JsonResource
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
            'quiz_id' => $this->quiz_id,
            'attempt_number' => $this->attempt_number,
            'score' => $this->score !== null ? (float) $this->score : null,
            'passed' => $this->passed,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'answers' => $this->answers,
            
            // Relations
            'quiz' => $this->whenLoaded('quiz', function () {
                return new PhaseModuleQuizResource($this->quiz);
            }),
            
            // Computed properties
            'is_completed' => $this->completed_at !== null,
            'is_in_progress' => $this->started_at !== null && $this->completed_at === null,
            'formatted_duration' => $this->getFormattedDuration(),
        ];
    }
}