<?php

namespace App\Http\Controllers\Guardian;

use App\Http\Controllers\Controller;
use App\Http\Resources\TransactionResource;
use App\Models\Transaction;
use App\Services\TransactionPaymentService;
use App\Services\TransactionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class TransactionPaymentController extends Controller
{
    public function index()
    {
        $transactions = Transaction::where('customer_id', Auth::user()->id);

        if (request()->has('search')) {
            $transactions->where('reference_number', 'like', '%' . request('search') . '%');
        }

        $transactions = $transactions->with('payments')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'transactions' => TransactionResource::collection($transactions),
        ];

        return Inertia::render('Guardian/TransactionPayment/Index', $data);
    }

    public function processPayment()
    {
        $transactionService = new TransactionService();
        $transactionPaymentService = new TransactionPaymentService();

        DB::beginTransaction();

        try {
            $result = $transactionPaymentService->processPayment(request()->all());

            if ($result['transaction']->paid_amount == $result['transaction']->bill_amount) {
                $transactionService->handlePaidOff($result['transaction']);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
}
