<?php

namespace App\Exports;

use App\Models\SubEventTransportation;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubEventTransportationsExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return SubEventTransportation::select('type', 'quantity', 'unit_cost')->whereHas('event.submission', function ($q) {
            $q->where('uuid', request('submission_id'));
        })->get();
    }

    public function headings(): array
    {
        return ['Jenis Transportasi', 'Jumlah', 'Biaya per Unit'];
    }
}
