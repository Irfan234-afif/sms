<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SchoolYearResource extends JsonResource
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
            'start_year' => $this->start_year,
            'end_year' => $this->end_year,
            'is_active' => (bool) $this->is_active,
            'admission_student_quotas' => $this->whenLoaded('admission_student_quotas', fn() => AdmissionStudentQuotaResource::collection($this->admission_student_quotas)),
        ];
    }
}
