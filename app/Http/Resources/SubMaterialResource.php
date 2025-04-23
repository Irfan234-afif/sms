<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubMaterialResource extends JsonResource
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
            'bill_amount' => $this->bill_amount,
            'items' => $this->whenLoaded('items', fn() => SubMaterialItemResource::collection($this->items)),
        ];
    }
}
