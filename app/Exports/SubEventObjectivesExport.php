<?php

namespace App\Exports;

use App\Models\SubEventObjective;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubEventObjectivesExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return SubEventObjective::select('title', 'description', 'remark')->whereHas('event.submission', function ($q) {
            $q->where('uuid', request('submission_id'));
        })->get();
    }

    public function headings(): array
    {
        return ['Judul Tujuan', 'Deskripsi', 'Catatan'];
    }
}
