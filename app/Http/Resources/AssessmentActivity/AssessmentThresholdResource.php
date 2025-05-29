<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentThresholdResource extends JsonResource
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
            'type' => $this->type,
            'score' => $this->score,
            'predicate' => $this->predicate,
            'narrative' => $this->narrative,
        ];
    }
}
