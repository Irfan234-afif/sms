<?php

namespace App\Http\Middleware;

use App\Models\Employee;
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
        $user = User::where('uuid', $request->user()?->uuid)
            ->with('profile')
            ->first();

        $available_schools = collect();
        $active_school = null;

        if ($request->user()) {
            if (Str::startsWith($request->path(), 'school')) {
                $available_schools = Employee::getSchools() ?? collect();
            }

            if ($available_schools->isNotEmpty()) {
                $active_school = Session::get('active_school');

                if (!$active_school) {
                    $active_school = $available_schools->first();
                    Session::put('active_school', $active_school);
                }
            }
        }

        return [
            ...parent::share($request),
            'auth' => [
                'user' => $user,
                'available_schools' => $available_schools,
                'active_school' => $active_school,
            ],
        ];
    }
}
