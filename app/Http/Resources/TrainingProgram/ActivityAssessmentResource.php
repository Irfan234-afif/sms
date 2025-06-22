<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ActivityAssessmentResource extends JsonResource
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
            'activity_module_id' => $this->activity_module_id,
            'master_assessment_id' => $this->master_assessment_id,
            'title' => $this->title,
            'description' => $this->description,
            'calculation_method' => $this->calculation_method ?? 'AVERAGE',
            'passing_score' => $this->passing_score ?? 70,
            'status' => $this->status,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Relations
            'activity_module' => $this->whenLoaded('activityModule', function () {
                return [
                    'id' => $this->activityModule->id,
                    'name' => $this->activityModule->name,
                    'activity_phase' => $this->activityModule->activityPhase ? [
                        'id' => $this->activityModule->activityPhase->id,
                        'name' => $this->activityModule->activityPhase->name,
                    ] : null,
                ];
            }),
            'group_indicators' => $this->whenLoaded('groupIndicators', function () {
                return ActivityAssessmentGroupIndicatorResource::collection($this->groupIndicators)->resolve();
            }),
            
            // Computed properties
            'total_indicators' => $this->when($this->relationLoaded('groupIndicators'), function () {
                return $this->groupIndicators->sum(function ($group) {
                    return $group->indicators ? $group->indicators->count() : 0;
                });
            }),
            'total_sessions' => $this->when($this->relationLoaded('groupIndicators'), function () {
                return $this->groupIndicators->sum(function ($group) {
                    return $group->indicators ? $group->indicators->sum(function ($indicator) {
                        return $indicator->sessions ? $indicator->sessions->count() : 0;
                    }) : 0;
                });
            }),
        ];
    }
} 