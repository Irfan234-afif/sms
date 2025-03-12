<?php

namespace App\Http\Controllers\Public;

use App\Http\Controllers\Controller;
use App\Http\Resources\EventResource;
use App\Http\Resources\PageResource;
use App\Http\Resources\PostResource;
use App\Http\Resources\TestimonialResource;
use App\Models\Event;
use App\Models\OperationalHour;
use App\Models\Page;
use App\Models\Post;
use App\Models\Testimonial;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

class PublicController extends Controller
{
    public function index()
    {
        $events = Event::latest()->take(3)->get();

        $news = Post::where('type', 'NEWS')
            ->with(['author', 'category'])
            ->latest()
            ->take(3)
            ->get();

        $testimonials = Testimonial::whereIn('type', ['PARENT', 'STUDENT', 'TEACHER'])
            ->latest()
            ->get()
            ->groupBy('type');

        return Inertia::render('Public/Index', [
            'events' => EventResource::collection($events),
            'news' => PostResource::collection($news),
            'parent_testimonials' => TestimonialResource::collection($testimonials->get('PARENT', collect())->take(3)),
            'student_testimonials' => TestimonialResource::collection($testimonials->get('STUDENT', collect())->take(3)),
            'teacher_testimonials' => TestimonialResource::collection($testimonials->get('TEACHER', collect())->take(3)),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function history()
    {
        $page = Page::where('type', 'HISTORY')->firstOrFail();

        return Inertia::render('Public/History/Index', [
            'page' => PageResource::make($page),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function visionMission()
    {
        $page = Page::where('type', 'VISION_MISSION')->firstOrFail();

        return Inertia::render('Public/VisionMission/Index', [
            'page' => PageResource::make($page),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function operationalHour()
    {
        $dayOrder = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];

        $operational_hours = OperationalHour::with('area')
            ->get()
            ->groupBy('day')
            ->sortBy(function ($_, $key) use ($dayOrder) {
                return array_search($key, $dayOrder);
            });


        return Inertia::render('Public/OperationalHour/Index', [
            'operational_hours' => $operational_hours,
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }


    public function admissionInformation()
    {
        return Inertia::render('Public/AdmissionInformation/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function news()
    {
        return Inertia::render('Public/News/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function article()
    {
        return Inertia::render('Public/Article/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function gallery()
    {
        return Inertia::render('Public/Gallery/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function event()
    {
        return Inertia::render('Public/Event/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function teacherAchievement()
    {
        return Inertia::render('Public/TeacherAchievement/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function studentAchievement()
    {
        return Inertia::render('Public/StudentAchievement/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function publicFeedback()
    {
        return Inertia::render('Public/PublicFeedback/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function career()
    {
        return Inertia::render('Public/Career/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }

    public function faq()
    {
        return Inertia::render('Public/Faq/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
        ]);
    }
}
