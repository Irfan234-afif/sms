<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentResource extends JsonResource
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
            'profile' => $this->whenLoaded('profile', fn() => ProfileResource::make($this->profile)),
            'school' => $this->whenLoaded('school', fn() => SchoolResource::make($this->school)),
            'school_grade' => $this->whenLoaded('school_grade', fn() => SchoolGradeResource::make($this->school_grade)),
            'school_national_id' => $this->school_national_id,
            'admission' => $this->whenLoaded('admission', fn() => AdmissionStudentResource::make($this->admission)),
        ];
    }
}
