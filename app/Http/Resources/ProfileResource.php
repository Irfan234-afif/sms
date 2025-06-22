<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfileResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $default_avatar = '/assets/icons/user-circle.png';

        $avatar_path = $this->avatar ? asset('storage/avatars/' . $this->avatar)
            : $default_avatar;

        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'national_id' => $this->national_id,
            'name' => $this->name,
            'full_name' => $this->name, // alias for compatibility
            'birth_place' => $this->birth_place,
            'birth_date' => $this->birth_date,
            'gender' => GetLabel::gender($this->gender),
            'blood_type' => $this->blood_type,
            'religion' => GetLabel::religion($this->religion),
            'marital_status' => GetLabel::maritalStatus($this->marital_status),
            'phone' => $this->phone,
            'email' => $this->email,
            'address' => $this->address,
            'postal_code' => $this->postal_code,
            'avatar' => $this->avatar,
            'avatar_path' => $avatar_path,
            'user' => $this->whenLoaded('user', fn() => UserResource::make($this->user)),
            'employee' => $this->whenLoaded('employee', fn() => EmployeeResource::make($this->employee)),
            'families' => $this->whenLoaded('families', fn() => FamilyResource::collection($this->families)),
            
            // Employee-related fields for training activity compatibility
            'employee_id' => $this->employee ? $this->employee->identity_number : null,
            'position' => $this->employee && $this->employee->position ? $this->employee->position->name : null,
            'area' => $this->employee && $this->employee->area ? [
                'uuid' => $this->employee->area->uuid,
                'name' => $this->employee->area->name,
            ] : null,
        ];
    }
}
