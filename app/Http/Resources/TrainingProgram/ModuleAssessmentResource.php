<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ModuleAssessmentResource extends JsonResource
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
            'module_id' => $this->module_id,
            'name' => $this->name,
            'description' => $this->description,
            'passing_score' => (float) $this->passing_score,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'group_indicators' => $this->whenLoaded('groupIndicators', function () {
                return AssessmentGroupIndicatorResource::collection($this->groupIndicators);
            }),
        ];
    }
}