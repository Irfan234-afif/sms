<?php

namespace App\Http\Controllers\Office\HCM;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class HCMController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/HCM/Index', $data);
    }
}
