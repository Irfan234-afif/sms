<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TransactionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $carbon = new Carbon();
        $sub_type_label  = null;
        $is_paid_off   = false;

        switch ($this->sub_type) {
            case 'ADMISSION_STUDENT_FORM':
                $sub_type_label  = 'Formulir Pendaftaran Siswa Baru';
                break;

            default:
                $sub_type_label = '-';
                break;
        }


        if ($this->paid_amount == $this->bill_amount) {
            $is_paid_off = true;
        }

        return [
            'uuid' => $this->uuid,
            'customer' => $this->whenLoaded('customer', fn() => UserResource::make($this->customer)),
            'type' => $this->type,
            'sub_type' => $this->sub_type,
            'sub_type_label' => $sub_type_label,
            'reference_number' => $this->reference_number,
            'due_date' => $this->due_date,
            'due_date_label' => $this->due_date ? $carbon->parse($this->due_date)->format('d-m-Y') : null,
            'total_amount' => $this->total_amount,
            'discount_amount' => $this->discount_amount,
            'bill_amount' => $this->bill_amount,
            'paid_amount' => $this->paid_amount,
            'is_paid_off' => $is_paid_off,
            'paid_off_label' => $is_paid_off ? 'Lunas' : 'Belum lunas',
            'payments' => $this->whenLoaded('payments', fn() => TransactionPaymentResource::collection($this->payments)),
            'items' => $this->whenLoaded('items', fn() => TransactionItemResource::collection($this->items)),
            'updated_at' => $this->updated_at,
        ];
    }
}
