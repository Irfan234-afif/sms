<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TrainingProgramPhase extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_id',
        'name',
        'description',
        'order',
        'status',
    ];

    public function trainingProgram(): BelongsTo
    {
        return $this->belongsTo(TrainingProgram::class);
    }

    public function modules(): HasMany
    {
        return $this->hasMany(PhaseModule::class);
    }
}
