<?php

namespace App\Exports;

use App\Models\SubEventItem;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubEventItemsExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return SubEventItem::select('name', 'quantity', 'unit', 'price', 'bill_amount', 'description')->whereHas('event.submission', function ($q) {
            $q->where('uuid', request('submission_id'));
        })->get();
    }

    public function headings(): array
    {
        return ['Nama Barang', 'Jumlah', 'Satuan', 'Harga per Unit', 'Total Tagihan', 'Deskripsi'];
    }
}
