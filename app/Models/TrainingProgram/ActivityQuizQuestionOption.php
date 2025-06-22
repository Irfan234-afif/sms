<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ActivityQuizQuestionOption extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_quiz_question_options';

    protected $fillable = [
        'activity_quiz_question_id',
        'master_option_id',
        'option_text',
        'is_correct',
        'order',
        'explanation',
    ];

    protected $casts = [
        'is_correct' => 'boolean',
        'order' => 'integer',
    ];

    /**
     * Get the activity quiz question that owns this option.
     */
    public function activityQuizQuestion(): BelongsTo
    {
        return $this->belongsTo(ActivityQuizQuestion::class, 'activity_quiz_question_id');
    }

    /**
     * Get the master option (for reference).
     */
    public function masterOption(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuizQuestionOption::class, 'master_option_id');
    }
} 