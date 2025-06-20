<?php

declare(strict_types=1);

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrainingProgramSubmissionBudgetItem extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'training_program_submission_id',
        'category',
        'item_name',
        'description',
        'quantity',
        'unit_price',
        'total_price',
        'notes',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'unit_price' => 'decimal:2',
        'total_price' => 'decimal:2',
    ];

    public function submission(): BelongsTo
    {
        return $this->belongsTo(TrainingProgramSubmission::class, 'training_program_submission_id');
    }

    // Budget category helpers
    public function getCategoryLabel(): string
    {
        return match($this->category) {
            'venue' => 'Tempat/Venue',
            'instructor_fee' => 'Biaya Instruktur',
            'material' => 'Materi',
            'equipment' => 'Peralatan',
            'transportation' => 'Transportasi',
            'accommodation' => 'Akomodasi',
            'meal' => 'Konsumsi',
            'certification' => 'Sertifikasi',
            'other' => 'Lainnya',
            default => ucfirst($this->category),
        };
    }

    public function getFormattedUnitPriceAttribute(): string
    {
        return 'Rp ' . number_format((float) $this->unit_price, 0, ',', '.');
    }

    public function getFormattedTotalPriceAttribute(): string
    {
        return 'Rp ' . number_format((float) $this->total_price, 0, ',', '.');
    }

    public function getFormattedUnitPrice(): string
    {
        return 'Rp ' . number_format((float) $this->unit_price, 0, ',', '.');
    }

    public function getFormattedTotalPrice(): string
    {
        return 'Rp ' . number_format((float) $this->total_price, 0, ',', '.');
    }

    // Scopes
    public function scopeByCategory($query, string $category)
    {
        return $query->where('category', $category);
    }

    public function scopeVenue($query)
    {
        return $query->where('category', 'venue');
    }

    public function scopeInstructorFee($query)
    {
        return $query->where('category', 'instructor_fee');
    }

    public function scopeMaterial($query)
    {
        return $query->where('category', 'material');
    }

    public function scopeEquipment($query)
    {
        return $query->where('category', 'equipment');
    }

    public function scopeTransportation($query)
    {
        return $query->where('category', 'transportation');
    }

    public function scopeAccommodation($query)
    {
        return $query->where('category', 'accommodation');
    }

    public function scopeMeal($query)
    {
        return $query->where('category', 'meal');
    }

    public function scopeCertification($query)
    {
        return $query->where('category', 'certification');
    }

    public function scopeOther($query)
    {
        return $query->where('category', 'other');
    }

    // Get all available categories
    public static function getCategories(): array
    {
        return [
            'venue' => 'Tempat/Venue',
            'instructor_fee' => 'Biaya Instruktur',
            'material' => 'Materi',
            'equipment' => 'Peralatan',
            'transportation' => 'Transportasi',
            'accommodation' => 'Akomodasi',
            'meal' => 'Konsumsi',
            'certification' => 'Sertifikasi',
            'other' => 'Lainnya',
        ];
    }
} 