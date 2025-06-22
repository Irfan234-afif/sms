<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityAssessmentGroupIndicatorResource extends JsonResource
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
            'activity_assessment_id' => $this->activity_assessment_id,
            'master_group_indicator_id' => $this->master_group_indicator_id,
            'name' => $this->name,
            'description' => $this->description,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'indicators' => $this->whenLoaded('indicators', function () {
                return ActivityAssessmentIndicatorResource::collection($this->indicators)->resolve();
            }),
        ];
    }
} 