<?php

namespace App\Http\Resources\AssessmentActivity;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentRecordResource extends JsonResource
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
            'name' => $this->name,
            'classroom_uuid' => $this->classroom->uuid,
            'classroom_name' => $this->classroom->title,
            'subject_name' => $this->subject->title,
            'module_name' => $this->module->name,
            'students' => AssessmentStudentResource::collection($this->students),
        ];
    }
}
