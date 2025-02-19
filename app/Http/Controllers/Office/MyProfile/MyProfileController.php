<?php

namespace App\Http\Controllers\Office\MyProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class MyProfileController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/MyProfile/Index', $data);
    }
}
