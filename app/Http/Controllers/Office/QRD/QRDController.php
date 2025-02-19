<?php

namespace App\Http\Controllers\Office\QRD;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class QRDController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/QRD/Index', $data);
    }
}
