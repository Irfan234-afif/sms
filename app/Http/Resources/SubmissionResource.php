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
            'install_repair' => $this->whenLoaded('install_repair', fn() => SubInstallRepairResource::make($this->install_repair)),
            'design' => $this->whenLoaded('design', fn() => SubDesignResource::make($this->design)),
            'documentation' => $this->whenLoaded('documentation', fn() => SubDocumentationResource::make($this->documentation)),
            'broadcast' => $this->whenLoaded('broadcast', fn() => SubBroadcastResource::make($this->broadcast)),
            'media_post' => $this->whenLoaded('media_post', fn() => SubMediaPostResource::make($this->media_post)),
            'card' => $this->whenLoaded('card', fn() => SubCardResource::make($this->card)),
            'vehicle' => $this->whenLoaded('vehicle', fn() => SubVehicleResource::make($this->vehicle)),
            'material' => $this->whenLoaded('material', fn() => SubMaterialResource::make($this->material)),
            'event' => $this->whenLoaded('event', fn() => SubEventResource::make($this->event)),
            'attendance' => $this->whenLoaded('attendance', fn() => SubAttendanceResource::make($this->attendance)),
            'equipment' => $this->whenLoaded('equipment', fn() => SubEquipmentResource::make($this->equipment)),
            'outstation' => $this->whenLoaded('outstation', fn() => SubOutstationResource::make($this->outstation)),
            'leave' => $this->whenLoaded('leave', fn() => SubLeaveResource::make($this->leave)),
            'resignation' => $this->whenLoaded('resignation', fn() => SubResignationResource::make($this->resignation)),
            'training_program_submission' => $this->whenLoaded('trainingProgramSubmission', fn() => TrainingProgramSubmissionResource::make($this->trainingProgramSubmission)),
        ];
    }
}
