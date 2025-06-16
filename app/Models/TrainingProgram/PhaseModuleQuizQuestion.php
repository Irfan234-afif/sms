<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PhaseModuleQuizQuestion extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'phase_module_quiz_id',
        'question',
        'type', // multiple_choice, true_false, essay
        'points',
        'order',
    ];

    public function quiz(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleQuiz::class);
    }

    public function options(): HasMany
    {
        return $this->hasMany(PhaseModuleQuizQuestionOption::class);
    }
}
