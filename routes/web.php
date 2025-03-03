<?php

use App\Http\Controllers\Guardian\AdmissionStudentController;
use App\Http\Controllers\Guardian\GuardianController;
use App\Http\Controllers\Guardian\TransactionPaymentController;
use App\Http\Controllers\Office\Finance\Activity\AdmissionStudentController as FinanceActivityAdmissionStudentController;
use App\Http\Controllers\Office\Finance\FinanceController;
use App\Http\Controllers\Office\GA\Activity\AdmissionStudentController as GAActivityAdmissionStudentController;
use App\Http\Controllers\Office\GA\GAController;
use App\Http\Controllers\Office\HCM\Employee\EmployeeController;
use App\Http\Controllers\Office\HCM\HCMController;
use App\Http\Controllers\Office\HCM\Placement\EmployeeController as PlacementEmployeeController;
use App\Http\Controllers\Office\HCM\Placement\PlacementController;
use App\Http\Controllers\Office\ICC\Activity\AdmissionStudentController as ActivityAdmissionStudentController;
use App\Http\Controllers\Office\ICC\ICCController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStageController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStudentPriceController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStudentQuotaController;
use App\Http\Controllers\Office\ICC\Management\SchoolYearController;
use App\Http\Controllers\Office\MyProfile\Submission\MaterialController;
use App\Http\Controllers\Office\QRD\QRDController;
use App\Http\Controllers\Office\OfficeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\School\Activity\AdmissionStudentController as SchoolActivityAdmissionStudentController;
use App\Http\Controllers\School\SchoolController;
use App\Http\Controllers\School\StudentController;
use App\Http\Controllers\School\Management\SchoolClassroomController;
use App\Http\Controllers\School\Management\SchoolClubController;
use App\Http\Controllers\School\Management\SchoolExtracurricularController;
use App\Http\Controllers\School\Management\SchoolSubjectController;
use App\Http\Controllers\School\Management\SchoolSubjectGroupController;
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
        Route::prefix('my-profile')
            ->name('.myProfile')
            ->group(function () {
                Route::get('/', [ICCController::class, 'index']);
                // submission routes
                Route::prefix('submission/material')
                    ->name('.submission.material')
                    ->group(function () {
                        Route::get('/', [MaterialController::class, 'index']);
                        Route::post('save', [MaterialController::class, 'save'])->name('.save');
                        Route::delete('delete', [MaterialController::class, 'delete'])->name('.delete');
                    });
            });
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
                        // school year routes
                        Route::prefix('school-year')
                            ->name('.schoolYear')
                            ->group(function () {
                                Route::get('/', [SchoolYearController::class, 'index']);
                                Route::post('save', [SchoolYearController::class, 'save'])->name('.save');
                                Route::delete('delete', [SchoolYearController::class, 'delete'])->name('.delete');
                            });
                        // admission stage routes
                        Route::prefix('admission-stage')
                            ->name('.admissionStage')
                            ->group(function () {
                                Route::get('/', [AdmissionStageController::class, 'index']);
                                Route::post('save', [AdmissionStageController::class, 'save'])->name('.save');
                            });
                        // admission student quota routes
                        Route::prefix('admission-student-quota')
                            ->name('.admissionStudentQuota')
                            ->group(function () {
                                Route::get('/', [AdmissionStudentQuotaController::class, 'index']);
                                Route::get('get-student-quota', [AdmissionStudentQuotaController::class, 'getStudentQuota'])->name('.getStudentQuota');
                                Route::post('save', [AdmissionStudentQuotaController::class, 'save'])->name('.save');
                            });
                        // admission student price routes
                        Route::prefix('admission-student-price')
                            ->name('.admissionStudentPrice')
                            ->group(function () {
                                Route::get('/', [AdmissionStudentPriceController::class, 'index']);
                                Route::post('save', [AdmissionStudentPriceController::class, 'save'])->name('.save');
                            });
                    });
            });
        // hcm routes
        Route::prefix('hcm')
            ->name('.hcm')
            ->group(function () {
                Route::get('/', [HCMController::class, 'index']);
                // employee routes
                Route::prefix('employee')
                    ->name('.employee')
                    ->group(function () {
                        Route::get('/', [EmployeeController::class, 'index']);
                        Route::post('store', [EmployeeController::class, 'store'])->name('.store');
                        Route::post('update', [EmployeeController::class, 'update'])->name('.update');
                        Route::post('reset-password', [EmployeeController::class, 'resetPassword'])->name('.resetPassword');
                        Route::delete('delete', [EmployeeController::class, 'delete'])->name('.delete');
                    });
                // placement routes
                Route::prefix('placement')
                    ->name('.placement')
                    ->group(function () {
                        Route::get('/', [PlacementController::class, 'index']);
                        // area routes
                        Route::prefix('{area_id}/area')
                            ->name('.area')
                            ->group(function () {
                                Route::get('/', [PlacementEmployeeController::class, 'index']);
                                Route::get('option-employee', [PlacementEmployeeController::class, 'optionEmployee'])->name('.optionEmployee');
                                Route::post('assign', [PlacementEmployeeController::class, 'assign'])->name('.assign');
                                Route::delete('remove', [PlacementEmployeeController::class, 'remove'])->name('.remove');
                            });
                    });
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
        Route::get('{active_school_id}/switch-active-school', [SchoolController::class, 'switchActiveSchool'])->name('.switchActiveSchool');
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
        // management routes
        Route::prefix('management')
            ->name('.management')
            ->group(function () {
                // school subject group routes
                Route::prefix('school-subject-group')
                    ->name('.schoolSubjectGroup')
                    ->group(function () {
                        Route::get('/', [SchoolSubjectGroupController::class, 'index']);
                        Route::post('save', [SchoolSubjectGroupController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolSubjectGroupController::class, 'delete'])->name('.delete');
                    });
                // school subject routes
                Route::prefix('school-subject')
                    ->name('.schoolSubject')
                    ->group(function () {
                        Route::get('/', [SchoolSubjectController::class, 'index']);
                        Route::get('option-school-subject-group', [SchoolSubjectController::class, 'optionSchoolSubjectGroup'])->name('.optionSchoolSubjectGroup');
                        Route::post('save', [SchoolSubjectController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolSubjectController::class, 'delete'])->name('.delete');
                    });
                // school classroom routes
                Route::prefix('school-classroom')
                    ->name('.schoolClassroom')
                    ->group(function () {
                        Route::get('/', [SchoolClassroomController::class, 'index']);
                        Route::get('{school_classroom_id}/detail', [SchoolClassroomController::class, 'detail'])->name('.detail');
                        Route::get('option-school-grade', [SchoolClassroomController::class, 'optionSchoolGrade'])->name('.optionSchoolGrade');
                        Route::get('option-school-major', [SchoolClassroomController::class, 'optionSchoolMajor'])->name('.optionSchoolMajor');
                        Route::get('option-homeroom-teacher', [SchoolClassroomController::class, 'optionHomeroomTeacher'])->name('.optionHomeroomTeacher');
                        Route::post('save', [SchoolClassroomController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolClassroomController::class, 'delete'])->name('.delete');
                        Route::get('option-member', [SchoolClassroomController::class, 'optionMember'])->name('.optionMember');
                        Route::post('assign-member', [SchoolClassroomController::class, 'assignMember'])->name('.assignMember');
                        Route::post('remove-member', [SchoolClassroomController::class, 'removeMember'])->name('.removeMember');
                    });
                // school extracurricular routes
                Route::prefix('school-extracurricular')
                    ->name('.schoolExtracurricular')
                    ->group(function () {
                        Route::get('/', [SchoolExtracurricularController::class, 'index']);
                        Route::get('{school_extracurricular_id}/detail', [SchoolExtracurricularController::class, 'detail'])->name('.detail');
                        Route::get('option-mentor', [SchoolExtracurricularController::class, 'optionMentor'])->name('.optionMentor');
                        Route::post('save', [SchoolExtracurricularController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolExtracurricularController::class, 'delete'])->name('.delete');
                        Route::get('option-member', [SchoolExtracurricularController::class, 'optionMember'])->name('.optionMember');
                        Route::post('assign-member', [SchoolExtracurricularController::class, 'assignMember'])->name('.assignMember');
                        Route::post('remove-member', [SchoolExtracurricularController::class, 'removeMember'])->name('.removeMember');
                    });
                // school club routes
                Route::prefix('school-club')
                    ->name('.schoolClub')
                    ->group(function () {
                        Route::get('/', [SchoolClubController::class, 'index']);
                        Route::get('{school_club_id}/detail', [SchoolClubController::class, 'detail'])->name('.detail');
                        Route::get('option-mentor', [SchoolSubjectController::class, 'optionMentor'])->name('.optionMentor');
                        Route::post('save', [SchoolClubController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolClubController::class, 'delete'])->name('.delete');
                        Route::get('option-member', [SchoolClubController::class, 'optionMember'])->name('.optionMember');
                        Route::post('assign-member', [SchoolClubController::class, 'assignMember'])->name('.assignMember');
                        Route::post('remove-member', [SchoolClubController::class, 'removeMember'])->name('.removeMember');
                    });
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
                Route::post('cancel-admission', [AdmissionStudentController::class, 'cancelAdmission'])->name('.cancelAdmission');
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
