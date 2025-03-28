<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\WithMultipleSheets;

class SubEventFullExport implements WithMultipleSheets
{
    public function sheets(): array
    {
        return [
            new SubEventsExport('Acara'),
            new SubEventObjectivesExport('Objectives'),
            new SubEventTransportationsExport('Transportasi'),
            new SubEventParticipantsExport('Peserta'),
            new SubEventItemsExport('Item'),
            new SubmissionsExport('Pengajuan'),
        ];
    }
}
