<?php

declare(strict_types=1);

namespace App\Models\TrainingProgram;

use App\Models\Profile;
use App\Models\Employee;
use App\Models\Student;
use App\Models\StudentGuardian;
use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class TrainingProgramSubmissionParticipant extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_submission_id',
        'participant_type',
        'participant_id',
        'role_description',
        'selection_reason',
        'is_primary_participant',
        'order',
    ];

    protected $casts = [
        'is_primary_participant' => 'boolean',
        'order' => 'integer',
    ];

    protected $with = ['participant'];

    public function submission(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramSubmission::class, 'training_program_submission_id');
    }

    /**
     * Get the participant model (Employee, Student, or StudentGuardian).
     */
    public function participant(): MorphTo
    {
        return $this->morphTo();
    }

    /**
     * Get the profile through the polymorphic relationship.
     */
    public function getProfileAttribute(): ?Profile
    {
        if ($this->participant instanceof Employee) {
            return $this->participant->profile;
        } elseif ($this->participant instanceof Student) {
            return $this->participant->profile;
        } elseif ($this->participant instanceof StudentGuardian) {
            return $this->participant->profile;
        }

        return null;
    }

    // Helper methods
    public function isPrimary(): bool
    {
        return $this->is_primary_participant;
    }

    public function isSecondary(): bool
    {
        return !$this->is_primary_participant;
    }

    public function getParticipantNameAttribute(): string
    {
        return $this->profile?->name ?? 'N/A';
    }

    public function getParticipantEmailAttribute(): string
    {
        return $this->profile?->email ?? 'N/A';
    }

    public function getParticipantPhoneAttribute(): string
    {
        return $this->profile?->phone ?? 'N/A';
    }

    public function getParticipantPositionAttribute(): string
    {
        if ($this->participant instanceof Employee) {
            return $this->participant->position?->name ?? 'N/A';
        }
        
        return 'N/A';
    }

    public function getParticipantAreaAttribute(): string
    {
        if ($this->participant instanceof Employee) {
            $assignment = $this->participant->assignments()->first();
            return $assignment?->area?->name ?? 'N/A';
        }
        
        return 'N/A';
    }

    public function getParticipantTypeLabel(): string
    {
        return $this->is_primary_participant ? 'Peserta Utama' : 'Peserta Pendamping';
    }

    public function getParticipantCategoryLabel(): string
    {
        switch ($this->participant_type) {
            case 'App\Models\Employee':
                return 'Karyawan';
            case 'App\Models\Student':
                return 'Siswa';
            case 'App\Models\StudentGuardian':
                return 'Wali Murid';
            default:
                return 'Unknown';
        }
    }

    // Scopes
    public function scopePrimary($query)
    {
        return $query->where('is_primary_participant', true);
    }

    public function scopeSecondary($query)
    {
        return $query->where('is_primary_participant', false);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('order');
    }

    public function scopeByParticipantType($query, string $type)
    {
        $modelClass = match ($type) {
            'employee' => Employee::class,
            'student' => Student::class,
            'student_guardian' => StudentGuardian::class,
            default => null,
        };

        if ($modelClass) {
            return $query->where('participant_type', $modelClass);
        }

        return $query;
    }

    // Static helpers
    public static function getTotalParticipants(int $submissionId): int
    {
        return static::where('training_program_submission_id', $submissionId)->count();
    }

    public static function getPrimaryParticipant(int $submissionId): ?self
    {
        return static::where('training_program_submission_id', $submissionId)
            ->where('is_primary_participant', true)
            ->first();
    }

    public static function getSecondaryParticipants(int $submissionId)
    {
        return static::where('training_program_submission_id', $submissionId)
            ->where('is_primary_participant', false)
            ->ordered()
            ->get();
    }
} 