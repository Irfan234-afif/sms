<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityModuleResource extends JsonResource
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
            'activity_phase_id' => $this->activity_phase_id,
            'master_module_id' => $this->master_module_id,
            'name' => $this->name,
            'description' => $this->description,
            'order' => $this->order,
            'status' => $this->status,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'materials' => $this->whenLoaded('materials', function () {
                return ActivityMaterialResource::collection($this->materials)->resolve();
            }),
            'quizzes' => $this->whenLoaded('quizzes', function () {
                return ActivityQuizResource::collection($this->quizzes)->resolve();
            }),
            'assessments' => $this->whenLoaded('assessments', function () {
                return ActivityAssessmentResource::collection($this->assessments)->resolve();
            }),
        ];
    }
} 