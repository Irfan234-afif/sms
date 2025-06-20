<?php

declare(strict_types=1);

namespace App\Models\TrainingProgram;

use App\Models\Area;
use App\Models\Employee;
use App\Models\Submission;
use App\Models\SubmissionGroup;
use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class TrainingProgramSubmission extends Model
{
    use HasFactory, GenerateUuid, SoftDeletes;

    protected $fillable = [
        'submission_id',
        'submitter_id',
        'reference_number',
        'training_type',
        'training_program_id',
        'external_training_title',
        'external_training_provider',
        'external_training_description',
        'external_training_location',
        'external_training_method',
        'start_date',
        'end_date',
        'daily_start_time',
        'daily_end_time',
        'training_days',
        'justification',
        'expected_outcomes',
        'total_budget',
        'datetime',
        'status',
    ];

    protected $casts = [
        'training_days' => 'array',
        'start_date' => 'date',
        'end_date' => 'date',
        'total_budget' => 'decimal:2',
        'datetime' => 'datetime',
    ];

    protected $dates = [
        'start_date',
        'end_date',
        'datetime',
    ];

    public function submitter(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'submitter_id');
    }

    // Training program relationship (for internal training)
    public function trainingProgram(): BelongsTo
    {
        return $this->belongsTo(TrainingProgram::class);
    }

    // Related submission records (for approval workflow)
    public function goals(): HasMany
    {
        return $this->hasMany(TrainingProgramSubmissionGoal::class)->orderBy('order');
    }

    public function budgetItems(): HasMany
    {
        return $this->hasMany(TrainingProgramSubmissionBudgetItem::class);
    }

    public function participants(): HasMany
    {
        return $this->hasMany(TrainingProgramSubmissionParticipant::class)->orderBy('order');
    }

    public function attachments(): HasMany
    {
        return $this->hasMany(TrainingProgramSubmissionAttachment::class)->orderBy('order');
    }

    // Approval workflow relationships - integrate with Submission system
    public function submission(): BelongsTo
    {
        return $this->belongsTo(Submission::class, 'submission_id');
    }

    public function approvals(): HasMany
    {
        return $this->hasMany(\App\Models\SubmissionApproval::class, 'submission_id', 'submission_id');
    }

    // Helper methods
    public function isInternal(): bool
    {
        return $this->training_type === 'internal';
    }

    public function isExternal(): bool
    {
        return $this->training_type === 'external';
    }

    public function getTotalBudgetAttribute($value): float
    {
        if ($value === null) {
            return $this->budgetItems()->sum('total_price') ?? 0.0;
        }

        return (float) $value;
    }

    public function getFormattedBudgetAttribute(): string
    {
        return 'Rp ' . number_format($this->total_budget, 0, ',', '.');
    }

    public function getTotalBudget(): float
    {
        return $this->budgetItems->sum('total_price') ?? 0.0;
    }

    public function getFormattedTotalBudget(): string
    {
        return 'Rp ' . number_format($this->getTotalBudget(), 0, ',', '.');
    }

    public function getDurationInDaysAttribute(): int
    {
        return $this->start_date->diffInDays($this->end_date) + 1;
    }

    public function getTitleAttribute(): string
    {
        if ($this->isInternal() && $this->trainingProgram) {
            return $this->trainingProgram->name;
        }

        return $this->external_training_title ?? 'N/A';
    }

    public function getProviderAttribute(): string
    {
        if ($this->isInternal()) {
            return 'Internal Training';
        }

        return $this->external_training_provider ?? 'N/A';
    }

    public function getLocationAttribute(): string
    {
        return $this->external_training_location ?? '';
    }

    public function getMethodAttribute(): string
    {
        return $this->external_training_method ?? '';
    }

    public function getDescriptionAttribute(): string
    {
        return $this->external_training_description ?? $this->justification ?? '';
    }

    public function getStartTimeAttribute(): string
    {
        return $this->daily_start_time ?? '09:00';
    }

    public function getEndTimeAttribute(): string
    {
        return $this->daily_end_time ?? '17:00';
    }

    // Status helper methods
    public function isDraft(): bool
    {
        // Check both local status and main submission status
        return $this->status === 'draft' || 
               ($this->submission && $this->submission->status === 'DRAFT');
    }

    public function isSubmitted(): bool
    {
        return $this->status === 'submitted' || 
               ($this->submission && $this->submission->status === 'PENDING');
    }

    public function isApproved(): bool
    {
        return $this->status === 'approved' || 
               ($this->submission && $this->submission->status === 'APPROVED');
    }

    public function isRejected(): bool
    {
        return $this->status === 'rejected' || 
               ($this->submission && $this->submission->status === 'REJECTED');
    }

    public function isCancelled(): bool
    {
        return $this->status === 'cancelled' || 
               ($this->submission && $this->submission->status === 'CANCELLED');
    }

    // Helper accessor to get area from main submission
    public function getAreaAttribute()
    {
        return $this->submission?->area;
    }

    // Scopes
    public function scopeInternal($query)
    {
        return $query->where('training_type', 'internal');
    }

    public function scopeExternal($query)
    {
        return $query->where('training_type', 'external');
    }

    public function scopeByStatus($query, string $status)
    {
        return $query->where('status', $status);
    }

    public function scopeBySubmitter($query, int $submitterId)
    {
        return $query->where('submitter_id', $submitterId);
    }

    public function scopeByArea($query, int $areaId)
    {
        return $query->whereHas('submission', function ($q) use ($areaId) {
            $q->where('area_id', $areaId);
        });
    }
} 