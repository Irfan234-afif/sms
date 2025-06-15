<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LearningObjectiveCategoryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'uuid' => $this->uuid,
            'school_curriculum' => $this->school_curriculum,
            'parent' => $this->parent,
            'title' => $this->title,
            'type' => $this->type,
            'type_label' => $this->getTypeLabel(),
            'code' => $this->code,
            'options' => $this->options,
        ];
    }


    private function getTypeLabel(): string
    {
        switch ($this->type) {
            case 'SUBJECT':
                return 'Mata Pelajaran';
            case 'EXTRACURRICULAR':
                return 'Ekstrakurikuler';
            case 'PERSONAL_DEVELOPMENT':
                return 'Pengembangan Diri';
            default:
                return 'Tidak Diketahui';
        }
    }
}
