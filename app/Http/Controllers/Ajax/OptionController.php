<?php

namespace App\Http\Controllers\Ajax;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Models\Area;

class OptionController extends Controller
{
    public function area()
    {
        $area = Area::get();

        return response()->json(AreaResource::collection($area), 200);
    }
}
