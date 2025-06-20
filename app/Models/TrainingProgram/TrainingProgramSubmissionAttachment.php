<?php

declare(strict_types=1);

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

class TrainingProgramSubmissionAttachment extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_submission_id',
        'file_name',
        'file_path',
        'file_type',
        'file_size',
        'attachment_type',
        'description',
        'order',
    ];

    protected $casts = [
        'file_size' => 'integer',
        'order' => 'integer',
    ];

    public function submission(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramSubmission::class, 'training_program_submission_id');
    }

    // File helpers
    public function getFileUrlAttribute(): string
    {
        return Storage::url($this->file_path);
    }

    public function getFileExists(): bool
    {
        return Storage::exists($this->file_path);
    }

    public function getFormattedFileSizeAttribute(): string
    {
        if (!$this->file_size) {
            return 'N/A';
        }

        $bytes = $this->file_size;
        $units = ['B', 'KB', 'MB', 'GB', 'TB'];

        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }

        return round($bytes, 2) . ' ' . $units[$i];
    }

    public function getAttachmentTypeLabel(): string
    {
        return match($this->attachment_type) {
            'proposal' => 'Proposal',
            'brochure' => 'Brosur',
            'curriculum' => 'Kurikulum',
            'quotation' => 'Quotation/Penawaran',
            'agreement' => 'Kontrak/Perjanjian',
            'other' => 'Lainnya',
            default => ucfirst($this->attachment_type),
        };
    }

    public function getFileIcon(): string
    {
        $extension = pathinfo($this->file_name, PATHINFO_EXTENSION);
        
        return match(strtolower($extension)) {
            'pdf' => 'fas fa-file-pdf',
            'doc', 'docx' => 'fas fa-file-word',
            'xls', 'xlsx' => 'fas fa-file-excel',
            'ppt', 'pptx' => 'fas fa-file-powerpoint',
            'jpg', 'jpeg', 'png', 'gif' => 'fas fa-file-image',
            'zip', 'rar' => 'fas fa-file-archive',
            default => 'fas fa-file',
        };
    }

    public function isImage(): bool
    {
        $extension = pathinfo($this->file_name, PATHINFO_EXTENSION);
        return in_array(strtolower($extension), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
    }

    public function isPdf(): bool
    {
        $extension = pathinfo($this->file_name, PATHINFO_EXTENSION);
        return strtolower($extension) === 'pdf';
    }

    public function isOfficeDocument(): bool
    {
        $extension = pathinfo($this->file_name, PATHINFO_EXTENSION);
        return in_array(strtolower($extension), ['doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx']);
    }

    public function getDownloadUrl(): string
    {
        return Storage::url($this->file_path);
    }

    public function getFormattedFileSize(): string
    {
        if (!$this->file_size) {
            return 'N/A';
        }

        $bytes = $this->file_size;
        $units = ['B', 'KB', 'MB', 'GB', 'TB'];

        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }

        return round($bytes, 2) . ' ' . $units[$i];
    }

    // Scopes
    public function scopeByType($query, string $type)
    {
        return $query->where('attachment_type', $type);
    }

    public function scopeProposal($query)
    {
        return $query->where('attachment_type', 'proposal');
    }

    public function scopeBrochure($query)
    {
        return $query->where('attachment_type', 'brochure');
    }

    public function scopeCurriculum($query)
    {
        return $query->where('attachment_type', 'curriculum');
    }

    public function scopeQuotation($query)
    {
        return $query->where('attachment_type', 'quotation');
    }

    public function scopeAgreement($query)
    {
        return $query->where('attachment_type', 'agreement');
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('order');
    }

    // Get all available attachment types
    public static function getAttachmentTypes(): array
    {
        return [
            'proposal' => 'Proposal',
            'brochure' => 'Brosur',
            'curriculum' => 'Kurikulum',
            'quotation' => 'Quotation/Penawaran',
            'agreement' => 'Kontrak/Perjanjian',
            'other' => 'Lainnya',
        ];
    }
} 