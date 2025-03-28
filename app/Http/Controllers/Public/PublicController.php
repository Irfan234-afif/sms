<?php

namespace App\Http\Controllers\Public;

use App\Http\Controllers\Controller;
use App\Http\Resources\AchievementResource;
use App\Http\Resources\BannerResource;
use App\Http\Resources\CareerResource;
use App\Http\Resources\EventResource;
use App\Http\Resources\FaqResource;
use App\Http\Resources\GalleryResource;
use App\Http\Resources\PageResource;
use App\Http\Resources\PostResource;
use App\Http\Resources\TestimonialResource;
use App\Models\Achievement;
use App\Models\Banner;
use App\Models\Career;
use App\Models\Event;
use App\Models\Faq;
use App\Models\Gallery;
use App\Models\OperationalHour;
use App\Models\Page;
use App\Models\Post;
use App\Models\PublicFeedback;
use App\Models\Testimonial;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

class PublicController extends Controller
{
    public function index()
    {
        $events = Event::latest()->take(3)->get();

        $banners = Banner::latest()->take(20)->get();

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
            'banners' => BannerResource::collection($banners),
            'events' => EventResource::collection($events),
            'news' => PostResource::collection($news),
            'parent_testimonials' => TestimonialResource::collection($testimonials->get('PARENT', collect())->take(3)),
            'student_testimonials' => TestimonialResource::collection($testimonials->get('STUDENT', collect())->take(3)),
            'teacher_testimonials' => TestimonialResource::collection($testimonials->get('TEACHER', collect())->take(3)),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function history()
    {
        $page = Page::where('type', 'HISTORY')->firstOrFail();

        return Inertia::render('Public/History/Index', [
            'page' => PageResource::make($page),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function visionMission()
    {
        $page = Page::where('type', 'VISION_MISSION')->firstOrFail();

        return Inertia::render('Public/VisionMission/Index', [
            'page' => PageResource::make($page),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
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
        ]);
    }


    public function admissionInformation()
    {
        $admission_informations = Post::where('type', 'ADMISSION_INFORMATION')
            ->latest()
            ->take(12)
            ->get();

        return Inertia::render('Public/AdmissionInformation/Index', [
            'admission_informations' => PostResource::collection($admission_informations),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function admissionInformationDetail($slug)
    {
        $admission_information = Post::where('slug', $slug)
            ->firstOrFail();

        return Inertia::render('Public/AdmissionInformation/Detail', [
            'admission_information' => PostResource::make($admission_information),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function news()
    {
        $news = Post::where('type', 'NEWS')
            ->with(['author', 'category'])
            ->limit(100)
            ->latest()
            ->paginate(9);

        return Inertia::render('Public/News/Index', [
            'news' => PostResource::collection($news),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function newsDetail($slug)
    {
        $news = Post::where('slug', $slug)
            ->with(['author', 'category'])
            ->firstOrFail();

        $more_news = Post::where('type', 'NEWS')
            ->whereNotIn('id', [$news->id])
            ->with(['author', 'category'])
            ->take(4)
            ->latest()
            ->get();

        return Inertia::render('Public/News/Detail', [
            'news' => PostResource::make($news),
            'more_news' => PostResource::collection($more_news),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function article()
    {
        $articles = Post::where('type', 'ARTICLE')
            ->with(['author', 'category'])
            ->limit(100)
            ->latest()
            ->paginate(9);

        return Inertia::render('Public/Article/Index', [
            'articles' => PostResource::collection($articles),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function articleDetail($slug)
    {
        $article = Post::where('slug', $slug)
            ->with(['author', 'category'])
            ->firstOrFail();

        $more_articles = Post::where('type', 'ARTICLE')
            ->whereNotIn('id', [$article->id])
            ->with(['author', 'category'])
            ->take(4)
            ->latest()
            ->get();

        return Inertia::render('Public/Article/Detail', [
            'article' => PostResource::make($article),
            'more_articles' => PostResource::collection($more_articles),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function gallery()
    {
        $galleries = Gallery::whereHas('items', function ($items) {
            $items->where('is_thumbnail', true);
        })->with('items')
            ->take(15)
            ->latest()
            ->get();

        return Inertia::render('Public/Gallery/Index', [
            'galleries' => GalleryResource::collection($galleries),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function event()
    {
        $events = Event::limit(100)
            ->latest()
            ->paginate(9);

        return Inertia::render('Public/Event/Index', [
            'events' => EventResource::collection($events),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function eventDetail($event_id)
    {
        $event = Event::where('uuid', $event_id)
            ->firstOrFail();

        $more_events = Event::take(4)
            ->latest()
            ->get();

        return Inertia::render('Public/Event/Detail', [
            'event' => EventResource::make($event),
            'more_events' => EventResource::collection($more_events),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function teacherAchievement()
    {
        $achievements = Achievement::where('category', 'TEACHER')
            ->limit(100)
            ->latest()
            ->paginate(20);

        return Inertia::render('Public/TeacherAchievement/Index', [
            'achievements' => AchievementResource::collection($achievements),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function studentAchievement()
    {
        $achievements = Achievement::where('category', 'STUDENT')
            ->limit(100)
            ->latest()
            ->paginate(20);

        return Inertia::render('Public/StudentAchievement/Index', [
            'achievements' => AchievementResource::collection($achievements),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function publicFeedback()
    {
        return Inertia::render('Public/PublicFeedback/Index', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function savePublicFeedback()
    {
        DB::beginTransaction();

        try {
            PublicFeedback::create([
                'name' => request('name'),
                'email' => request('email'),
                'phone' => request('phone'),
                'subject' => request('subject'),
                'message' => request('message'),
            ]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Masukan Saran berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function career()
    {
        $careers = Career::limit(100)
            ->latest()
            ->paginate(20);

        return Inertia::render('Public/Career/Index', [
            'careers' => CareerResource::collection($careers),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function faq()
    {
        $faqs = Faq::latest()
            ->paginate(12);

        return Inertia::render('Public/Faq/Index', [
            'faqs' => FaqResource::collection($faqs),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }
}
