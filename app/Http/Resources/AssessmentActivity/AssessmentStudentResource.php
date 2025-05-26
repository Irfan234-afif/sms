<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentStudentResource extends JsonResource
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
            'student_name' => $this->student->profile->name,
            'aspect_results' => AssessmentAspectResultResource::collection($this->aspect_results),
            'final_results' => AssessmentFinalResultResource::collection($this->final_results),
        ];
    }
}
