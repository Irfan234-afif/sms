<?php

namespace App\Http\Resources\TrainingProgram;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PhaseModuleMaterialResource extends JsonResource
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
            'module_id' => $this->module_id,
            'title' => $this->title,
            'content' => $this->content,
            'type' => $this->type,
            'video_url' => $this->video_url,
            'document_url' => $this->document_url,
            'external_link' => $this->external_link,
            'order' => $this->order,
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
        ];
    }
}