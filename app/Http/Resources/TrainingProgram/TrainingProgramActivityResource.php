<?php

namespace App\Http\Resources\TrainingProgram;

use App\Http\Resources\ProfileResource;
use App\Http\Resources\SubmissionResource;
use App\Http\Resources\TrainingProgramResource;
use App\Http\Resources\TrainingProgram\ActivityTrainingProgramResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramActivityResource extends JsonResource
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
            'title' => $this->title,
            'description' => $this->description,
            'training_program_id' => $this->training_program_id,
            'submission_id' => $this->submission_id,
            'start_date' => $this->start_date?->format('Y-m-d'),
            'end_date' => $this->end_date?->format('Y-m-d'),
            'status' => $this->status,
            'location' => $this->location,
            'external_provider' => $this->external_provider,
            'created_by' => $this->created_by,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'training_program' => $this->whenLoaded('trainingProgram', function () {
                return TrainingProgramResource::make($this->trainingProgram)->resolve();
            }),
            'activity_training_program' => $this->whenLoaded('activityTrainingProgram', function () {
                return ActivityTrainingProgramResource::make($this->activityTrainingProgram)->resolve();
            }),
            'submission' => $this->whenLoaded('submission', function () {
                return SubmissionResource::make($this->submission)->resolve();
            }),
            'creator' => $this->whenLoaded('creator', function () {
                return ProfileResource::make($this->creator)->resolve();
            }),
            'participants' => $this->participants ? $this->participants->map(function ($participant) {
                return [
                    'id' => $participant->id,
                    'uuid' => $participant->uuid,
                    'activity_id' => $participant->activity_id,
                    'profile_id' => $participant->profile_id,
                    'enrollment_date' => $participant->enrollment_date?->format('Y-m-d'),
                    'completion_date' => $participant->completion_date?->format('Y-m-d'),
                    'overall_progress' => (float) $participant->overall_progress,
                    'certificate_issued' => $participant->certificate_issued,
                    'certificate_number' => $participant->certificate_number,
                    'has_completed' => $participant->hasCompleted(),
                    'profile' => $participant->profile ? [
                        'id' => $participant->profile->id,
                        'uuid' => $participant->profile->uuid,
                        'name' => $participant->profile->name,
                        'email' => $participant->profile->email,
                        'phone' => $participant->profile->phone,
                        'employee_id' => $participant->profile->employee ? $participant->profile->employee->identity_number : null,
                        'position' => $participant->profile->employee && $participant->profile->employee->position ? $participant->profile->employee->position->name : null,
                        'area' => $participant->profile->employee && $participant->profile->employee->area ? [
                            'uuid' => $participant->profile->employee->area->uuid,
                            'name' => $participant->profile->employee->area->name,
                        ] : null,
                    ] : null,
                ];
            })->values()->toArray() : [],
            'participants_count' => $this->when(isset($this->participants_count), $this->participants_count),
            'completed_participants_count' => $this->when(isset($this->completed_participants_count), $this->completed_participants_count),
            'overall_progress' => $this->when(isset($this->participants_avg_overall_progress), round((float) $this->participants_avg_overall_progress)),
            
            // Computed properties
            'is_ongoing' => $this->isOngoing(),
            'is_completed' => $this->isCompleted(),
            'is_planned' => $this->isPlanned(),
            'duration_days' => $this->start_date && $this->end_date 
                ? $this->start_date->diffInDays($this->end_date) + 1 
                : null,
            'type' => $this->training_program_id ? 'INTERNAL' : 'EXTERNAL',
        ];
    }
}