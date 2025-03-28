<?php

namespace App\Http\Middleware;

use App\Models\Employee;
use App\Models\School;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        // todo: session
        $user = User::where('uuid', $request->user()?->uuid)
            ->with('profile.employee')
            ->first();

        $available_schools = collect();
        $active_school = null;
        $available_offices = collect();

        if ($request->user()) {
            if (Str::startsWith($request->path(), 'school')) {
                $available_schools = Employee::getSchools() ?? collect();
            }

            if ($available_schools->isNotEmpty()) {
                $active_school = Session::get('active_school');

                if (!$active_school) {
                    $active_school = School::where('id', $available_schools->first()->id)
                        ->with('area')
                        ->with('academic_program_active.year')
                        ->with('academic_program_active.curriculum')
                        ->first();
                    Session::put('active_school', $active_school);
                }
            }

            if (Str::startsWith($request->path(), 'office')) {
                $available_offices = Employee::getOffices() ?? collect();
            }
        }

        return [
            ...parent::share($request),
            'auth' => [
                'user' => $user,
                'roles' => $request->user()?->roles()->pluck('name'),
                'permissions' => $request->user()?->getPermissionsViaRoles()->pluck('name'),
                'available_schools' => $available_schools,
                'active_school' => $active_school,
                'available_offices' => $available_offices,
            ],
        ];
    }
}
