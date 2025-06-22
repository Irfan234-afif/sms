<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramMaterialProgressResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // Determine which material ID to use based on available data
        $materialId = null;
        if ($this->activity_material_id) {
            $materialId = $this->activity_material_id;
        } elseif ($this->master_material_id) {
            $materialId = $this->master_material_id;
        } elseif ($this->old_material_id) {
            $materialId = $this->old_material_id;
        }

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'participant_id' => $this->participant_id,
            'material_id' => $materialId, // Use the determined material ID
            'activity_material_id' => $this->activity_material_id,
            'master_material_id' => $this->master_material_id,
            'old_material_id' => $this->old_material_id,
            'viewed_at' => $this->viewed_at?->format('Y-m-d H:i:s'),
            'completed_at' => $this->completed_at?->format('Y-m-d H:i:s'),
            'time_spent' => $this->time_spent,
            
            // Relations
            'activity_material' => $this->whenLoaded('activityMaterial', function () {
                return [
                    'id' => $this->activityMaterial->id,
                    'uuid' => $this->activityMaterial->uuid,
                    'title' => $this->activityMaterial->title,
                    'type' => $this->activityMaterial->type ?? 'text',
                    'content' => $this->activityMaterial->content,
                    'file_path' => $this->activityMaterial->file_path,
                ];
            }),
            'master_material' => $this->whenLoaded('masterMaterial', function () {
                return [
                    'id' => $this->masterMaterial->id,
                    'uuid' => $this->masterMaterial->uuid,
                    'title' => $this->masterMaterial->title,
                    'type' => $this->masterMaterial->type ?? 'text',
                    'content' => $this->masterMaterial->content,
                    'file_path' => $this->masterMaterial->file_path,
                ];
            }),
            'material' => $this->whenLoaded('material', function () {
                return [
                    'id' => $this->material->id,
                    'uuid' => $this->material->uuid,
                    'title' => $this->material->title,
                    'type' => $this->material->type ?? 'text',
                    'content' => $this->material->content,
                    'file_path' => $this->material->file_path,
                ];
            }),
            
            // Computed properties
            'is_completed' => $this->completed_at !== null,
            'is_viewed' => $this->viewed_at !== null,
            'formatted_time_spent' => $this->time_spent . ' menit',
        ];
    }
}