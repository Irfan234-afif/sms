<?php

namespace App\Services;

use App\Models\Discount;
use App\Models\Product;
use App\Models\School;
use App\Models\SchoolGrade;
use App\Models\SchoolYear;
use App\Models\Transaction;
use Illuminate\Support\Facades\Auth;
use Midtrans\Config;
use Midtrans\Snap;
use Ramsey\Uuid\Uuid;
use Illuminate\Support\Str;

class AdmissionStudentService
{
    public function __construct()
    {
        Config::$serverKey = config('midtrans.server_key');
        Config::$isProduction = config('midtrans.is_production');
        Config::$isSanitized = true;
        Config::$is3ds = true;
    }

    public function processCheckout($data)
    {
        $customer = Auth::user();
        $school = School::where('uuid', $data['school_id'])->firstOrFail();
        $school_year = SchoolYear::where('uuid', $data['school_year_id'])->firstOrFail();
        $school_grade = SchoolGrade::where('uuid', $data['school_grade_id'])->firstOrFail();
        $discount = Discount::where('uuid', $data['discount_id'])->firstOrFail();
        $product = Product::where('uuid', $data['product_id'])->firstOrFail();

        $module = [
            'name' => $data['name'],
            'birth_date' => $data['birth_date'],
            'school_id' => $school->id,
            'school_year_id' => $school_year->id,
            'school_grade_id' => $school_grade->id,
        ];

        $transaction = Transaction::create([
            'customer_id' => $customer->id,
            'type' => 'SALES',
            'sub_type' => 'ADMISSION_STUDENT_FORM',
            'reference_number' => 'TRX-ASF-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
            'due_date' => now()->addDays(1),
            'total_amount' => $data['total_amount'],
            'discount_amount' => $data['discount_amount'],
            'bill_amount' => $data['bill_amount'],
            'paid_amount' => 0,
        ]);

        $transaction->items()->create([
            'product_id' => $product->id,
            'price' => $product->price,
            'quantity' => 1,
            'total_amount' => $product->price,
            'bill_amount' => $product->price,
            'options' => [
                'module' => $module
            ],
        ]);

        $transaction->discounts()->create([
            'discount_id' => $discount->id,
            'type' => $discount->type,
            'value' => $discount->value,
            'total_amount' =>  $data['discount_amount'],
        ]);

        $discount->increment('used_quota', 1);

        $params = [
            'transaction_details' => [
                'order_id' => 'TRX-CUST-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                'gross_amount' => $transaction->bill_amount
            ],
            'customer_details' => [
                'first_name' => $customer->name,
                'email' => $customer->email,
                'phone' => $customer->profile?->phone,
            ],
            'callbacks' => [
                "notification" => "https://example.com/api/midtrans/webhook"
            ],
        ];

        $snapToken = Snap::getSnapToken($params);

        $transaction_payment = $transaction->payments()->create([
            'reference_number' => $params['transaction_details']['order_id'],
            'type' => 'ONLINE',
            'amount' => $transaction->bill_amount,
            'options' => [
                'gateway_provider' => 'MIDTRANS',
                'gateway_token' => $snapToken,
                'gateway_response' => null,
            ],
            'status' => 'PENDING',
        ]);

        return [
            'transaction_payment' => $transaction_payment,
            'snap_token' => $snapToken
        ];
    }
}
