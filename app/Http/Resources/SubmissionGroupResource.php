<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubmissionGroupResource extends JsonResource
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
            'code' => $this->code,
            'name_label' => GetLabel::submissionGroup($this->code),
            'reference_code' => $this->reference_code,
            'reference_number' => $this->reference_number,
        ];
    }
}
