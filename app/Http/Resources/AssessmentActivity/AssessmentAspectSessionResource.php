<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentAspectSessionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $type_label = 'Tidak diketahui';

        switch ($this->session->type) {
            case 'SCORE':
                $type_label = 'Skor';
                break;

            case 'RUBRIC':
                $type_label = 'Rubrik';
                break;
        }
        return [
            'uuid' => $this->uuid,
            'session_name' => $this->session->name,
            'description' => $this->session->description,
            'sort_order' => $this->session->sort_order,
            'use_learning_objective' => (bool) $this->session?->aspect?->use_learning_objective,
            'learning_objectives' => LearningObjectiveResource::collection($this->session->learning_objectives),
            'type' => $this->session->type,
            'type_label' => $type_label,
            'rubric_name' => $this->session->rubric ? $this->session->rubric->name : null,
            'rubric_scale_options' => $this->session->rubric ? AssessmentRubricScaleResource::collection($this->session->rubric->scales) : [],
            'rubric_scale_id' => $this->rubric_scale ? $this->rubric_scale->uuid : null,
            'raw_score' =>  $this->raw_score ?  (float)  $this->raw_score : null,
            'portion_score' => (float) $this->session->portion_score,
            'final_score' =>  $this->final_score ?  (float) $this->final_score : null,
            'final_predicate' => $this->final_predicate,
            'final_narrative' => $this->final_narrative,
        ];
    }
}
