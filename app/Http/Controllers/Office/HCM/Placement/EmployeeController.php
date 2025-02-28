<?php

namespace App\Http\Controllers\Office\HCM\Placement;

use App\Http\Controllers\Controller;
use App\Http\Resources\AreaResource;
use App\Http\Resources\EmployeeAssignmentResource;
use App\Http\Resources\EmployeeResource;
use App\Models\Area;
use App\Models\Employee;
use App\Models\EmployeeAssignment;
use App\Models\Position;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class EmployeeController extends Controller
{
    public function index($area_id)
    {
        $area = Area::where('uuid', $area_id)
            ->with('positions')
            ->firstOrFail();
        $employee_assignments = $area->employee_assignments();

        if (request()->has('search')) {
            $employee_assignments->whereHas('employee', function ($employee) {
                $employee->whereHas('profile', function ($profile) {
                    $profile->where('name', 'like', '%' . request('search') . '%');
                })->orWhere('identity_number', 'like', '%' . request('search') . '%');
            });
        }

        $employee_assignments = $employee_assignments->with('employee.profile.user')
            ->with('position')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'area' => AreaResource::make($area),
            'employee_assignments' => EmployeeAssignmentResource::collection($employee_assignments),
        ];

        return Inertia::render('Office/HCM/Placement/Employee/Index', $data);
    }

    public function optionEmployee()
    {
        $employees = Employee::query();

        if (request()->has('search')) {
            $employees->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        return response()->json(EmployeeResource::collection($employees->with('profile')->latest()->get()), 200);
    }

    public function assign()
    {
        DB::beginTransaction();

        try {
            $employee = Employee::where('uuid', request('employee_id'))->firstOrFail();
            $area = Area::where('uuid', request('area_id'))->firstOrFail();
            $position = Position::where('uuid', request('position_id'))->firstOrFail();

            EmployeeAssignment::updateOrCreate([
                'employee_id' => $employee->id,
                'area_id' => $area->id,
            ], [
                'position_id' => $position->id,
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karyawan berhasil ditempatkan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function remove()
    {
        DB::beginTransaction();

        try {
            $employee_assignment = EmployeeAssignment::where('uuid', request('employee_assignment_id'))->firstOrFail();

            $employee_assignment->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karyawan berhasil dihapus.',
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
