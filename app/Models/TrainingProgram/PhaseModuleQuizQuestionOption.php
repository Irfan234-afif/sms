<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PhaseModuleQuizQuestionOption extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'phase_module_quiz_question_id',
        'option_text',
        'is_correct',
        'order',
    ];

    public function question(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuizQuestion::class, 'quiz_question_id');
    }
}
