<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AdmissionStageController extends Controller
{
    public function index()
    {
        $data = [];

        return Inertia::render('Office/ICC/Management/AdmissionStage/Index', $data);
    }
}
