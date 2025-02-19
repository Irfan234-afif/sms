<?php

namespace App\Services;

use App\Models\AdmissionStudent;
use Illuminate\Support\Str;

class TransactionService
{
    public function __construct()
    {
        //   
    }

    public function handlePaidOff($transaction)
    {
        if ($transaction->sub_type == 'ADMISSION_STUDENT_FORM') {
            $this->handleAdmissionForm($transaction);
        }
    }

    public function handleAdmissionForm($transaction)
    {
        $transaction_item = $transaction->items()->first();
        $module = $transaction_item ? $transaction_item->options['module'] : null;

        if ($module) {
            AdmissionStudent::firstOrCreate([
                'transaction_id' => $transaction->id,
            ], [
                'school_id' => $module['school_id'],
                'school_year_id' => $module['school_year_id'],
                'school_grade_id' => $module['school_grade_id'],
                'name' => $module['name'],
                'birth_date' => $module['birth_date'],
                'registration_number' => 'ADM-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                'status' => 'NEW',
            ]);
        }
    }
}
