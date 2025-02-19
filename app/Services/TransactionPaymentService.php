<?php

namespace App\Services;

use App\Models\TransactionPayment;
use Midtrans\Config;

class TransactionPaymentService
{
    public function __construct()
    {
        Config::$serverKey = config('midtrans.server_key');
        Config::$isProduction = config('midtrans.is_production');
        Config::$isSanitized = true;
        Config::$is3ds = true;
    }

    public function processPayment($data)
    {
        $transaction_payment = TransactionPayment::where('uuid', $data['transaction_payment'])->firstOrFail();

        if ($transaction_payment->type == 'ONLINE') {
            $this->handleOnlinePayment($transaction_payment, $data['gateway_response']);
        }

        $transaction = $transaction_payment->transaction;

        $this->accumulationAmountPaid($transaction);

        return [
            'transaction' => $transaction->refresh(),
            'transaction_payment' => $transaction_payment,
        ];
    }

    private function handleOnlinePayment($transaction_payment, $gateway_response)
    {
        $options = $transaction_payment->options;
        $options['gateway_response'] = $gateway_response;

        $transaction_payment->options = $options;

        if ($gateway_response['transaction_status'] === 'settlement' || $gateway_response['transaction_status'] === 'capture') {
            $transaction_payment->status = 'PAID';
        } elseif ($gateway_response['transaction_status'] === 'cancel' || $gateway_response['transaction_status'] === 'expire') {
            $transaction_payment->status = 'FAILED';
        } elseif ($gateway_response['transaction_status'] === 'pending') {
            $transaction_payment->status = 'PENDING';
        }

        $transaction_payment->save();
    }

    private function accumulationAmountPaid($transaction)
    {
        $paid_amount = $transaction->payments()->where('status', 'PAID')->sum('amount');
        $transaction->paid_amount = $paid_amount;
        $transaction->save();
    }
}
