<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityTrainingProgramResource extends JsonResource
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
            'activity_id' => $this->activity_id,
            'master_training_program_id' => $this->master_training_program_id,
            'name' => $this->name,
            'type' => $this->type,
            'level' => $this->level,
            'description' => $this->description,
            'status' => $this->status,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'phases' => $this->whenLoaded('phases', function () {
                return ActivityPhaseResource::collection($this->phases)->resolve();
            }),
        ];
    }
} 