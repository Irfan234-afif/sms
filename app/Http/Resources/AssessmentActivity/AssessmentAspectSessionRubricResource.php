<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentAspectSessionRubricResource extends JsonResource
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
            'rubric_code' => $this->generateAcronym($this->session_rubric?->rubric?->name),
            'rubric_name' => $this->session_rubric?->rubric?->name,
            'rubric_scale_options' => $this->session_rubric?->rubric ? AssessmentRubricScaleResource::collection($this->session_rubric->rubric->scales) : [],
            'rubric_scale_id' => $this->rubric_scale ? $this->rubric_scale->uuid : null,
            'score' => $this->score,
            'predicate' => $this->predicate,
            'narrative' => $this->narrative,
        ];
    }

    protected function generateAcronym(string $name): string
    {
        $words = explode(' ', $name);

        if (count($words) === 1) {
            return strtoupper(mb_substr($words[0], 0, 3));
        }

        return strtoupper(collect($words)->map(fn($word) => mb_substr($word, 0, 1))->implode(''));
    }
}
