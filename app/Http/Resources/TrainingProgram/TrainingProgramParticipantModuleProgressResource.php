<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramParticipantModuleProgressResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // Determine which module to use based on available relationships
        $module = null;
        $moduleData = null;

        // Priority: activityModule > masterModule > module (legacy)
        if ($this->relationLoaded('activityModule') && $this->activityModule) {
            $module = $this->activityModule;
            $moduleData = [
                'id' => $module->id,
                'uuid' => $module->uuid,
                'name' => $module->name,
                'description' => $module->description,
                'phase_id' => $module->activity_phase_id,
                'order' => $module->order,
                'status' => $module->status,
                'type' => 'activity_module',
            ];
        } elseif ($this->relationLoaded('masterModule') && $this->masterModule) {
            $module = $this->masterModule;
            $moduleData = [
                'id' => $module->id,
                'uuid' => $module->uuid,
                'name' => $module->name,
                'description' => $module->description,
                'phase_id' => $module->training_program_phase_id,
                'order' => $module->order,
                'status' => $module->status,
                'type' => 'master_module',
            ];
        } elseif ($this->relationLoaded('module') && $this->module) {
            $module = $this->module;
            $moduleData = [
                'id' => $module->id,
                'uuid' => $module->uuid,
                'name' => $module->name,
                'description' => $module->description,
                'phase_id' => $module->training_program_phase_id,
                'order' => $module->order,
                'status' => $module->status,
                'type' => 'legacy_module',
            ];
        }

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'participant_id' => $this->participant_id,
            'activity_module_id' => $this->activity_module_id,
            'master_module_id' => $this->master_module_id,
            'old_module_id' => $this->old_module_id,
            // Legacy field for backward compatibility
            'module_id' => $this->old_module_id ?? $this->master_module_id ?? $this->activity_module_id,
            'started_at' => $this->started_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'status' => $this->status,
            'progress_percentage' => (float) $this->progress_percentage,
            
            // Relations
            'module' => $moduleData,
            'activity_module' => $this->whenLoaded('activityModule', function () {
                return $this->activityModule ? [
                    'id' => $this->activityModule->id,
                    'uuid' => $this->activityModule->uuid,
                    'name' => $this->activityModule->name,
                    'description' => $this->activityModule->description,
                    'activity_phase_id' => $this->activityModule->activity_phase_id,
                    'order' => $this->activityModule->order,
                    'status' => $this->activityModule->status,
                ] : null;
            }),
            'master_module' => $this->whenLoaded('masterModule', function () {
                return $this->masterModule ? [
                    'id' => $this->masterModule->id,
                    'uuid' => $this->masterModule->uuid,
                    'name' => $this->masterModule->name,
                    'description' => $this->masterModule->description,
                    'training_program_phase_id' => $this->masterModule->training_program_phase_id,
                    'order' => $this->masterModule->order,
                    'status' => $this->masterModule->status,
                ] : null;
            }),
            
            // Computed properties
            'is_completed' => method_exists($this, 'isCompleted') ? $this->isCompleted() : ($this->status === 'COMPLETED'),
            'is_in_progress' => method_exists($this, 'isInProgress') ? $this->isInProgress() : ($this->status === 'IN_PROGRESS'),
            'is_not_started' => method_exists($this, 'isNotStarted') ? $this->isNotStarted() : ($this->status === 'NOT_STARTED'),
            'duration_days' => $this->started_at && $this->completed_at
                ? $this->started_at->diffInDays($this->completed_at)
                : null,
        ];
    }
}