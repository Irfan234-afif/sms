<?php

namespace App\Providers;

use App\Models\TrainingProgram\TrainingProgramSubmissionAttachment;
use App\Models\TrainingProgram\TrainingProgramSubmissionBudgetItem;
use App\Observers\TrainingProgramSubmissionAttachmentObserver;
use App\Observers\TrainingProgramSubmissionBudgetItemObserver;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);

        // Register model observers
        TrainingProgramSubmissionBudgetItem::observe(TrainingProgramSubmissionBudgetItemObserver::class);
        TrainingProgramSubmissionAttachment::observe(TrainingProgramSubmissionAttachmentObserver::class);
    }
}
