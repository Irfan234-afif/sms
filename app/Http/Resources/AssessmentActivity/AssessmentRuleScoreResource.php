<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentRuleScoreResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'aspect_uuid' => $this->aspect->uuid,
            'portion_score' => (float) $this->portion_score,
        ];
    }
}
