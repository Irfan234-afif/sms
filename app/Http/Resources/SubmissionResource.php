<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubmissionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $carbon = new Carbon();

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'submission_group' => $this->submission_group,
            'area' => $this->area,
            'submitter' => $this->submitter,
            'reference_number' => $this->reference_number,
            'datetime' => $this->datetime,
            'datetime_label' => $this->datetime ? $carbon->parse($this->datetime)->format('d-m-Y') : null,
            'status' => $this->status,
            'status_label' => GetLabel::approvalStatus($this->status),
            'approvals' => $this->whenLoaded('approvals', fn() => SubmissionApprovalResource::collection($this->approvals)),
            'material' => $this->material,
        ];
    }
}
