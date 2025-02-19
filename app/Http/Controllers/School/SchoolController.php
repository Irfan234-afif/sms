<?php

namespace App\Http\Controllers\School;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SchoolController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('School/Index', $data);
    }
}
