<?php

use App\Http\Controllers\Ajax\ApprovalController;
use App\Http\Controllers\Ajax\ChatController;
use App\Http\Controllers\Ajax\OptionController;
use App\Http\Controllers\Guardian\AdmissionStudentController;
use App\Http\Controllers\Guardian\GuardianController;
use App\Http\Controllers\Guardian\TransactionPaymentController;
use App\Http\Controllers\Office\Finance\Activity\AdmissionStudentController as FinanceActivityAdmissionStudentController;
use App\Http\Controllers\Office\Finance\FinanceController;
use App\Http\Controllers\Office\GA\Activity\AdmissionStudentController as GAActivityAdmissionStudentController;
use App\Http\Controllers\Office\GA\Approval\EquipmentController as ApprovalEquipmentController;
use App\Http\Controllers\Office\GA\Approval\EventController as ApprovalEventController;
use App\Http\Controllers\Office\GA\Approval\InstallRepairController as ApprovalInstallRepairController;
use App\Http\Controllers\Office\GA\Approval\MaterialController as ApprovalMaterialController;
use App\Http\Controllers\Office\GA\Approval\VehicleController as ApprovalVehicleController;
use App\Http\Controllers\Office\GA\GAController;
use App\Http\Controllers\Office\GA\Setting\SubmissionApproverController;
use App\Http\Controllers\Office\HCM\Approval\AttendanceController as ApprovalAttendanceController;
use App\Http\Controllers\Office\HCM\Approval\LeaveController as ApprovalLeaveController;
use App\Http\Controllers\Office\HCM\Approval\OutstationController as ApprovalOutstationController;
use App\Http\Controllers\Office\HCM\Approval\ResignationController as ApprovalResignationController;
use App\Http\Controllers\Office\HCM\Employee\EmployeeController;
use App\Http\Controllers\Office\HCM\HCMController;
use App\Http\Controllers\Office\HCM\Placement\EmployeeController as PlacementEmployeeController;
use App\Http\Controllers\Office\HCM\Placement\PlacementController;
use App\Http\Controllers\Office\HCM\Setting\SubmissionApproverController as SettingSubmissionApproverController;
use App\Http\Controllers\Office\ICC\Activity\AdmissionStudentController as ActivityAdmissionStudentController;
use App\Http\Controllers\Office\ICC\Approval\BroadcastController as ApprovalBroadcastController;
use App\Http\Controllers\Office\ICC\Approval\CardController as ApprovalCardController;
use App\Http\Controllers\Office\ICC\Approval\DesignController as ApprovalDesignController;
use App\Http\Controllers\Office\ICC\Approval\DocumentationController as ApprovalDocumentationController;
use App\Http\Controllers\Office\ICC\Approval\MediaPostController as ApprovalMediaPostController;
use App\Http\Controllers\Office\ICC\ICCController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStageController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStudentDiscountController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStudentPriceController;
use App\Http\Controllers\Office\ICC\Management\AdmissionStudentQuotaController;
use App\Http\Controllers\Office\ICC\Management\SchoolYearController;
use App\Http\Controllers\Office\ICC\Publication\AchievementController;
use App\Http\Controllers\Office\ICC\Publication\AdmissionInformationController;
use App\Http\Controllers\Office\ICC\Publication\ArticleController;
use App\Http\Controllers\Office\ICC\Publication\BannerController;
use App\Http\Controllers\Office\ICC\Publication\CareerController;
use App\Http\Controllers\Office\ICC\Publication\EventController;
use App\Http\Controllers\Office\ICC\Publication\FaqController;
use App\Http\Controllers\Office\ICC\Publication\GalleryController;
use App\Http\Controllers\Office\ICC\Publication\NewsController;
use App\Http\Controllers\Office\ICC\Publication\OperationalAreaController;
use App\Http\Controllers\Office\ICC\Publication\OperationalHourController;
use App\Http\Controllers\Office\ICC\Publication\PageController;
use App\Http\Controllers\Office\ICC\Publication\PostCategoryController;
use App\Http\Controllers\Office\ICC\Publication\PublicFeedbackController;
use App\Http\Controllers\Office\ICC\Publication\TestimonialController;
use App\Http\Controllers\Office\ICC\Setting\SubmissionApproverController as ICCSettingSubmissionApproverController;
use App\Http\Controllers\Office\MyProfile\Approval\AttendanceController as MyProfileApprovalAttendanceController;
use App\Http\Controllers\Office\MyProfile\Approval\BroadcastController as MyProfileApprovalBroadcastController;
use App\Http\Controllers\Office\MyProfile\Approval\CardController as MyProfileApprovalCardController;
use App\Http\Controllers\Office\MyProfile\Approval\DesignController as MyProfileApprovalDesignController;
use App\Http\Controllers\Office\MyProfile\Approval\DocumentationController as MyProfileApprovalDocumentationController;
use App\Http\Controllers\Office\MyProfile\Approval\EquipmentController as MyProfileApprovalEquipmentController;
use App\Http\Controllers\Office\MyProfile\Approval\EventController as MyProfileApprovalEventController;
use App\Http\Controllers\Office\MyProfile\Approval\InstallRepairController as MyProfileApprovalInstallRepairController;
use App\Http\Controllers\Office\MyProfile\Approval\LeaveController as MyProfileApprovalLeaveController;
use App\Http\Controllers\Office\MyProfile\Approval\MaterialController as MyProfileApprovalMaterialController;
use App\Http\Controllers\Office\MyProfile\Approval\MediaPostController as MyProfileApprovalMediaPostController;
use App\Http\Controllers\Office\MyProfile\Approval\OutstationController as MyProfileApprovalOutstationController;
use App\Http\Controllers\Office\MyProfile\Approval\ResignationController as MyProfileApprovalResignationController;
use App\Http\Controllers\Office\MyProfile\Approval\VehicleController as MyProfileApprovalVehicleController;
use App\Http\Controllers\Office\MyProfile\Qualitification\AcademicController;
use App\Http\Controllers\Office\MyProfile\Qualitification\AttachmentController;
use App\Http\Controllers\Office\MyProfile\Qualitification\CertificationController;
use App\Http\Controllers\Office\MyProfile\Qualitification\CommunityInvolvementController;
use App\Http\Controllers\Office\MyProfile\Qualitification\ExperienceController;
use App\Http\Controllers\Office\MyProfile\Qualitification\FamilyController;
use App\Http\Controllers\Office\MyProfile\Qualitification\HonorPrizeController;
use App\Http\Controllers\Office\MyProfile\Qualitification\LanguageSkillController;
use App\Http\Controllers\Office\MyProfile\Qualitification\SpecializationController;
use App\Http\Controllers\Office\MyProfile\Qualitification\TrainingController;
use App\Http\Controllers\Office\MyProfile\Submission\AttendanceController;
use App\Http\Controllers\Office\MyProfile\Submission\BroadcastController;
use App\Http\Controllers\Office\MyProfile\Submission\CardController;
use App\Http\Controllers\Office\MyProfile\Submission\DesignController;
use App\Http\Controllers\Office\MyProfile\Submission\DocumentationController;
use App\Http\Controllers\Office\MyProfile\Submission\EquipmentController;
use App\Http\Controllers\Office\MyProfile\Submission\EventController as SubmissionEventController;
use App\Http\Controllers\Office\MyProfile\Submission\InstallRepairController;
use App\Http\Controllers\Office\MyProfile\Submission\LeaveController;
use App\Http\Controllers\Office\MyProfile\Submission\MaterialController;
use App\Http\Controllers\Office\MyProfile\Submission\MediaPostController;
use App\Http\Controllers\Office\MyProfile\Submission\OutstationController;
use App\Http\Controllers\Office\MyProfile\Submission\ResignationController;
use App\Http\Controllers\Office\MyProfile\Submission\TrainingController as SubmissionTrainingController;
use App\Http\Controllers\Office\MyProfile\Submission\VehicleController;
use App\Http\Controllers\Office\QRD\QRDController;
use App\Http\Controllers\Office\OfficeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Public\PublicController;
use App\Http\Controllers\School\Activity\AdmissionStudentController as SchoolActivityAdmissionStudentController;
use App\Http\Controllers\School\LearningActivity\Entity\AssessmentSessionController;
use App\Http\Controllers\School\LearningActivity\Entity\AssessmentSubjectController;
use App\Http\Controllers\School\LearningActivity\SchoolClassroomController as LearningActivitySchoolClassroomController;
use App\Http\Controllers\School\Management\Entity\LearningObjectiveCategoryController;
use App\Http\Controllers\School\Management\Entity\LearningRubricController;
use App\Http\Controllers\School\SchoolController;
use App\Http\Controllers\School\StudentController;
use App\Http\Controllers\School\Management\SchoolClassroomController;
use App\Http\Controllers\School\Management\SchoolClubController;
use App\Http\Controllers\School\Management\SchoolCurriculumController;
use App\Http\Controllers\School\Management\SchoolExtracurricularController;
use App\Http\Controllers\School\Management\SchoolMajorController;
use App\Http\Controllers\School\Management\SchoolSubjectController;
use App\Http\Controllers\School\Management\SchoolSubjectGroupController;
use App\Http\Controllers\School\Setting\Entity\SchoolAcademicProgramController;
use App\Http\Controllers\School\Setting\SchoolController as SettingSchoolController;
use App\Http\Controllers\School\TeachingProgram\AssessmentModuleController;
use App\Http\Controllers\School\TeachingProgram\Entity\AssessmentAspectController;
use App\Http\Controllers\School\TeachingProgram\Entity\AssessmentFinalRuleController;
use App\Http\Controllers\School\TeachingProgram\Entity\AssessmentRubricController;
use App\Http\Controllers\School\TeachingProgram\LearningObjectiveController;
use App\Http\Controllers\School\TeachingProgram\SubjectThresholdController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

//report
Route::prefix('/hhk')->group(function () {
    Route::get('laporan-mingguan', function () {
        return view('report.hhk.weekly_report');
    });
    Route::get('laporan-identitas', function () {
        return view('report.hhk.identity_report');
    });
    Route::get('laporan-lapd', function () {
        return view('report.hhk.lapd_report');
    });
});

Route::prefix('/sd')->group(function () {
    Route::get('weekly-time', function () {
        return view('report.sd.weekly_time');
    });

    Route::get('mid-semester', function () {
        return view('report.sd.mid-semester_report');
    });

    Route::get('rapor-nasional', function () {
        return view('report.sd.national-report-card');
    });

    Route::get('rapor-sekolah', function () {
        return view('report.sd.school-report_card');
    });

    Route::get('laporan-p5', function () {
        return view('report.sd.p5-report_card');
    });
});

Route::prefix('/sma')->group(function () {
    Route::get('mid-semester', function () {
        return view('report.sma.mid-semester_report');
    });

    Route::get('rapor-nasional', function () {
        return view('report.sma.national-report_report');
    });

    Route::get('mid-semester-core', function () {
        return view('report.sma.Mid-Semester-Core_report');
    });

    Route::get('laporan-prestasi', function () {
        return view('report.sma.achievements_report');
    });
});

// academic-tr-report
Route::prefix('/smp')->group(function () {
    Route::get('transkrip-akademik', function () {
        return view('report.smp.academic-tr-report');
    });

    Route::get('rapor-nasional', function () {
        return view('report.smp.national-report');
    });

    Route::get('laporan-p5', function () {
        return view('report.smp.p5-report');
    });

    Route::get('laporan-prestasi', function () {
        return view('report.smp.achievements_report');
    });

    Route::get('subject-transkrip', function () {
        return view('report.smp.subject-tr');
    });
});

// public routes
Route::prefix('/')->group(function () {
    Route::get('/', [PublicController::class, 'index']);
    Route::get('history', [PublicController::class, 'history'])->name('history');
    Route::get('vision-mission', [PublicController::class, 'visionMission'])->name('visionMission');
    Route::get('operational-hour', [PublicController::class, 'operationalHour'])->name('operationalHour');
    Route::get('admission-information', [PublicController::class, 'admissionInformation'])->name('admissionInformation');
    Route::get('{slug}/admission-information', [PublicController::class, 'admissionInformationDetail'])->name('admissionInformation.detail');
    Route::get('news', [PublicController::class, 'news'])->name('news');
    Route::get('{slug}/news', [PublicController::class, 'newsDetail'])->name('news.detail');
    Route::get('article', [PublicController::class, 'article'])->name('article');
    Route::get('{slug}/article', [PublicController::class, 'articleDetail'])->name('article.detail');
    Route::get('gallery', [PublicController::class, 'gallery'])->name('gallery');
    Route::get('event', [PublicController::class, 'event'])->name('event');
    Route::get('{event_id}/event', [PublicController::class, 'eventDetail'])->name('event.detail');
    Route::get('teacher-achievement', [PublicController::class, 'teacherAchievement'])->name('teacherAchievement');
    Route::get('student-achievement', [PublicController::class, 'studentAchievement'])->name('studentAchievement');
    Route::get('public-feedback', [PublicController::class, 'publicFeedback'])->name('publicFeedback');
    Route::post('save-public-feedback', [PublicController::class, 'savePublicFeedback'])->name('savePublicFeedback');
    Route::get('career', [PublicController::class, 'career'])->name('career');
    Route::get('faq', [PublicController::class, 'faq'])->name('faq');
});
// portal routes
Route::get('portal', function () {
    return Inertia::render('Portal/Index');
})->middleware(['auth', 'verified'])->name('portal');
// office routes
Route::middleware(['auth', 'verified', 'role:System Admin|Site Admin|Employee'])
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
                Route::prefix('submission')
                    ->name('.submission')
                    ->group(function () {
                        // material area routes
                        Route::prefix('material')
                            ->name('.material')
                            ->group(function () {
                                Route::get('/', [MaterialController::class, 'index']);
                                Route::post('store', [MaterialController::class, 'store'])->name('.store');
                                Route::post('update', [MaterialController::class, 'update'])->name('.update');
                                Route::delete('delete', [MaterialController::class, 'delete'])->name('.delete');
                            });

                        // install & repair routes
                        Route::prefix('install-repair')
                            ->name('.installRepair')
                            ->group(function () {
                                Route::get('/', [InstallRepairController::class, 'index']);
                                Route::get('option-assigned', [InstallRepairController::class, 'optionAssigned'])->name('.optionAssigned');
                                Route::post('store', [InstallRepairController::class, 'store'])->name('.store');
                                Route::post('update', [InstallRepairController::class, 'update'])->name('.update');
                                Route::delete('delete', [InstallRepairController::class, 'delete'])->name('.delete');
                            });

                        // design routes
                        Route::prefix('design')
                            ->name('.design')
                            ->group(function () {
                                Route::get('/', [DesignController::class, 'index']);
                                Route::post('store', [DesignController::class, 'store'])->name('.store');
                                Route::post('update', [DesignController::class, 'update'])->name('.update');
                                Route::delete('delete', [DesignController::class, 'delete'])->name('.delete');
                            });

                        // documentation routes
                        Route::prefix('documentation')
                            ->name('.documentation')
                            ->group(function () {
                                Route::get('/', [DocumentationController::class, 'index']);
                                Route::post('store', [DocumentationController::class, 'store'])->name('.store');
                                Route::post('update', [DocumentationController::class, 'update'])->name('.update');
                                Route::delete('delete', [DocumentationController::class, 'delete'])->name('.delete');
                            });

                        // broadcast routes
                        Route::prefix('broadcast')
                            ->name('.broadcast')
                            ->group(function () {
                                Route::get('/', [BroadcastController::class, 'index']);
                                Route::post('store', [BroadcastController::class, 'store'])->name('.store');
                                Route::post('update', [BroadcastController::class, 'update'])->name('.update');
                                Route::delete('delete', [BroadcastController::class, 'delete'])->name('.delete');
                            });

                        // media post routes
                        Route::prefix('media-post')
                            ->name('.mediaPost')
                            ->group(function () {
                                Route::get('/', [MediaPostController::class, 'index']);
                                Route::post('store', [MediaPostController::class, 'store'])->name('.store');
                                Route::post('update', [MediaPostController::class, 'update'])->name('.update');
                                Route::delete('delete', [MediaPostController::class, 'delete'])->name('.delete');
                            });

                        // card routes
                        Route::prefix('card')
                            ->name('.card')
                            ->group(function () {
                                Route::get('/', [CardController::class, 'index']);
                                Route::post('store', [CardController::class, 'store'])->name('.store');
                                Route::post('update', [CardController::class, 'update'])->name('.update');
                                Route::delete('delete', [CardController::class, 'delete'])->name('.delete');
                            });

                        // vehicle routes
                        Route::prefix('vehicle')
                            ->name('.vehicle')
                            ->group(function () {
                                Route::get('/', [VehicleController::class, 'index']);
                                Route::post('store', [VehicleController::class, 'store'])->name('.store');
                                Route::post('update', [VehicleController::class, 'update'])->name('.update');
                                Route::delete('delete', [VehicleController::class, 'delete'])->name('.delete');
                            });

                        // event routes
                        Route::prefix('event')
                            ->name('.event')
                            ->group(function () {
                                Route::get('/', [SubmissionEventController::class, 'index']);
                                Route::post('store', [SubmissionEventController::class, 'store'])->name('.store');
                                Route::post('update', [SubmissionEventController::class, 'update'])->name('.update');
                                Route::delete('delete', [SubmissionEventController::class, 'delete'])->name('.delete');
                            });

                        // attendance routes
                        Route::prefix('attendance')
                            ->name('.attendance')
                            ->group(function () {
                                Route::get('/', [AttendanceController::class, 'index']);
                                Route::post('store', [AttendanceController::class, 'store'])->name('.store');
                                Route::post('update', [AttendanceController::class, 'update'])->name('.update');
                                Route::delete('delete', [AttendanceController::class, 'delete'])->name('.delete');
                            });

                        // equipment routes
                        Route::prefix('equipment')
                            ->name('.equipment')
                            ->group(function () {
                                Route::get('/', [EquipmentController::class, 'index']);
                                Route::post('store', [EquipmentController::class, 'store'])->name('.store');
                                Route::post('update', [EquipmentController::class, 'update'])->name('.update');
                                Route::delete('delete', [EquipmentController::class, 'delete'])->name('.delete');
                            });

                        // outstation routes
                        Route::prefix('outstation')
                            ->name('.outstation')
                            ->group(function () {
                                Route::get('/', [OutstationController::class, 'index']);
                                Route::post('store', [OutstationController::class, 'store'])->name('.store');
                                Route::post('update', [OutstationController::class, 'update'])->name('.update');
                                Route::delete('delete', [OutstationController::class, 'delete'])->name('.delete');
                            });

                        // leave routes
                        Route::prefix('leave')
                            ->name('.leave')
                            ->group(function () {
                                Route::get('/', [LeaveController::class, 'index']);
                                Route::post('store', [LeaveController::class, 'store'])->name('.store');
                                Route::post('update', [LeaveController::class, 'update'])->name('.update');
                                Route::delete('delete', [LeaveController::class, 'delete'])->name('.delete');
                            });

                        // training routes
                        Route::prefix('training')
                            ->name('.training')
                            ->group(function () {
                                Route::get('/', [SubmissionTrainingController::class, 'index']);
                                Route::post('store', [SubmissionTrainingController::class, 'store'])->name('.store');
                                Route::post('update', [SubmissionTrainingController::class, 'update'])->name('.update');
                                Route::delete('delete', [SubmissionTrainingController::class, 'delete'])->name('.delete');
                            });

                        // resignation routes
                        Route::prefix('resignation')
                            ->name('.resignation')
                            ->group(function () {
                                Route::get('/', [ResignationController::class, 'index']);
                                Route::post('store', [ResignationController::class, 'store'])->name('.store');
                                Route::post('update', [ResignationController::class, 'update'])->name('.update');
                                Route::delete('delete', [ResignationController::class, 'delete'])->name('.delete');
                            });
                    });
                // approval routes
                Route::prefix('approval')
                    ->name('.approval')
                    ->group(function () {
                        // material area routes
                        Route::prefix('material')
                            ->name('.material')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalMaterialController::class, 'index']);
                                Route::get('export', [MyProfileApprovalMaterialController::class, 'export'])->name('.export');
                                Route::post('store', [MyProfileApprovalMaterialController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalMaterialController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalMaterialController::class, 'delete'])->name('.delete');
                            });

                        // install & repair routes
                        Route::prefix('install-repair')
                            ->name('.installRepair')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalInstallRepairController::class, 'index']);
                                Route::get('option-assigned', [MyProfileApprovalInstallRepairController::class, 'optionAssigned'])->name('.optionAssigned');
                                Route::post('store', [MyProfileApprovalInstallRepairController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalInstallRepairController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalInstallRepairController::class, 'delete'])->name('.delete');
                            });

                        // design routes
                        Route::prefix('design')
                            ->name('.design')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalDesignController::class, 'index']);
                                Route::post('store', [MyProfileApprovalDesignController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalDesignController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalDesignController::class, 'delete'])->name('.delete');
                            });

                        // documentation routes
                        Route::prefix('documentation')
                            ->name('.documentation')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalDocumentationController::class, 'index']);
                                Route::post('store', [MyProfileApprovalDocumentationController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalDocumentationController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalDocumentationController::class, 'delete'])->name('.delete');
                            });

                        // broadcast routes
                        Route::prefix('broadcast')
                            ->name('.broadcast')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalBroadcastController::class, 'index']);
                                Route::post('store', [MyProfileApprovalBroadcastController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalBroadcastController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalBroadcastController::class, 'delete'])->name('.delete');
                            });

                        // media post routes
                        Route::prefix('media-post')
                            ->name('.mediaPost')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalMediaPostController::class, 'index']);
                                Route::post('store', [MyProfileApprovalMediaPostController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalMediaPostController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalMediaPostController::class, 'delete'])->name('.delete');
                            });

                        // card routes
                        Route::prefix('card')
                            ->name('.card')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalCardController::class, 'index']);
                                Route::post('store', [MyProfileApprovalCardController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalCardController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalCardController::class, 'delete'])->name('.delete');
                            });

                        // vehicle routes
                        Route::prefix('vehicle')
                            ->name('.vehicle')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalVehicleController::class, 'index']);
                                Route::post('store', [MyProfileApprovalVehicleController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalVehicleController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalVehicleController::class, 'delete'])->name('.delete');
                            });

                        // event routes
                        Route::prefix('event')
                            ->name('.event')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalEventController::class, 'index']);
                                Route::get('export', [MyProfileApprovalEventController::class, 'export'])->name('.export');
                                Route::post('store', [MyProfileApprovalEventController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalEventController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalEventController::class, 'delete'])->name('.delete');
                            });

                        // attendance routes
                        Route::prefix('attendance')
                            ->name('.attendance')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalAttendanceController::class, 'index']);
                                Route::post('store', [MyProfileApprovalAttendanceController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalAttendanceController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalAttendanceController::class, 'delete'])->name('.delete');
                            });

                        // equipment routes
                        Route::prefix('equipment')
                            ->name('.equipment')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalEquipmentController::class, 'index']);
                                Route::post('store', [MyProfileApprovalEquipmentController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalEquipmentController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalEquipmentController::class, 'delete'])->name('.delete');
                            });

                        // outstation routes
                        Route::prefix('outstation')
                            ->name('.outstation')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalOutstationController::class, 'index']);
                                Route::post('store', [MyProfileApprovalOutstationController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalOutstationController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalOutstationController::class, 'delete'])->name('.delete');
                            });

                        // leave routes
                        Route::prefix('leave')
                            ->name('.leave')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalLeaveController::class, 'index']);
                                Route::post('store', [MyProfileApprovalLeaveController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalLeaveController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalLeaveController::class, 'delete'])->name('.delete');
                            });

                        // training routes
                        Route::prefix('training')
                            ->name('.training')
                            ->group(function () {
                                Route::get('/', [SubmissionTrainingController::class, 'index']);
                                Route::post('store', [SubmissionTrainingController::class, 'store'])->name('.store');
                                Route::post('update', [SubmissionTrainingController::class, 'update'])->name('.update');
                                Route::delete('delete', [SubmissionTrainingController::class, 'delete'])->name('.delete');
                            });

                        // resignation routes
                        Route::prefix('resignation')
                            ->name('.resignation')
                            ->group(function () {
                                Route::get('/', [MyProfileApprovalResignationController::class, 'index']);
                                Route::post('store', [MyProfileApprovalResignationController::class, 'store'])->name('.store');
                                Route::post('update', [MyProfileApprovalResignationController::class, 'update'])->name('.update');
                                Route::delete('delete', [MyProfileApprovalResignationController::class, 'delete'])->name('.delete');
                            });
                    });
                Route::prefix('qualification')
                    ->name('.qualification.')
                    ->group(function () {
                        // attachment
                        Route::prefix('attachment')
                            ->name('attachment')
                            ->group(function () {
                                Route::post('save', [AttachmentController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [AttachmentController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // academic
                        Route::prefix('academic')
                            ->name('academic')
                            ->group(function () {
                                Route::post('save', [AcademicController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [AcademicController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // certification
                        Route::prefix('certification')
                            ->name('certification')
                            ->group(function () {
                                Route::post('save', [CertificationController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [CertificationController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // training
                        Route::prefix('training')
                            ->name('training')
                            ->group(function () {
                                Route::post('save', [TrainingController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [TrainingController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // experience
                        Route::prefix('experience')
                            ->name('experience')
                            ->group(function () {
                                Route::post('save', [ExperienceController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [ExperienceController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // speacialization
                        Route::prefix('specialization')
                            ->name('specialization')
                            ->group(function () {
                                Route::post('save', [SpecializationController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [SpecializationController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // family
                        Route::prefix('family')
                            ->name('family')
                            ->group(function () {
                                Route::post('save', [FamilyController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [FamilyController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // language skill
                        Route::prefix('language-skill')
                            ->name('languageSkill')
                            ->group(function () {
                                Route::post('save', [LanguageSkillController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [LanguageSkillController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // honor prize
                        Route::prefix('honor-prize')
                            ->name('honorPrize')
                            ->group(function () {
                                Route::post('save', [HonorPrizeController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [HonorPrizeController::class, 'delete'])
                                    ->name('.delete');
                            });
                        // community involvement
                        Route::prefix('community-involvement')
                            ->name('communityInvolvement')
                            ->group(function () {
                                Route::post('save', [CommunityInvolvementController::class, 'save'])
                                    ->name('.save');
                                Route::delete('delete', [CommunityInvolvementController::class, 'delete'])
                                    ->name('.delete');
                            });
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
                // publication routes
                Route::prefix('publication')
                    ->name('.publication')
                    ->group(function () {
                        // operational area routes
                        Route::prefix('operational-area')
                            ->name('.operationalArea')
                            ->group(function () {
                                Route::get('/', [OperationalAreaController::class, 'index']);
                                Route::post('save', [OperationalAreaController::class, 'save'])->name('.save');
                                Route::delete('delete', [OperationalAreaController::class, 'delete'])->name('.delete');
                            });
                        // operational hour routes
                        Route::prefix('operational-hour')
                            ->name('.operationalHour')
                            ->group(function () {
                                Route::get('/', [OperationalHourController::class, 'index']);
                                Route::get('option-operational-area', [OperationalHourController::class, 'optionOperationalArea'])->name('.optionOperationalArea');
                                Route::post('save', [OperationalHourController::class, 'save'])->name('.save');
                                Route::delete('delete', [OperationalHourController::class, 'delete'])->name('.delete');
                            });
                        // post category routes
                        Route::prefix('post-category')
                            ->name('.postCategory')
                            ->group(function () {
                                Route::get('/', [PostCategoryController::class, 'index']);
                                Route::post('save', [PostCategoryController::class, 'save'])->name('.save');
                                Route::delete('delete', [PostCategoryController::class, 'delete'])->name('.delete');
                            });
                        // page routes
                        Route::prefix('page')
                            ->name('.page')
                            ->group(function () {
                                Route::get('/', [PageController::class, 'index']);
                                Route::post('save', [PageController::class, 'save'])->name('.save');
                            });
                        // article routes
                        Route::prefix('article')
                            ->name('.article')
                            ->group(function () {
                                Route::get('/', [ArticleController::class, 'index']);
                                Route::get('option-post-category', [ArticleController::class, 'optionPostCategory'])->name('.optionPostCategory');
                                Route::post('save', [ArticleController::class, 'save'])->name('.save');
                                Route::delete('delete', [ArticleController::class, 'delete'])->name('.delete');
                            });
                        // news routes
                        Route::prefix('news')
                            ->name('.news')
                            ->group(function () {
                                Route::get('/', [NewsController::class, 'index']);
                                Route::get('option-post-category', [NewsController::class, 'optionPostCategory'])->name('.optionPostCategory');
                                Route::post('save', [NewsController::class, 'save'])->name('.save');
                                Route::delete('delete', [NewsController::class, 'delete'])->name('.delete');
                            });
                        // admission information routes
                        Route::prefix('admission-information')
                            ->name('.admissionInformation')
                            ->group(function () {
                                Route::get('/', [AdmissionInformationController::class, 'index']);
                                Route::get('option-post-category', [AdmissionInformationController::class, 'optionPostCategory'])->name('.optionPostCategory');
                                Route::post('save', [AdmissionInformationController::class, 'save'])->name('.save');
                                Route::delete('delete', [AdmissionInformationController::class, 'delete'])->name('.delete');
                            });
                        // achievement routes
                        Route::prefix('achievement')
                            ->name('.achievement')
                            ->group(function () {
                                Route::get('/', [AchievementController::class, 'index']);
                                Route::post('save', [AchievementController::class, 'save'])->name('.save');
                                Route::delete('delete', [AchievementController::class, 'delete'])->name('.delete');
                            });
                        // banner routes
                        Route::prefix('banner')
                            ->name('.banner')
                            ->group(function () {
                                Route::get('/', [BannerController::class, 'index']);
                                Route::post('save', [BannerController::class, 'save'])->name('.save');
                                Route::delete('delete', [BannerController::class, 'delete'])->name('.delete');
                            });
                        // career routes
                        Route::prefix('career')
                            ->name('.career')
                            ->group(function () {
                                Route::get('/', [CareerController::class, 'index']);
                                Route::post('save', [CareerController::class, 'save'])->name('.save');
                                Route::delete('delete', [CareerController::class, 'delete'])->name('.delete');
                            });
                        // event routes
                        Route::prefix('event')
                            ->name('.event')
                            ->group(function () {
                                Route::get('/', [EventController::class, 'index']);
                                Route::post('save', [EventController::class, 'save'])->name('.save');
                                Route::delete('delete', [EventController::class, 'delete'])->name('.delete');
                            });
                        // faq routes
                        Route::prefix('faq')
                            ->name('.faq')
                            ->group(function () {
                                Route::get('/', [FaqController::class, 'index']);
                                Route::post('save', [FaqController::class, 'save'])->name('.save');
                                Route::delete('delete', [FaqController::class, 'delete'])->name('.delete');
                            });
                        // gallery routes
                        Route::prefix('gallery')
                            ->name('.gallery')
                            ->group(function () {
                                Route::get('/', [GalleryController::class, 'index']);
                                Route::post('save', [GalleryController::class, 'save'])->name('.save');
                                Route::delete('delete', [GalleryController::class, 'delete'])->name('.delete');
                            });
                        // public feedback routes
                        Route::prefix('public-feedback')
                            ->name('.publicFeedback')
                            ->group(function () {
                                Route::get('/', [PublicFeedbackController::class, 'index']);
                                Route::delete('delete', [PublicFeedbackController::class, 'delete'])->name('.delete');
                            });
                        // testimonial routes
                        Route::prefix('testimonial')
                            ->name('.testimonial')
                            ->group(function () {
                                Route::get('/', [TestimonialController::class, 'index']);
                                Route::post('save', [TestimonialController::class, 'save'])->name('.save');
                                Route::delete('delete', [TestimonialController::class, 'delete'])->name('.delete');
                            });
                    });
                // approval routes
                Route::prefix('approval')
                    ->name('.approval')
                    ->group(function () {
                        // design routes
                        Route::prefix('design')
                            ->name('.design')
                            ->group(function () {
                                Route::get('/', [ApprovalDesignController::class, 'index']);
                                Route::post('store', [ApprovalDesignController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalDesignController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalDesignController::class, 'delete'])->name('.delete');
                            });

                        // documentation routes
                        Route::prefix('documentation')
                            ->name('.documentation')
                            ->group(function () {
                                Route::get('/', [ApprovalDocumentationController::class, 'index']);
                                Route::post('store', [ApprovalDocumentationController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalDocumentationController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalDocumentationController::class, 'delete'])->name('.delete');
                            });

                        // broadcast routes
                        Route::prefix('broadcast')
                            ->name('.broadcast')
                            ->group(function () {
                                Route::get('/', [ApprovalBroadcastController::class, 'index']);
                                Route::post('store', [ApprovalBroadcastController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalBroadcastController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalBroadcastController::class, 'delete'])->name('.delete');
                            });

                        // media post routes
                        Route::prefix('media-post')
                            ->name('.mediaPost')
                            ->group(function () {
                                Route::get('/', [ApprovalMediaPostController::class, 'index']);
                                Route::post('store', [ApprovalMediaPostController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalMediaPostController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalMediaPostController::class, 'delete'])->name('.delete');
                            });

                        // card routes
                        Route::prefix('card')
                            ->name('.card')
                            ->group(function () {
                                Route::get('/', [ApprovalCardController::class, 'index']);
                                Route::post('store', [ApprovalCardController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalCardController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalCardController::class, 'delete'])->name('.delete');
                            });
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
                                Route::get('option-area', [AdmissionStudentPriceController::class, 'optionArea'])->name('.optionArea');
                                Route::post('store', [AdmissionStudentPriceController::class, 'store'])->name('.store');
                                Route::post('update', [AdmissionStudentPriceController::class, 'update'])->name('.update');
                                Route::delete('delete', [AdmissionStudentPriceController::class, 'delete'])->name('.delete');
                            });
                        // admission student discount routes
                        Route::prefix('admission-student-discount')
                            ->name('.admissionStudentDiscount')
                            ->group(function () {
                                Route::get('/', [AdmissionStudentDiscountController::class, 'index']);
                                Route::get('option-area', [AdmissionStudentDiscountController::class, 'optionArea'])->name('.optionArea');
                                Route::post('store', [AdmissionStudentDiscountController::class, 'store'])->name('.store');
                                Route::post('update', [AdmissionStudentDiscountController::class, 'update'])->name('.update');
                                Route::delete('delete', [AdmissionStudentDiscountController::class, 'delete'])->name('.delete');
                            });
                    });
                // setting routes
                Route::prefix('setting')
                    ->name('.setting.submissionApprover')
                    ->group(function () {
                        Route::get('/', [ICCSettingSubmissionApproverController::class, 'index']);
                        Route::get('get-submission-approver', [ICCSettingSubmissionApproverController::class, 'getSubmissionApprover'])->name('.getSubmissionApprover');
                        Route::get('option-employee', [ICCSettingSubmissionApproverController::class, 'optionEmployee'])->name('.optionEmployee');
                        Route::post('save', [ICCSettingSubmissionApproverController::class, 'save'])->name('.save');
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
                        Route::get('detail/{uuid}', [EmployeeController::class, 'detail'])->name('.detail');
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
                // approval routes
                Route::prefix('approval')
                    ->name('.approval')
                    ->group(function () {
                        // attendance routes
                        Route::prefix('attendance')
                            ->name('.attendance')
                            ->group(function () {
                                Route::get('/', [ApprovalAttendanceController::class, 'index']);
                                Route::post('store', [ApprovalAttendanceController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalAttendanceController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalAttendanceController::class, 'delete'])->name('.delete');
                            });

                        // outstation routes
                        Route::prefix('outstation')
                            ->name('.outstation')
                            ->group(function () {
                                Route::get('/', [ApprovalOutstationController::class, 'index']);
                                Route::post('store', [ApprovalOutstationController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalOutstationController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalOutstationController::class, 'delete'])->name('.delete');
                            });

                        // leave routes
                        Route::prefix('leave')
                            ->name('.leave')
                            ->group(function () {
                                Route::get('/', [ApprovalLeaveController::class, 'index']);
                                Route::post('store', [ApprovalLeaveController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalLeaveController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalLeaveController::class, 'delete'])->name('.delete');
                            });

                        // resignation routes
                        Route::prefix('resignation')
                            ->name('.resignation')
                            ->group(function () {
                                Route::get('/', [ApprovalResignationController::class, 'index']);
                                Route::post('store', [ApprovalResignationController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalResignationController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalResignationController::class, 'delete'])->name('.delete');
                            });
                    });
                // setting routes
                Route::prefix('setting')
                    ->name('.setting.submissionApprover')
                    ->group(function () {
                        Route::get('/', [SettingSubmissionApproverController::class, 'index']);
                        Route::get('get-submission-approver', [SettingSubmissionApproverController::class, 'getSubmissionApprover'])->name('.getSubmissionApprover');
                        Route::get('option-employee', [SettingSubmissionApproverController::class, 'optionEmployee'])->name('.optionEmployee');
                        Route::post('save', [SettingSubmissionApproverController::class, 'save'])->name('.save');
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
                // approval routes
                Route::prefix('approval')
                    ->name('.approval')
                    ->group(function () {
                        // material area routes
                        Route::prefix('material')
                            ->name('.material')
                            ->group(function () {
                                Route::get('/', [ApprovalMaterialController::class, 'index']);
                                Route::get('export', [ApprovalMaterialController::class, 'export'])->name('.export');
                                Route::post('store', [ApprovalMaterialController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalMaterialController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalMaterialController::class, 'delete'])->name('.delete');
                            });

                        // install & repair routes
                        Route::prefix('install-repair')
                            ->name('.installRepair')
                            ->group(function () {
                                Route::get('/', [ApprovalInstallRepairController::class, 'index']);
                                Route::get('option-assigned', [ApprovalInstallRepairController::class, 'optionAssigned'])->name('.optionAssigned');
                                Route::post('store', [ApprovalInstallRepairController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalInstallRepairController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalInstallRepairController::class, 'delete'])->name('.delete');
                            });

                        // vehicle routes
                        Route::prefix('vehicle')
                            ->name('.vehicle')
                            ->group(function () {
                                Route::get('/', [ApprovalVehicleController::class, 'index']);
                                Route::post('store', [ApprovalVehicleController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalVehicleController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalVehicleController::class, 'delete'])->name('.delete');
                            });

                        // event routes
                        Route::prefix('event')
                            ->name('.event')
                            ->group(function () {
                                Route::get('/', [ApprovalEventController::class, 'index']);
                                Route::get('export', [ApprovalEventController::class, 'export'])->name('.export');
                                Route::post('store', [ApprovalEventController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalEventController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalEventController::class, 'delete'])->name('.delete');
                            });

                        // equipment routes
                        Route::prefix('equipment')
                            ->name('.equipment')
                            ->group(function () {
                                Route::get('/', [ApprovalEquipmentController::class, 'index']);
                                Route::post('store', [ApprovalEquipmentController::class, 'store'])->name('.store');
                                Route::post('update', [ApprovalEquipmentController::class, 'update'])->name('.update');
                                Route::delete('delete', [ApprovalEquipmentController::class, 'delete'])->name('.delete');
                            });
                    });
                // setting routes
                Route::prefix('setting')
                    ->name('.setting.submissionApprover')
                    ->group(function () {
                        Route::get('/', [SubmissionApproverController::class, 'index']);
                        Route::get('get-submission-approver', [SubmissionApproverController::class, 'getSubmissionApprover'])->name('.getSubmissionApprover');
                        Route::get('option-employee', [SubmissionApproverController::class, 'optionEmployee'])->name('.optionEmployee');
                        Route::post('save', [SubmissionApproverController::class, 'save'])->name('.save');
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
Route::middleware(['auth', 'verified', 'role:System Admin|Site Admin|Employee'])
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
                Route::get('download-import-template', [StudentController::class, 'downloadImportTemplate'])
                    ->name('.downloadImportTemplate');
                Route::get('{student_id}/detail', [StudentController::class, 'detail'])->name('.detail');
                Route::get('option-school-grade', [StudentController::class, 'optionSchoolGrade'])->name('.optionSchoolGrade');
                Route::post('store', [StudentController::class, 'store'])->name('.store');
                Route::post('update', [StudentController::class, 'update'])->name('.update');
                Route::post('import', [StudentController::class, 'import'])->name('.import');
            });
        // activity routes
        Route::prefix('activity/admission-student')
            ->name('.activity.admissionStudent')
            ->group(function () {
                Route::get('/', [SchoolActivityAdmissionStudentController::class, 'index']);
                Route::get('{registration_number}/detail', [SchoolActivityAdmissionStudentController::class, 'detail'])->name('.detail');
                Route::get('export', [SchoolActivityAdmissionStudentController::class, 'export'])->name('.export');
                Route::post('update-stage', [SchoolActivityAdmissionStudentController::class, 'updateStage'])->name('.updateStage');
                Route::post('update-status', [SchoolActivityAdmissionStudentController::class, 'updateStatus'])->name('.updateStatus');
            });
        // teaching program routes
        Route::prefix('teaching-program')
            ->name('.teachingProgram')
            ->group(function () {
                // subject threshold routes
                Route::prefix('subject-threshold')
                    ->name('.subjectThreshold')
                    ->group(function () {
                        Route::get('/', [SubjectThresholdController::class, 'index']);
                        Route::get('get-subject-threshold', [SubjectThresholdController::class, 'getSubjectThreshold'])->name('.getSubjectThreshold');
                        Route::post('save', [SubjectThresholdController::class, 'save'])->name('.save');
                    });
                // learning objective routes
                Route::prefix('learning-objective')
                    ->name('.learningObjective')
                    ->group(function () {
                        Route::get('/', [LearningObjectiveController::class, 'index']);
                        Route::get('{learning_objective_category_id}/detail', [LearningObjectiveController::class, 'detail'])->name('.detail');
                        Route::get('option-school-phase', [LearningObjectiveController::class, 'optionSchoolPhase'])->name('.optionSchoolPhase');
                        Route::get('option-school-grade', [LearningObjectiveController::class, 'optionSchoolGrade'])->name('.optionSchoolGrade');
                        Route::get('option-school-subject', [LearningObjectiveController::class, 'optionSchoolSubject'])->name('.optionSchoolSubject');
                        Route::get('option-learning-objective', [LearningObjectiveController::class, 'optionLearningObjective'])->name('.optionLearningObjective');
                        Route::get('get-learning-objective', [LearningObjectiveController::class, 'getLearningObjective'])->name('.getLearningObjective');
                        Route::post('save', [LearningObjectiveController::class, 'save'])->name('.save');
                        Route::delete('delete', [LearningObjectiveController::class, 'delete'])->name('.delete');
                    });
                // assessment module routes
                Route::prefix('assessment-module')
                    ->name('.assessmentModule')
                    ->group(function () {
                        Route::get('/', [AssessmentModuleController::class, 'index']);
                        Route::get('{assessment_module_id}/detail', [AssessmentModuleController::class, 'detail'])->name('.detail');
                        Route::post('save', [AssessmentModuleController::class, 'save'])->name('.save');
                        Route::delete('delete', [AssessmentModuleController::class, 'delete'])->name('.delete');
                        // assessment aspect routes
                        Route::prefix('assessment-aspect')
                            ->name('.assessmentAspect')
                            ->group(function () {
                                Route::post('save', [AssessmentAspectController::class, 'save'])->name('.save');
                                Route::delete('delete', [AssessmentAspectController::class, 'delete'])->name('.delete');
                            });
                        // assessment rubric routes
                        Route::prefix('assessment-rubric')
                            ->name('.assessmentRubric')
                            ->group(function () {
                                Route::post('save', [AssessmentRubricController::class, 'save'])->name('.save');
                                Route::delete('delete', [AssessmentRubricController::class, 'delete'])->name('.delete');
                            });
                        // assessment final rule routes
                        Route::prefix('assessment-final-rule')
                            ->name('.assessmentFinalRule')
                            ->group(function () {
                                Route::post('save', [AssessmentFinalRuleController::class, 'save'])->name('.save');
                                Route::delete('delete', [AssessmentFinalRuleController::class, 'delete'])->name('.delete');
                            });
                    });
            });
        // learning activity routes
        Route::prefix('learning-activity')
            ->name('.learningActivity')
            ->group(function () {
                // school classroom routes
                Route::prefix('school-classroom')
                    ->name('.schoolClassroom')
                    ->group(function () {
                        Route::get('/', [LearningActivitySchoolClassroomController::class, 'index']);
                        Route::get('{school_classroom_id}/detail', [LearningActivitySchoolClassroomController::class, 'detail'])->name('.detail');
                        // school classroom routes
                        Route::prefix('{school_classroom_id}/assessment-subject')
                            ->name('.assessmentSubject')
                            ->group(function () {
                                Route::get('/', [AssessmentSubjectController::class, 'index']);
                                Route::get('{assessment_record_id}/detail', [AssessmentSubjectController::class, 'detail'])->name('.detail');
                                Route::get('option-school-subject', [AssessmentSubjectController::class, 'optionSchoolSubject'])->name('.optionSchoolSubject');
                                Route::get('option-assessment-module', [AssessmentSubjectController::class, 'optionAssessmentModule'])->name('.optionAssessmentModule');
                                Route::post('save', [AssessmentSubjectController::class, 'save'])->name('.save');
                                Route::delete('delete', [AssessmentSubjectController::class, 'delete'])->name('.delete');
                                // school classroom routes
                                Route::prefix('{assessment_record_id}/assessment-record')
                                    ->name('.assessmentRecord')
                                    ->group(function () {
                                        Route::get('/', [AssessmentSessionController::class, 'index']);
                                        Route::get('option-learning-objective', [AssessmentSessionController::class, 'optionLearningObjective'])->name('.optionLearningObjective');
                                        Route::get('option-assessment-rubric', [AssessmentSessionController::class, 'optionAssessmentRubric'])->name('.optionAssessmentRubric');
                                        Route::post('save', [AssessmentSessionController::class, 'save'])->name('.save');
                                    });
                            });
                    });
            });
        // management routes
        Route::prefix('management')
            ->name('.management')
            ->group(function () {
                // school curriculum routes
                Route::prefix('school-curriculum')
                    ->name('.schoolCurriculum')
                    ->group(function () {
                        Route::get('/', [SchoolCurriculumController::class, 'index']);
                        Route::get('{school_curriculum_id}/detail', [SchoolCurriculumController::class, 'detail'])->name('.detail');
                        Route::post('save', [SchoolCurriculumController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolCurriculumController::class, 'delete'])->name('.delete');
                        Route::prefix('learning-objective-category')
                            ->name('.learningObjectiveCategory')
                            ->group(function () {
                                Route::get('option-parent', [LearningObjectiveCategoryController::class, 'optionParent'])->name('.optionParent');
                                Route::post('save', [LearningObjectiveCategoryController::class, 'save'])->name('.save');
                                Route::delete('delete', [LearningObjectiveCategoryController::class, 'delete'])->name('.delete');
                            });
                        Route::prefix('learning-rubric')
                            ->name('.learningRubric')
                            ->group(function () {
                                Route::post('save', [LearningRubricController::class, 'save'])->name('.save');
                                Route::delete('delete', [LearningRubricController::class, 'delete'])->name('.delete');
                            });
                    });
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
                // school major routes
                Route::prefix('school-major')
                    ->name('.schoolMajor')
                    ->group(function () {
                        Route::get('/', [SchoolMajorController::class, 'index']);
                        Route::post('save', [SchoolMajorController::class, 'save'])->name('.save');
                        Route::delete('delete', [SchoolMajorController::class, 'delete'])->name('.delete');
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
        // setting routes
        Route::prefix('setting')
            ->name('.setting')
            ->group(function () {
                // profile routes
                Route::prefix('profile')
                    ->name('.profile')
                    ->group(function () {
                        Route::get('/', [SettingSchoolController::class, 'index']);
                        Route::get('option-headmaster', [SettingSchoolController::class, 'optionHeadmaster'])->name('.optionHeadmaster');
                        Route::post('save', [SettingSchoolController::class, 'save'])->name('.save');
                        Route::prefix('academic-program')
                            ->name('.academicProgram')
                            ->group(function () {
                                Route::post('save', [SchoolAcademicProgramController::class, 'save'])->name('.save');
                                Route::get('option-school-year', [SchoolAcademicProgramController::class, 'optionSchoolYear'])->name('.optionSchoolYear');
                                Route::get('option-school-curriculum', [SchoolAcademicProgramController::class, 'optionSchoolCurriculum'])->name('.optionSchoolCurriculum');
                                Route::delete('delete', [SchoolAcademicProgramController::class, 'delete'])->name('.delete');
                            });
                    });
            });
    });

// guardian routes
Route::middleware(['auth', 'verified', 'role:System Admin|Site Admin|Guardian'])
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
                Route::get('get-admission-component', [AdmissionStudentController::class, 'getAdmissionComponent'])->name('.getAdmissionComponent');
                Route::get('get-admission-discount', [AdmissionStudentController::class, 'getAdmissionDiscount'])->name('.getAdmissionDiscount');
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
// auth
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});
// ajax routes
Route::middleware(['auth'])
    ->prefix('ajax')
    ->name('ajax')
    ->group(function () {
        // chat
        Route::prefix('chat')
            ->name('.chat')
            ->group(function () {
                Route::get('get-chats', [ChatController::class, 'getChats'])->name('.getChats');
                Route::post('send-chat', [ChatController::class, 'sendChat'])->name('.sendChat');
            });
        // approval
        Route::prefix('approval')
            ->name('.approval')
            ->group(function () {
                Route::post('update-status', [ApprovalController::class, 'updateStatus'])->name('.updateStatus');
            });
        // option
        Route::prefix('option')
            ->name('.option')
            ->group(function () {
                Route::get('area', [OptionController::class, 'area'])->name('.area');
            });
    });

require __DIR__ . '/auth.php';
