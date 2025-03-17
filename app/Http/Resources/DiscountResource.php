<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DiscountResource extends JsonResource
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
            'type' => $this->type,
            'type_label' => GetLabel::discountType($this->type),
            'description' => $this->description,
            'value' => $this->value,
            'value_label' => $this->type == 'FIXED' ? 'Rp ' . number_format($this->value, 0, ',', '.') : $this->value . ' ' . '%',
            'starts_at' => $this->starts_at,
            'ends_at' => $this->ends_at,
            'quota' => $this->quota,
            'used_quota' => $this->used_quota,
            'is_active' => (bool) $this->is_active,
            'usages' => $this->whenLoaded('usages', fn() => AreaResource::collection($this->usages)),
        ];
    }
}
