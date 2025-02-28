<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EmployeeResource extends JsonResource
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
            'identity_number' => $this->identity_number,
            'start_date' => $this->start_date,
            'end_date' => $this->end_date,
            'status' => $this->status,
            'status_label' => $this->getStatusLabel(),
            'assignment' => $this->whenLoaded('assignment', fn() => EmployeeAssignmentResource::make($this->assignment)),
        ];
    }

    private function getStatusLabel(): string
    {
        switch ($this->status) {
            case 'PERMANENT':
                return 'Tetap';
            case 'CONTRACT':
                return 'Kontrak';
            case 'PROBATION':
                return 'Percobaan';
            case 'DAILY':
                return 'Harian';
            case 'PART_TIME':
                return 'Paruh Waktu';
            default:
                return 'Tidak Diketahui';
        }
    }
}
