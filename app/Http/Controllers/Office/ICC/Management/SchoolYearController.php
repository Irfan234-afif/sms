<?php

namespace App\Http\Controllers\Office\ICC\Management;

use App\Http\Controllers\Controller;
use App\Http\Resources\SchoolYearResource;
use App\Models\School;
use App\Models\SchoolYear;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class SchoolYearController extends Controller
{
    public function index()
    {
        $school_years = SchoolYear::query();

        if (request()->has('search')) {
            $school_years->where('name', 'like', '%' . request('search') . '%');
        }

        $school_years = $school_years->orderBy('start_year')
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'school_years' => SchoolYearResource::collection($school_years)
        ];

        return Inertia::render('Office/ICC/Management/SchoolYear/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $school_year = SchoolYear::where('uuid', request('school_year'))->first();

            SchoolYear::updateOrCreate(
                [
                    'id' => $school_year ? $school_year->id : null,
                ],
                [
                    'name' => request('name'),
                    'start_year' => request('start_year'),
                    'end_year' => request('end_year'),
                    'is_active' => request('is_active'),
                ]
            );

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Tahun ajaran berhasil diperbarui.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function delete()
    {
        DB::beginTransaction();

        try {
            $school_year = SchoolYear::where('uuid', request('school_year'))->first();

            $school_year->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Tahun ajaran berhasil dihapus.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
}
