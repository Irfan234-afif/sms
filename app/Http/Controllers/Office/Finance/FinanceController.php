<?php

namespace App\Http\Controllers\Office\Finance;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class FinanceController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/Finance/Index', $data);
    }
}
