<?php

use App\Http\Controllers\Guardian\AdmissionStudentController;
use App\Http\Controllers\Guardian\GuardianController;
use App\Http\Controllers\Guardian\TransactionPaymentController;
use App\Http\Controllers\Office\Finance\Activity\AdmissionStudentController as FinanceActivityAdmissionStudentController;
use App\Http\Controllers\Office\Finance\FinanceController;
use App\Http\Controllers\Office\GA\Activity\AdmissionStudentController as GAActivityAdmissionStudentController;
use App\Http\Controllers\Office\GA\GAController;
use App\Http\Controllers\Office\HCM\HCMController;
use App\Http\Controllers\Office\ICC\Activity\AdmissionStudentController as ActivityAdmissionStudentController;
use App\Http\Controllers\Office\ICC\ICCController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStageController;
use App\Http\Controllers\Office\QRD\QRDController;
use App\Http\Controllers\Office\OfficeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\School\Activity\AdmissionStudentController as SchoolActivityAdmissionStudentController;
use App\Http\Controllers\School\SchoolController;
use App\Http\Controllers\School\StudentController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
// public routes
Route::get('/', function () {
    return Inertia::render('Public/Index', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});
// portal routes
Route::get('portal', function () {
    return Inertia::render('Portal/Index');
})->middleware(['auth', 'verified'])->name('portal');
// office routes
Route::middleware(['auth', 'verified'])
    ->prefix('office')
    ->name('office')
    ->group(function () {
        Route::get('/', [OfficeController::class, 'index']);
        // my profile routes
        // icc routes
        Route::prefix('icc')
            ->name('.icc')
            ->group(function () {
                Route::get('/', [ICCController::class, 'index']);
                // activity routes
                Route::prefix('activity/admission-student')
                    ->name('.activity.admissionStudent')
                    ->group(function () {
                        Route::get('/', [ActivityAdmissionStudentController::class, 'index']);
                        Route::get('{registration_number}/detail', [ActivityAdmissionStudentController::class, 'detail'])->name('.detail');
                        Route::post('update-verification', [ActivityAdmissionStudentController::class, 'updateVerification'])->name('.updateVerification');
                    });
                // management routes
                Route::prefix('management')
                    ->name('.management')
                    ->group(function () {
                        // admission stage routes
                        Route::prefix('admission-stage')
                            ->name('.admissionStage')
                            ->group(function () {
                                Route::get('/', [AdmissionStageController::class, 'index']);
                                Route::post('save', [AdmissionStageController::class, 'save'])->name('.save');
                            });
                    });
            });
        // hcm routes
        Route::prefix('hcm')
            ->name('.hcm')
            ->group(function () {
                Route::get('/', [HCMController::class, 'index']);
            });
        // ga routes
        Route::prefix('ga')
            ->name('.ga')
            ->group(function () {
                Route::get('/', [GAController::class, 'index']);
                // activity routes
                Route::prefix('activity/admission-student')
                    ->name('.activity.admissionStudent')
                    ->group(function () {
                        Route::get('/', [GAActivityAdmissionStudentController::class, 'index']);
                        Route::get('{registration_number}/detail', [GAActivityAdmissionStudentController::class, 'detail'])->name('.detail');
                    });
            });
        // qrd routes
        Route::prefix('qrd')
            ->name('.qrd')
            ->group(function () {
                Route::get('/', [QRDController::class, 'index']);
            });
        // finance routes
        Route::prefix('finance')
            ->name('.finance')
            ->group(function () {
                Route::get('/', [FinanceController::class, 'index']);
                // activity routes
                Route::prefix('activity/admission-student')
                    ->name('.activity.admissionStudent')
                    ->group(function () {
                        Route::get('/', [FinanceActivityAdmissionStudentController::class, 'index']);
                        Route::get('{registration_number}/detail', [FinanceActivityAdmissionStudentController::class, 'detail'])->name('.detail');
                    });
            });
    });
// school routes
Route::middleware(['auth', 'verified'])
    ->prefix('school')
    ->name('school')
    ->group(function () {
        Route::get('/', [SchoolController::class, 'index']);
        // student routes
        Route::prefix('student')
            ->name('.student')
            ->group(function () {
                Route::get('/', [StudentController::class, 'index']);
                Route::get('{school_national_id}/detail', [StudentController::class, 'detail'])->name('.detail');
            });
        // activity routes
        Route::prefix('activity/admission-student')
            ->name('.activity.admissionStudent')
            ->group(function () {
                Route::get('/', [SchoolActivityAdmissionStudentController::class, 'index']);
                Route::get('{registration_number}/detail', [SchoolActivityAdmissionStudentController::class, 'detail'])->name('.detail');
                Route::post('update-stage', [SchoolActivityAdmissionStudentController::class, 'updateStage'])->name('.updateStage');
                Route::post('update-status', [SchoolActivityAdmissionStudentController::class, 'updateStatus'])->name('.updateStatus');
            });
    });

// guardian routes
Route::middleware(['auth', 'verified'])
    ->prefix('guardian')
    ->name('guardian')
    ->group(function () {
        Route::get('/', [GuardianController::class, 'index']);
        // admission student routes
        Route::prefix('admission-student')
            ->name('.admissionStudent')
            ->group(function () {
                Route::get('/', [AdmissionStudentController::class, 'index']);
                Route::post('checkout', [AdmissionStudentController::class, 'checkout'])->name('.checkout');
                Route::get('option-school', [AdmissionStudentController::class, 'optionSchool'])->name('.optionSchool');
                Route::get('option-school-year', [AdmissionStudentController::class, 'optionSchoolYear'])->name('.optionSchoolYear');
                Route::get('get-student-quota', [AdmissionStudentController::class, 'getStudentQuota'])->name('.getStudentQuota');
                Route::get('{registration_number}/form', [AdmissionStudentController::class, 'form'])->name('.form');
                Route::get('{registration_number}/detail', [AdmissionStudentController::class, 'detail'])->name('.detail');
                Route::post('submit', [AdmissionStudentController::class, 'submit'])->name('.submit');
                Route::post('send', [AdmissionStudentController::class, 'send'])->name('.send');
                Route::post('set-schedule', [AdmissionStudentController::class, 'setSchedule'])->name('.setSchedule');
            });
        // transaction payment routes
        Route::prefix('transaction-payment')
            ->name('.transactionPayment')
            ->group(function () {
                Route::get('/', [TransactionPaymentController::class, 'index']);
                Route::post('process-payment', [TransactionPaymentController::class, 'processPayment'])->name('.processPayment');
            });
    });

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__ . '/auth.php';
