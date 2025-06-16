<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TrainingProgram extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'name',
        'type',
        'level',
        'description',
        'status',
    ];

    public function phases(): HasMany
    {
        return $this->hasMany(TrainingProgramPhase::class);
    }
}
