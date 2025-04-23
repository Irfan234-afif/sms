<?php

namespace App\Http\Resources;

use App\Helpers\GetLabel;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubMaterialItemResource extends JsonResource
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
            'sub_material' => $this->whenLoaded('sub_material', fn() => SubMaterialResource::make($this->sub_material)),
            'name' => $this->name,
            'reference_number' => $this->reference_number,
            'quantity' => $this->quantity,
            'unit' => $this->unit,
            'unit_label' => GetLabel::unit($this->unit),
            'purchase_reference' => $this->purchase_reference,
            'price' => $this->price,
            'price_label' => 'Rp ' . number_format($this->price, 0, ',', '.'),
            'bill_amount' => $this->bill_amount,
            'bill_amount_label' => 'Rp ' . number_format($this->bill_amount, 0, ',', '.'),
            'due_date' => $this->due_date,
            'description' => $this->description,
            'attachment' => $this->attachment,
            'status' => $this->status,
        ];
    }
}
