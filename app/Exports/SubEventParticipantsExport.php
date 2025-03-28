<?php

namespace App\Exports;

use App\Models\SubEventParticipant;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubEventParticipantsExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return SubEventParticipant::select('type', 'quantity')->whereHas('event.submission', function ($q) {
            $q->where('uuid', request('submission_id'));
        })->get();
    }

    public function headings(): array
    {
        return ['Jenis Peserta', 'Jumlah'];
    }
}
