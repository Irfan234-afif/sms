<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubmissionApprovalResource extends JsonResource
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
            'submission' => $this->whenLoaded('submission', fn() => SubmissionResource::make($this->submission)),
            'approver' => $this->whenLoaded('approver', fn() => EmployeeResource::make($this->approver)),
            'delegate' => $this->whenLoaded('delegate', fn() => EmployeeResource::make($this->delegate)),
            'is_delegated' => $this->is_delegated,
            'sort_number' => $this->sort_number,
            'datetime' => $this->datetime,
            'status' => $this->status,
            'status_label' => GetLabel::approvalStatus($this->status),
        ];
    }
}
