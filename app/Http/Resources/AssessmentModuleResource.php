<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentModuleResource extends JsonResource
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
            'name' => $this->name,
            'type' => $this->type,
            'type_label' => $this->getTypeLabel(),
            'description' => $this->description,
            'aspects' => $this->aspects,
            'rubrics' => $this->rubrics,
            'final_rules' => $this->final_rules,
            'thresholds' => $this->thresholds,
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
