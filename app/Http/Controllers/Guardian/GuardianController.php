<?php

namespace App\Http\Controllers\Guardian;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class GuardianController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Guardian/Index', $data);
    }
}
