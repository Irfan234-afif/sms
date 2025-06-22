<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityAssessmentSessionResource extends JsonResource
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
            'activity_indicator_id' => $this->activity_indicator_id,
            'master_session_id' => $this->master_session_id,
            'name' => $this->name,
            'description' => $this->description,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'rubrics' => $this->whenLoaded('rubrics', function () {
                return ActivityAssessmentRubricResource::collection($this->rubrics)->resolve();
            }),
        ];
    }
} 