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
            'activity_assessment_id' => $this->activity_assessment_id,
            'master_assessment_id' => $this->master_assessment_id,
            'old_assessment_id' => $this->old_assessment_id,
            'assessment_id' => $this->assessment_id, // Legacy compatibility
            'assessor_id' => $this->assessor_id,
            'scores' => method_exists($this, 'getValidScores') ? $this->getValidScores() : $this->scores,
            'original_scores' => $this->scores, // Keep original for debugging
            'final_score' => $this->final_score !== null ? (float) $this->final_score : null,
            'feedback' => $this->feedback,
            'assessed_at' => $this->assessed_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'assessment' => $this->whenLoaded('assessment', function () {
                // Use activity assessment data if available (from snapshot)
                if ($this->activityAssessment) {
                    return [
                        'id' => $this->activityAssessment->id,
                        'uuid' => $this->activityAssessment->uuid,
                        'name' => $this->activityAssessment->title,
                        'description' => $this->activityAssessment->description,
                        'passing_score' => $this->activityAssessment->passing_score,
                    ];
                }
                
                // Fallback to master assessment for legacy data
                return [
                    'id' => $this->assessment->id,
                    'uuid' => $this->assessment->uuid,
                    'name' => $this->assessment->name ?? $this->assessment->title,
                    'description' => $this->assessment->description,
                    'passing_score' => $this->assessment->passing_score,
                ];
            }),
            'activity_assessment' => $this->whenLoaded('activityAssessment', function () {
                return ActivityAssessmentResource::make($this->activityAssessment)->resolve();
            }),
            'assessor' => $this->whenLoaded('assessor', function () {
                return [
                    'id' => $this->assessor->id,
                    'uuid' => $this->assessor->uuid,
                    'name' => $this->assessor->name,
                    'email' => $this->assessor->email,
                ];
            }),
            
            // Computed properties
            'is_passed' => method_exists($this, 'isPassed') ? $this->isPassed() : ($this->final_score >= 70),
            'grade' => method_exists($this, 'getGrade') ? $this->getGrade() : 
                ($this->final_score >= 90 ? 'A' : 
                ($this->final_score >= 80 ? 'B' : 
                ($this->final_score >= 70 ? 'C' : 
                ($this->final_score >= 60 ? 'D' : 'E')))),
        ];
    }
}