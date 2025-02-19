<?php

namespace App\Http\Controllers\Office;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OfficeController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/Index', $data);
    }
}
