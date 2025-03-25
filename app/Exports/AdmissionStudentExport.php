<?php

namespace App\Exports;

use App\Helpers\GetLabel;
use App\Models\AdmissionStudent;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class AdmissionStudentExport implements FromCollection, WithHeadings, WithMapping
{
    protected $filters;

    public function __construct($filters = [])
    {
        $this->filters = $filters;
    }

    public function collection()
    {
        $query = AdmissionStudent::query();

        if (!empty($this->filters)) {
            foreach ($this->filters as $value) {
                if ($value !== null) {
                    $query->where($value);
                }
            }
        }

        return $query->get();
    }

    public function headings(): array
    {
        return [
            'Sekolah',
            'Tahun Ajaran',
            'Tingkat Kelas',
            'Nomor Registrasi',
            'Tanggal Dikirim',
            'Nama Lengkap',
            'Foto Siswa',
            'Tempat Lahir',
            'Tanggal Lahir',
            'Jenis Kelamin',
            'Golongan Darah',
            'Agama',
            'Bahasa yang Dikuasai',
            'Nomor Telepon',
            'Alamat',
            'Kode Pos',
            'Sekolah Sebelumnya',
            'Nama Ayah',
            'Foto Ayah',
            'Tempat Lahir Ayah',
            'Tanggal Lahir Ayah',
            'Agama Ayah',
            'Bahasa Ayah',
            'Telepon Ayah',
            'Email Ayah',
            'Alamat Ayah',
            'Pekerjaan Ayah',
            'Perusahaan Ayah',
            'Jabatan Ayah',
            'Nomor KTP Ayah',
            'Foto Ibu',
            'Nama Ibu',
            'Tempat Lahir Ibu',
            'Tanggal Lahir Ibu',
            'Agama Ibu',
            'Bahasa Ibu',
            'Telepon Ibu',
            'Email Ibu',
            'Alamat Ibu',
            'Pekerjaan Ibu',
            'Perusahaan Ibu',
            'Jabatan Ibu',
            'Nomor KTP Ibu',
            'Nama Darurat',
            'Telepon Darurat',
            'Telepon Rumah Darurat',
            'Hubungan Darurat',
            'Butuh Kendaraan',
            'Biaya Tanggung Jawab',
            'Nama Pembayar',
            'Telepon Rumah Pembayar',
            'Telepon Pembayar',
            'Email Pembayar',
            'Hubungan Pembayar',
            'Alamat Pembayar',
            'Perusahaan Pembayar',
            'Surat Keterangan Perusahaan Pembayar',
            'Catatan Kesehatan',
            'Riwayat Kesehatan Keluarga',
            'Menggunakan Asuransi',
            'Nama Asuransi',
            'Jaringan Asuransi',
            'Rumah Sakit Rekomendasi',
            'Nama Dokter',
            'Data Keluarga',
            'Kuesioner',
            'Lampiran Kartu Keluarga',
            'Lampiran KTP Ayah',
            'Lampiran KTP Ibu',
            'Lampiran Akta Kelahiran',
            'Lampiran Rapor Terakhir',
            'Lampiran Surat Sekolah Sebelumnya',
            'Sumber Informasi Sekolah',
            'Status Pendaftaran',
        ];
    }

    public function map($student): array
    {
        $baseUrl = config('app.url');

        return [
            $student->school->area->name,
            $student->school_year->name,
            $student->school_grade->title,
            $student->registration_number,
            $student->submitted_at,
            $student->name,
            $student->avatar ? $baseUrl . '/storage/avatars/' . $student->avatar : null,
            $student->birth_place,
            $student->birth_date,
            GetLabel::gender($student->gender),
            $student->blood_type,
            GetLabel::religion($student->religion),
            json_encode($student->languages),
            $student->phone,
            $student->address,
            $student->postal_code,
            $student->previous_school,
            $student->father_name,
            $student->father_avatar ? $baseUrl . '/storage/avatars/' . $student->father_avatar : null,
            $student->father_birth_place,
            $student->father_birth_date,
            GetLabel::religion($student->father_religion),
            json_encode($student->father_languages),
            $student->father_phone,
            $student->father_email,
            $student->father_address,
            $student->father_occupation,
            $student->father_company,
            $student->father_position,
            $student->father_national_id,
            $student->mother_avatar ? $baseUrl . '/storage/avatars/' . $student->mother_avatar : null,
            $student->mother_name,
            $student->mother_birth_place,
            $student->mother_birth_date,
            GetLabel::religion($student->mother_religion),
            json_encode($student->mother_languages),
            $student->mother_phone,
            $student->mother_email,
            $student->mother_address,
            $student->mother_occupation,
            $student->mother_company,
            $student->mother_position,
            $student->mother_national_id,
            $student->emergency_name,
            $student->emergency_phone,
            $student->emergency_home_phone,
            $student->emergency_relation,
            $student->need_vehicle,
            $student->responsible_fee,
            $student->payer_name,
            $student->payer_home_phone,
            $student->payer_phone,
            $student->payer_email,
            $student->payer_relation,
            $student->payer_address,
            $student->payer_company,
            $student->payer_company_letter,
            $student->health_info_remark,
            $student->health_relate_family,
            $student->use_insurance,
            $student->insurance_name,
            $student->insurance_network,
            $student->recomended_hospital,
            $student->doctor_name,
            json_encode($student->families),
            json_encode($student->questionnaires),
            $student->family_card_attachment ? $baseUrl . '/storage/attachments/' . $student->family_card_attachment : null,
            $student->father_id_card_attachment ? $baseUrl . '/storage/attachments/' . $student->father_id_card_attachment : null,
            $student->mother_id_card_attachment ? $baseUrl . '/storage/attachments/' . $student->mother_id_card_attachment : null,
            $student->birth_certificate_attachment ? $baseUrl . '/storage/attachments/' . $student->birth_certificate_attachment : null,
            $student->last_report_attachment ? $baseUrl . '/storage/attachments/' . $student->last_report_attachment : null,
            $student->previous_school_letter_attachment ? $baseUrl . '/storage/attachments/' . $student->previous_school_letter_attachment : null,
            json_encode($student->school_info_sources),
            $student->status,
        ];
    }
}
