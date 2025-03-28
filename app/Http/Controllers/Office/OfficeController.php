<?php

namespace App\Http\Controllers\Office;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OfficeController extends Controller
{
    public function index()
    {
        $profile = auth()->user()->profile()->with([
            'families',
            'academic_records',
            'training_records',
            'specializations',
            'experiences',
            'certifications',
            'community_involvements',
            'honor_prizes',
            'language_skills',
            'attachments',
        ])->first();
        
        $data = [
            'profile' => $profile,
        ];

        return Inertia::render('Office/Index', $data);
    }
}
