<?php

namespace App\Http\Resources\TrainingProgram;

use App\Http\Resources\ProfileResource;
use App\Http\Resources\SubmissionResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramActivityResource extends JsonResource
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
            'title' => $this->title,
            'description' => $this->description,
            'training_program_id' => $this->training_program_id,
            'submission_id' => $this->submission_id,
            'start_date' => $this->start_date?->format('Y-m-d'),
            'end_date' => $this->end_date?->format('Y-m-d'),
            'status' => $this->status,
            'location' => $this->location,
            'external_provider' => $this->external_provider,
            'created_by' => $this->created_by,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'training_program' => $this->whenLoaded('trainingProgram', function () {
                return new TrainingProgramResource($this->trainingProgram);
            }),
            'submission' => $this->whenLoaded('submission', function () {
                return new SubmissionResource($this->submission);
            }),
            'creator' => $this->whenLoaded('creator', function () {
                return new ProfileResource($this->creator);
            }),
            'participants' => $this->whenLoaded('participants', function () {
                return TrainingProgramActivityParticipantResource::collection($this->participants);
            }),
            'participants_count' => $this->when(isset($this->participants_count), $this->participants_count),
            
            // Computed properties
            'is_ongoing' => $this->isOngoing(),
            'is_completed' => $this->isCompleted(),
            'is_planned' => $this->isPlanned(),
            'duration_days' => $this->start_date && $this->end_date 
                ? $this->start_date->diffInDays($this->end_date) + 1 
                : null,
            'type' => $this->training_program_id ? 'INTERNAL' : 'EXTERNAL',
        ];
    }
}