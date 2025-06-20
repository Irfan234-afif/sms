<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class Employee extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'profile_id',
        'identity_number',
        'start_date',
        'end_date',
        'status',
    ];

    public function profile()
    {
        return $this->belongsTo(Profile::class, 'profile_id');
    }

    public function assignment()
    {
        return $this->hasOne(EmployeeAssignment::class, 'employee_id', 'id');
    }

    public function assignments()
    {
        return $this->hasMany(EmployeeAssignment::class, 'employee_id', 'id');
    }

    public function trainingParticipations()
    {
        return $this->morphMany(\App\Models\TrainingProgram\TrainingProgramSubmissionParticipant::class, 'participant');
    }

    public static function getSchools()
    {
        $user = User::where('uuid',  Auth::user()->uuid)->first();

        if (!$user) {
            abort(404, 'User tidak ditemukan');
        }

        if ($user->hasRole('System Admin') || $user->hasRole('Site Admin')) {
            return School::with('area')->get();
        }

        $employee = optional($user->profile)->employee ?? null;

        if (!$employee) {
            abort(404, 'Employee tidak ditemukan');
        }

        $school_ids = $employee->assignments()
            ->whereHas('area', function ($query) {
                $query->whereHasMorph('model', [School::class]);
            })
            ->with('area')
            ->get()
            ->map(fn($assignment) => $assignment->area->model_id)
            ->toArray();

        $schools = School::whereIn('id', $school_ids)
            ->with('area')
            ->get();

        if ($schools->isEmpty()) {
            abort(404, 'Sekolah tidak ditemukan');
        }

        return $schools;
    }

    public static function getOffices()
    {
        $user = User::where('uuid',  Auth::user()->uuid)->first();

        if (!$user) {
            abort(404, 'User tidak ditemukan');
        }

        if ($user->hasRole('System Admin') || $user->hasRole('Site Admin')) {
            return Office::with('area')->pluck('name')->toArray();
        }

        $employee = optional($user->profile)->employee ?? null;

        if (!$employee) {
            abort(404, 'Employee tidak ditemukan');
        }

        $office_ids = $employee->assignments()
            ->whereHas('area', function ($query) {
                $query->whereHasMorph('model', [Office::class]);
            })
            ->with('area')
            ->get()
            ->map(fn($assignment) => $assignment->area->model_id)
            ->toArray();

        $offices = Office::whereIn('id', $office_ids)
            ->with('area')
            ->pluck('name')
            ->toArray();

        return $offices;
    }
}
