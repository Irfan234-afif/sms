<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SchoolCurriculumResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'uuid' => $this->uuid,
            'title' => $this->title,
            'code' => $this->code,
            'learning_objective_categories' => $this->whenLoaded(
                'learning_objective_categories',
                fn() => LearningObjectiveResource::collection($this->learning_objective_categories)
            ),
            'assessment_modules' => $this->whenLoaded(
                'assessment_modules',
                fn() => LearningObjectiveResource::collection($this->assessment_modules)
            ),
        ];
    }
}
