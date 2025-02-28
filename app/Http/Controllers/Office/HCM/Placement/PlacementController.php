<?php

namespace App\Http\Controllers\Office\HCM\Placement;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Models\Area;
use Inertia\Inertia;

class PlacementController extends Controller
{
    public function index()
    {
        $areas = Area::query();

        if (request()->has('search')) {
            $areas->where('name', 'like', '%' . request('search') . '%');
        }

        $areas = $areas->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'areas' => AreaResource::collection($areas),
        ];

        return Inertia::render('Office/HCM/Placement/Index', $data);
    }
}
