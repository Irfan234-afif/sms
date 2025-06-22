<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityQuizResource extends JsonResource
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
            'activity_module_id' => $this->activity_module_id,
            'master_quiz_id' => $this->master_quiz_id,
            'title' => $this->title,
            'description' => $this->description,
            'passing_score' => (float) $this->passing_score,
            'max_attempts' => $this->max_attempts,
            'time_limit' => $this->time_limit,
            'order' => $this->order,
            'status' => $this->status,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'questions' => $this->whenLoaded('questions', function () {
                return ActivityQuizQuestionResource::collection($this->questions)->resolve();
            }),
        ];
    }
} 