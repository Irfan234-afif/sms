<?php

namespace App\Http\Controllers\Office\ICC;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ICCController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/ICC/Index', $data);
    }
}
