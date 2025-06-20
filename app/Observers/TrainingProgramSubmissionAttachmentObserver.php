<?php

declare(strict_types=1);

namespace App\Observers;

use App\Models\TrainingProgram\TrainingProgramSubmissionAttachment;
use Illuminate\Support\Facades\Storage;

class TrainingProgramSubmissionAttachmentObserver
{
    /**
     * Handle the TrainingProgramSubmissionAttachment "deleting" event.
     */
    public function deleting(TrainingProgramSubmissionAttachment $attachment): void
    {
        if ($attachment->file_path && Storage::exists($attachment->file_path)) {
            Storage::delete($attachment->file_path);
        }
    }
} 