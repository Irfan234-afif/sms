<?php

namespace App\Http\Resources\TrainingProgram;

use App\Http\Resources\ProfileResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramActivityParticipantResource extends JsonResource
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
            'profile_id' => $this->profile_id,
            'enrollment_date' => $this->enrollment_date?->format('Y-m-d'),
            'completion_date' => $this->completion_date?->format('Y-m-d'),
            'overall_progress' => (float) $this->overall_progress,
            'certificate_issued' => $this->certificate_issued,
            'certificate_number' => $this->certificate_number,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'activity' => $this->whenLoaded('activity', function () {
                return new TrainingProgramActivityResource($this->activity);
            }),
            'profile' => $this->whenLoaded('profile', function () {
                return new ProfileResource($this->profile);
            }),
            'phase_progress' => $this->whenLoaded('phaseProgress', function () {
                return TrainingProgramParticipantPhaseProgressResource::collection($this->phaseProgress);
            }),
            'module_progress' => $this->whenLoaded('moduleProgress', function () {
                return TrainingProgramParticipantModuleProgressResource::collection($this->moduleProgress);
            }),
            'material_progress' => $this->whenLoaded('materialProgress', function () {
                return TrainingProgramMaterialProgressResource::collection($this->materialProgress);
            }),
            'quiz_attempts' => $this->whenLoaded('quizAttempts', function () {
                return TrainingProgramQuizAttemptResource::collection($this->quizAttempts);
            }),
            'assessment_results' => $this->whenLoaded('assessmentResults', function () {
                return TrainingProgramAssessmentResultResource::collection($this->assessmentResults);
            }),
            
            // Computed properties
            'has_completed' => $this->hasCompleted(),
            'days_enrolled' => $this->enrollment_date 
                ? $this->enrollment_date->diffInDays(now()) 
                : null,
            'days_to_complete' => $this->enrollment_date && $this->completion_date
                ? $this->enrollment_date->diffInDays($this->completion_date)
                : null,
        ];
    }
}