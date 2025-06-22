<?php

namespace App\Models\TrainingProgram;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityMaterial extends Model
{
    use HasFactory, GenerateUuid;

    protected $table = 'activity_materials';

    protected $fillable = [
        'activity_module_id',
        'master_material_id',
        'title',
        'description',
        'type',
        'content',
        'url',
        'file_path',
        'order',
        'status',
    ];

    /**
     * Get the activity module that owns this material.
     */
    public function activityModule(): BelongsTo
    {
        return $this->belongsTo(ActivityModule::class, 'activity_module_id');
    }

    /**
     * Get the master material (for reference).
     */
    public function masterMaterial(): BelongsTo
    {
        return $this->belongsTo(PhaseModuleMaterial::class, 'master_material_id');
    }

    /**
     * Get the material progress for this activity material.
     */
    public function materialProgress(): HasMany
    {
        return $this->hasMany(TrainingProgramMaterialProgress::class, 'activity_material_id');
    }
} 