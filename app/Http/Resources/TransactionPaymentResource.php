<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TransactionPaymentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $status_label  = null;

        switch ($this->status) {
            case 'PAID':
                $status_label  = 'Sudah dibayar';
                break;

            case 'UNPAID':
                $status_label  = 'Belum dibayar';
                break;

            case 'PENDING':
                $status_label  = 'Menunggu pembayaran';
                break;

            default:
                $status_label = '-';
                break;
        }

        return [
            'uuid' => $this->uuid,
            'transaction' => $this->whenLoaded('transaction', fn() => TransactionResource::make($this->transaction)),
            'reference_number' => $this->reference_number,
            'type' => $this->type,
            'amount' => $this->amount,
            'options' => $this->options,
            'status' => $this->status,
            'status_label' => $status_label,
        ];
    }
}
