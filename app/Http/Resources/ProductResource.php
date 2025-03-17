<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
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
            'area' => $this->whenLoaded('area', fn() => AreaResource::make($this->area)),
            'name' => $this->name,
            'code' => $this->code,
            'type' => $this->type,
            'price' => $this->price,
            'price_label' => 'Rp ' . number_format($this->price, 0, ',', '.'),
            'is_active' => (bool) $this->is_active,
        ];
    }
}
