<?php

declare(strict_types=1);

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramSubmissionGoal extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_submission_id',
        'goal_type',
        'description',
        'success_indicator',
        'order',
    ];

    public function submission(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramSubmission::class, 'training_program_submission_id');
    }

    // Helper methods for goal types
    public function isKnowledge(): bool
    {
        return $this->goal_type === 'knowledge';
    }

    public function isSkill(): bool
    {
        return $this->goal_type === 'skill';
    }

    public function isAttitude(): bool
    {
        return $this->goal_type === 'attitude';
    }

    public function getGoalTypeLabel(): string
    {
        return match($this->goal_type) {
            'knowledge' => 'Pengetahuan',
            'skill' => 'Keterampilan',
            'attitude' => 'Sikap',
            default => ucfirst($this->goal_type),
        };
    }

    // Scopes
    public function scopeByType($query, string $type)
    {
        return $query->where('goal_type', $type);
    }

    public function scopeKnowledge($query)
    {
        return $query->where('goal_type', 'knowledge');
    }

    public function scopeSkill($query)
    {
        return $query->where('goal_type', 'skill');
    }

    public function scopeAttitude($query)
    {
        return $query->where('goal_type', 'attitude');
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('order');
    }
} 