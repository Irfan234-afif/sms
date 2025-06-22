<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PhaseModuleResource extends JsonResource
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
            'phase_id' => $this->phase_id,
            'name' => $this->name,
            'description' => $this->description,
            'order' => $this->order,
            'status' => $this->status,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'materials' => $this->whenLoaded('materials', function () {
                return PhaseModuleMaterialResource::collection($this->materials);
            }),
            'quizzes' => $this->whenLoaded('quizzes', function () {
                return PhaseModuleQuizResource::collection($this->quizzes);
            }),
            'assessments' => $this->whenLoaded('assessments', function () {
                return ModuleAssessmentResource::collection($this->assessments);
            }),
        ];
    }
}