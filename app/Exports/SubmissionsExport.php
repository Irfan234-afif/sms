<?php

namespace App\Exports;

use App\Models\Submission;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class SubmissionsExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        return Submission::select('reference_number', 'datetime', 'status')->where('uuid', request('submission_id'))->get();
    }

    public function headings(): array
    {
        return ['Nomor Referensi', 'Tanggal Waktu', 'Status'];
    }
}
