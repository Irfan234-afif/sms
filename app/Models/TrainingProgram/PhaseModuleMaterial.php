<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PhaseModuleMaterial extends Model
{
    use HasFactory, GenerateUuid;

    protected $fillable = [
        'phase_module_id',
        'title',
        'type', // link, video, text, document
        'content',
        'file_path',
        'order',
        'status',
    ];

    public function module(): BelongsTo
    {
        return $this->belongsTo(PhaseModule::class, 'phase_module_id');
    }
}
