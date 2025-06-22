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
            'status' => $this->getParticipantStatus(),
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'activity' => $this->whenLoaded('activity', function () {
                return new TrainingProgramActivityResource($this->activity);
            }),
            'profile' => $this->profile ? [
                'id' => $this->profile->id,
                'uuid' => $this->profile->uuid,
                'name' => $this->profile->name,
                'email' => $this->profile->email,
                'phone' => $this->profile->phone,
                'employee_id' => $this->profile->employee ? $this->profile->employee->identity_number : null,
                'position' => $this->profile->employee && $this->profile->employee->position ? $this->profile->employee->position->name : null,
                'area' => $this->profile->employee && $this->profile->employee->area ? [
                    'uuid' => $this->profile->employee->area->uuid,
                    'name' => $this->profile->employee->area->name,
                ] : null,
            ] : null,
            'phase_progress' => $this->whenLoaded('phaseProgress', function () {
                return TrainingProgramParticipantPhaseProgressResource::collection($this->phaseProgress)->resolve();
            }),
            'module_progress' => $this->whenLoaded('moduleProgress', function () {
                return TrainingProgramParticipantModuleProgressResource::collection($this->moduleProgress)->resolve();
            }),
            'material_progress' => $this->whenLoaded('materialProgress', function () {
                return TrainingProgramMaterialProgressResource::collection($this->materialProgress)->resolve();
            }),
            'quiz_attempts' => $this->whenLoaded('quizAttempts', function () {
                return TrainingProgramQuizAttemptResource::collection($this->quizAttempts)->resolve();
            }),
            'assessment_results' => $this->whenLoaded('assessmentResults', function () {
                return TrainingProgramAssessmentResultResource::collection($this->assessmentResults)->resolve();
            }),
            
            // Computed properties
            'has_completed' => method_exists($this, 'hasCompleted') ? $this->hasCompleted() : ($this->completion_date !== null),
            'days_enrolled' => $this->enrollment_date 
                ? $this->enrollment_date->diffInDays(now()) 
                : null,
            'days_to_complete' => $this->enrollment_date && $this->completion_date
                ? $this->enrollment_date->diffInDays($this->completion_date)
                : null,
        ];
    }

    /**
     * Get participant status based on progress and completion.
     */
    private function getParticipantStatus(): string
    {
        // If completed
        if ($this->completion_date || $this->overall_progress >= 100) {
            return 'completed';
        }

        // If has any progress
        if ($this->overall_progress > 0) {
            return 'in_progress';
        }

        // Default to enrolled
        return 'enrolled';
    }
}