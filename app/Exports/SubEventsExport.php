<?php

namespace App\Exports;

use App\Models\SubEvent;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubEventsExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return SubEvent::select('title', 'place', 'start_datetime', 'end_datetime', 'description', 'bill_amount')->whereHas('submission', function ($q) {
            $q->where('uuid', request('submission_id'));
        })->get();
    }

    public function headings(): array
    {
        return ['Judul Acara', 'Tempat', 'Mulai', 'Selesai', 'Deskripsi', 'Jumlah Tagihan'];
    }
}
