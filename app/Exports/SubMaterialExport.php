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
            'Harga',
            'Total Biaya',
            'Deskripsi',
            'Status Barang',
        ];
    }

    public function map($submission): array
    {
        return [
            $submission->submitter->profile->name,
            $submission->reference_number,
            $submission->datetime,
            $submission->status,
            $submission->registration_number,
            $submission->material->items()->first()->name,
            $submission->material->items()->first()->reference_number,
            $submission->material->items()->first()->quantity,
            $submission->material->items()->first()->unit,
            $submission->material->items()->first()->price,
            $submission->material->items()->first()->bill_amount,
            $submission->material->items()->first()->description,
            $submission->material->items()->first()->status,
        ];
    }
}
