<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentAspectResultResource extends JsonResource
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
            'aspect_uuid' => $this->aspect->uuid,
            'aspect_name' => $this->aspect->name,
            'sort_order' => $this->aspect->sort_order,
            'use_final_score' => (bool) $this->aspect->use_final_score,
            'final_score_method' => $this->aspect->final_score_method,
            'raw_score' =>  $this->raw_score ?  (float)  $this->raw_score : null,
            'final_score' =>  $this->final_score ?  (float) $this->final_score : null,
            'final_predicate' => $this->final_predicate,
            'final_narrative' => $this->final_narrative,
            'sessions' => AssessmentAspectSessionResource::collection($this->sessions)
        ];
    }
}
