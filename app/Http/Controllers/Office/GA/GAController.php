<?php

namespace App\Http\Controllers\Office\GA;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class GAController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/GA/Index', $data);
    }
}
