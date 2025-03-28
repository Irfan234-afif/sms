<?php

namespace App\Http\Controllers\Office\HCM\Employee;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Models\Employee;
use App\Models\Profile;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;

class EmployeeController extends Controller
{
    public function index()
    {
        $employees = Employee::query();

        if (request()->has('search')) {
            $employees->whereHas('profile', function ($profile) {
                $profile->where('name', 'like', '%' . request('search') . '%');
            })->orWhere('identity_number', 'like', '%' . request('search') . '%');
        }

        $employees = $employees->with('profile.user')
            ->with('assignment.area')
            ->with('assignment.position')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'employees' => EmployeeResource::collection($employees),
        ];

        return Inertia::render('Office/HCM/Employee/Index', $data);
    }

    public function detail($uuid)
    {
        $employee = Employee::with([
            'profile.families',
            'profile.academic_records',
            'profile.training_records',
            'profile.specializations',
            'profile.experiences',
            'profile.certifications',
            'profile.community_involvements',
            'profile.honor_prizes',
            'profile.language_skills',
            'profile.attachments',
        ])->where('uuid', $uuid)->first();

        $data = [
            'employee' => $employee,
        ];

        return Inertia::render('Office/HCM/Employee/Detail', $data);
    }

    public function store()
    {
        DB::beginTransaction();

        try {
            $profile_created = Profile::create([
                'national_id' => request('national_id'),
                'name' => request('name'),
                'birth_place' => request('birth_place'),
                'birth_date' => request('birth_date'),
                'gender' => request('gender'),
                'blood_type' => request('blood_type'),
                'religion' => request('religion'),
                'marital_status' => request('marital_status'),
                'phone' => request('phone'),
                'email' => request('email'),
                'address' => request('address'),
                'postal_code' => request('postal_code'),
            ]);

            Employee::create([
                'profile_id' => $profile_created->id,
                'identity_number' => request('identity_number'),
                'start_date' => request('start_date'),
                'end_date' => request('end_date'),
                'status' => request('status'),
            ]);

            $user_created = $profile_created->user()->create([
                'name' => request('name'),
                'email' => request('email'),
                'phone' => request('phone'),
                'password' => Hash::make(request('password')),
            ]);

            $user_created->assignRole(['Employee']);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karyawan berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function update()
    {
        DB::beginTransaction();

        try {
            $employee = Employee::where('uuid', request('employee_id'))->firstOrFail();

            $employee->profile()->update([
                'national_id' => request('national_id'),
                'name' => request('name'),
                'birth_place' => request('birth_place'),
                'birth_date' => request('birth_date'),
                'gender' => request('gender'),
                'blood_type' => request('blood_type'),
                'religion' => request('religion'),
                'marital_status' => request('marital_status'),
                'phone' => request('phone'),
                'email' => request('email'),
                'address' => request('address'),
                'postal_code' => request('postal_code'),
            ]);

            $employee->update([
                'identity_number' => request('identity_number'),
                'start_date' => request('start_date'),
                'end_date' => request('end_date'),
                'status' => request('status'),
            ]);

            if (!$employee->profile->user) {
                $employee->profile->user()->create([
                    'name' => request('name'),
                    'email' => request('email'),
                    'phone' => request('phone'),
                    'password' => Hash::make(request('password')),
                ]);
            }

            $employee->profile->user()->update([
                'name' => request('name'),
                'email' => request('email'),
                'phone' => request('phone'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Karyawan berhasil diperbarui.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function resetPassword()
    {
        DB::beginTransaction();

        try {
            $user = User::where('uuid', request('user_id'))->firstOrFail();

            $user->update([
                'password' => Hash::make(request('password')),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Kata sandi berhasil diperbarui.',
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
            $employee = Employee::where('uuid', request('employee_id'))->firstOrFail();

            $employee->delete();

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
