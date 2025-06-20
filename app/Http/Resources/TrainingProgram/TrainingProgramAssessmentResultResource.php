<?php

namespace App\Http\Resources\TrainingProgram;

use App\Http\Resources\ProfileResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramAssessmentResultResource extends JsonResource
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
            'assessment_id' => $this->assessment_id,
            'assessor_id' => $this->assessor_id,
            'scores' => $this->scores,
            'final_score' => $this->final_score !== null ? (float) $this->final_score : null,
            'feedback' => $this->feedback,
            'assessed_at' => $this->assessed_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'assessment' => $this->whenLoaded('assessment', function () {
                return new ModuleAssessmentResource($this->assessment);
            }),
            'assessor' => $this->whenLoaded('assessor', function () {
                return new ProfileResource($this->assessor);
            }),
            
            // Computed properties
            'is_passed' => $this->isPassed(),
            'grade' => $this->getGrade(),
        ];
    }
}