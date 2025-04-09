<?php

namespace App\Exports;

use App\Models\Submission;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class SubMaterialExport implements FromCollection, WithHeadings, WithMapping
{
    public function __construct() {}

    public function collection()
    {
        $submissions = Submission::whereHas('group', function ($group) {
            $group->where('code', 'MATERIAL');
        });

        if (request()->has('status')) {
            $submissions->where('status', request('status'));
        }

        if (request()->has('from_date') && request()->has('to_date')) {
            $submissions->whereBetween('datetime', [request('from_date'), request('to_date')]);
        }

        return $submissions->limit(request('take'))->get();
    }

    public function headings(): array
    {
        return [
            'Nama Pemohon',
            'Nomor Referensi',
            'Tanggal Dikirim',
            'Status',
            'Nomor Registrasi',
            'Nama Barang',
            'Nomor Referensi Barang',
            'Kuantitas',
            'Satuan',
            'Referensi Pembelian',
            'Harga',
            'Total Biaya',
            'Tenggat Waktu',
            'Deskripsi',
            'Status Barang',
        ];
    }

    public function map($submission): array
    {
        $item = $submission->material->items()->first();

        return [
            $submission->submitter->profile->name,
            $submission->reference_number,
            $submission->datetime,
            $submission->status,
            $submission->registration_number,
            $item?->name,
            $item?->reference_number,
            $item?->quantity,
            $item?->unit,
            $item?->purchase_reference,
            $item?->price,
            $item?->bill_amount,
            $item?->due_date,
            $item?->description,
            $item?->status,
        ];
    }
}
