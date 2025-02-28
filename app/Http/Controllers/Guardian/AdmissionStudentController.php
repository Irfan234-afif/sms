<?php

namespace App\Http\Controllers\Guardian;

use App\Http\Controllers\Controller;
use App\Http\Resources\AdmissionStudentQuotaResource;
use App\Http\Resources\AdmissionStudentResource;
use App\Http\Resources\ProductResource;
use App\Http\Resources\SchoolResource;
use App\Http\Resources\SchoolYearResource;
use App\Models\AdmissionStudent;
use App\Models\AdmissionStudentQuota;
use App\Models\AdmissionStudentStage;
use App\Models\Product;
use App\Models\School;
use App\Models\SchoolGrade;
use App\Models\SchoolYear;
use App\Services\AdmissionStudentService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class AdmissionStudentController extends Controller
{
    public function index()
    {
        $admission_students = AdmissionStudent::whereHas('transaction', function ($transaction) {
            $transaction->where('customer_id', Auth::user()->id);
        });

        if (request()->has('search')) {
            $admission_students->where('name', 'like', '%' . request('search') . '%')
                ->orWhere('registration_number', 'like', '%' . request('search') . '%')
                ->orWhereHas('transaction', function ($transaction) {
                    $transaction->where('reference_number', 'like', '%' . request('search') . '%');
                });
        }

        $admission_students = $admission_students->with('transaction')
            ->with('school.area')
            ->with('school_year')
            ->with('school_grade')
            ->latest()
            ->paginate(15);

        $product = Product::where('code', 'ADMISSION_STUDENT_FORM')->first();

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'product' => ProductResource::make($product),
            'admission_students' => AdmissionStudentResource::collection($admission_students),
        ];

        return Inertia::render('Guardian/AdmissionStudent/Index', $data);
    }

    public function checkout()
    {
        $admissionStudentService = new AdmissionStudentService();

        DB::beginTransaction();

        try {
            $processCheckout = $admissionStudentService->processCheckout(request()->all());

            DB::commit();

            return response()->json([
                'status' => 'success',
                'transaction_payment' => $processCheckout['transaction_payment'],
                'snap_token' => $processCheckout['snap_token'],
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function optionSchool()
    {
        $schools = School::query();

        if (request()->has('search')) {
            $schools->whereHas('area', function ($area) {
                $area->where('name', 'like', '%' . request('search') . '%');
            });
        }

        return response()->json(SchoolResource::collection($schools->with('area')->with('grades')->latest()->get()), 200);
    }

    public function optionSchoolYear()
    {
        $school_years = SchoolYear::where('is_active', true);

        if (request()->has('search')) {
            $school_years->where('name', 'like', '%' . request('search') . '%');
        }

        return response()->json(SchoolYearResource::collection($school_years->latest()->get()), 200);
    }

    public function getStudentQuota()
    {
        $school = School::where('uuid', request('school'))->firstOrFail();
        $school_year = SchoolYear::where('uuid', request('school_year'))->firstOrFail();
        $school_grade = SchoolGrade::where('uuid', request('school_grade'))->firstOrFail();

        $admission_student_quota = AdmissionStudentQuota::where([
            'school_id' => $school->id,
            'school_year_id' => $school_year->id,
            'school_grade_id' => $school_grade->id,
        ])->first();

        $admission_student_quota = $admission_student_quota ? AdmissionStudentQuotaResource::make($admission_student_quota) : null;

        return response()->json($admission_student_quota, 200);
    }

    public function form($registration_number)
    {
        $admission_student = AdmissionStudent::whereHas('transaction', function ($transaction) {
            $transaction->where('customer_id', Auth::user()->id);
        })->where('registration_number', $registration_number)
            ->with('school.area')
            ->with('school_year')
            ->with('school_grade')
            ->firstOrFail();

        $data = [
            'admission_student' => AdmissionStudentResource::make($admission_student),
        ];

        return Inertia::render('Guardian/AdmissionStudent/Form', $data);
    }

    public function detail($registration_number)
    {
        $admission_student = AdmissionStudent::whereHas('transaction', function ($transaction) {
            $transaction->where('customer_id', Auth::user()->id);
        })->where('registration_number', $registration_number)
            ->with('school.area')
            ->with('school_year')
            ->with('school_grade')
            ->with('stages.admission_stage.statuses')
            ->with('stages.status')
            ->firstOrFail();

        $data = [
            'admission_student' => AdmissionStudentResource::make($admission_student),
        ];

        return Inertia::render('Guardian/AdmissionStudent/Detail', $data);
    }

    public function submit()
    {
        $data = json_decode(request('full_form_data'), true);
        $data['status'] = 'DRAFT';

        DB::beginTransaction();

        try {
            $admission_student = AdmissionStudent::where('uuid', $data['admission_student_id'])->first();

            if (!$admission_student) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Pendaftaran siswa tidak ditemukan.'
                ], 404);
            }

            if (request()->hasFile('avatar_file')) {
                $file = request()->file('avatar_file');

                $filename = 'avatar' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('avatars', $filename, 'public');

                if ($admission_student->avatar) {
                    Storage::disk('public')->delete('avatars/' . $admission_student->avatar);
                }

                $data['avatar'] = $filename;
            }

            if (request()->hasFile('father_avatar_file')) {
                $file = request()->file('father_avatar_file');

                $filename = 'avatar' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('avatars', $filename, 'public');

                if ($admission_student->father_avatar) {
                    Storage::disk('public')->delete('avatars/' . $admission_student->father_avatar);
                }

                $data['father_avatar'] = $filename;
            }

            if (request()->hasFile('mother_avatar_file')) {
                $file = request()->file('mother_avatar_file');

                $filename = 'avatar' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('avatars', $filename, 'public');

                if ($admission_student->mother_avatar) {
                    Storage::disk('public')->delete('avatars/' . $admission_student->mother_avatar);
                }

                $data['mother_avatar'] = $filename;
            }

            if (request()->hasFile('family_card_file') && $data['family_card_attachment'] == null) {
                $file = request()->file('family_card_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->family_card_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->family_card_file);
                }

                $data['family_card_attachment'] = $filename;
            }
            if (request()->hasFile('father_id_card_file') && $data['father_id_card_attachment'] == null) {
                $file = request()->file('father_id_card_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->father_id_card_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->father_id_card_file);
                }

                $data['father_id_card_attachment'] = $filename;
            }
            if (request()->hasFile('mother_id_card_file') && $data['mother_id_card_attachment'] == null) {
                $file = request()->file('mother_id_card_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->mother_id_card_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->mother_id_card_file);
                }

                $data['mother_id_card_attachment'] = $filename;
            }
            if (request()->hasFile('birth_certificate_file') && $data['birth_certificate_attachment'] == null) {
                $file = request()->file('birth_certificate_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->birth_certificate_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->birth_certificate_file);
                }

                $data['birth_certificate_attachment'] = $filename;
            }
            if (request()->hasFile('last_report_file') && $data['last_report_attachment'] == null) {
                $file = request()->file('last_report_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->last_report_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->last_report_file);
                }

                $data['last_report_attachment'] = $filename;
            }
            if (request()->hasFile('previous_school_letter_file') && $data['previous_school_letter_attachment'] == null) {
                $file = request()->file('previous_school_letter_file');

                $filename = 'attachment' . time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();

                $file->storeAs('attachments', $filename, 'public');

                if ($admission_student->previous_school_letter_file) {
                    Storage::disk('public')->delete('attachments/' . $admission_student->previous_school_letter_file);
                }

                $data['previous_school_letter_attachment'] = $filename;
            }

            $admission_student->update($data);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Terima kasih! Pendaftaran Anda telah berhasil disimpan.'
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function send()
    {
        DB::beginTransaction();

        try {
            $admission_student = AdmissionStudent::where('registration_number', request('registration_number'))->firstOrFail();

            $admission_student->update(['status' => 'PENDING']);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Formulir berhasil dikirim',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function setSchedule()
    {
        DB::beginTransaction();

        try {
            $admission_student_stage = AdmissionStudentStage::where('uuid', request('admission_student_stage'))->firstOrFail();

            $admission_student_stage->update(['scheduled_at' => request('scheduled_at')]);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Jadwal telah diatur',
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
