<?php

declare(strict_types=1);

namespace App\Observers;

use App\Models\TrainingProgram\TrainingProgramSubmissionBudgetItem;

class TrainingProgramSubmissionBudgetItemObserver
{
    /**
     * Handle the TrainingProgramSubmissionBudgetItem "creating" event.
     */
    public function creating(TrainingProgramSubmissionBudgetItem $budgetItem): void
    {
        $budgetItem->total_price = $budgetItem->quantity * $budgetItem->unit_price;
    }

    /**
     * Handle the TrainingProgramSubmissionBudgetItem "updating" event.
     */
    public function updating(TrainingProgramSubmissionBudgetItem $budgetItem): void
    {
        $budgetItem->total_price = $budgetItem->quantity * $budgetItem->unit_price;
    }
} 