<?php

namespace App\Services;

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
        $product = Product::where('code', 'ADMISSION_STUDENT_FORM')->first();
        $school = School::where('uuid', $data['school'])->firstOrFail();
        $school_year = SchoolYear::where('uuid', $data['school_year'])->firstOrFail();
        $school_grade = SchoolGrade::where('uuid', $data['school_grade'])->firstOrFail();

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
            'total_amount' => $product->price,
            'discount_amount' => 0,
            'bill_amount' => $product->price,
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
            'amount' => $product->price,
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
