const schoolInformationSources = [
    { label: 'Website Resmi Sekolah', value: 'SCHOOL_WEBSITE' },
    { label: 'Grup WhatsApp/Telegram Orang Tua & Siswa', value: 'CHAT_GROUP' },
    { label: 'Brosur & Buletin Sekolah', value: 'SCHOOL_BULLETIN' },
    { label: 'Papan Pengumuman Sekolah', value: 'NOTICE_BOARD' },
    { label: 'Surat Edaran Sekolah', value: 'CIRCULAR_LETTER' },
    { label: 'Pertemuan Orang Tua & Guru', value: 'PARENT_MEETING' },
    { label: 'Guru dan Staf Sekolah', value: 'TEACHERS_STAFF' },
    { label: 'Dinas Pendidikan Setempat', value: 'EDUCATION_DEPARTMENT' },
    { label: 'Media Cetak & Online', value: 'PRINT_MEDIA' },
    { label: 'Forum & Komunitas Pendidikan', value: 'EDUCATION_FORUM' },
];

const religions = [
    { value: 'ISLAM', label: 'Islam' },
    { value: 'CHRISTIAN', label: 'Kristen' },
    { value: 'CATHOLIC', label: 'Katolik' },
    { value: 'HINDU', label: 'Hindu' },
    { value: 'BUDDHIST', label: 'Buddha' },
    { value: 'CONFUCIAN', label: 'Konghucu' },
    { value: 'OTHER', label: 'Lainnya' },
];

const admissionStagePreStatuses = [
    { value: 'PENDING', label: 'Menunggu' },
    { value: 'INTERVIEW', label: 'Wawancara' },
    { value: 'PASSED', label: 'Lulus' },
    { value: 'FAILED', label: 'Gagal' },
];

const admissionStagePostStatuses = [
    { value: 'DOING', label: 'Sedang Berlangsung' },
    { value: 'DONE', label: 'Selesai' },
];

export { admissionStagePostStatuses, admissionStagePreStatuses, religions, schoolInformationSources };
