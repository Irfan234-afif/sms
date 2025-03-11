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

const units = [
  { label: 'Buah', value: 'PIECE' },
  { label: 'Unit', value: 'UNIT' },
  { label: 'Lusin', value: 'DOZEN' },
  { label: 'Kodi', value: 'SCORE' },
  { label: 'Gross', value: 'GROSS' },
  { label: 'Gram', value: 'GRAM' },
  { label: 'Kilogram', value: 'KILOGRAM' },
  { label: 'Ton', value: 'TON' },
  { label: 'Liter', value: 'LITER' },
  { label: 'Mililiter', value: 'MILLILITER' },
  { label: 'Kiloliter', value: 'KILOLITER' },
  { label: 'Meter', value: 'METER' },
  { label: 'Sentimeter', value: 'CENTIMETER' },
  { label: 'Yard', value: 'YARD' },
  { label: 'Rim', value: 'REAM' },
  { label: 'Karung', value: 'SACK' },
  { label: 'Drum', value: 'DRUM' },
  { label: 'Galon', value: 'GALLON' },
];

const bloodTypes = ['A', 'B', 'AB', 'O'];

const employeeStatus = [
  { label: 'Tetap', value: 'PERMANENT' },
  { label: 'Kontrak', value: 'CONTRACT' },
  { label: 'Percobaan', value: 'PROBATION' },
  { label: 'Harian', value: 'DAILY' },
  { label: 'Paruh Waktu', value: 'PART_TIME' },
];

const genders = [
  {
    value: 'MALE',
    label: 'Laki-laki',
  },
  {
    value: 'FEMALE',
    label: 'Perempuan',
  },
];

const maritalStatuses = [
  { value: 'SINGLE', label: 'Belum Menikah' },
  { value: 'MARRIED', label: 'Menikah' },
  { value: 'WIDOWED', label: 'Duda/Janda' },
];

const days = [
  { label: 'Minggu', value: 'SUNDAY' },
  { label: 'Senin', value: 'MONDAY' },
  { label: 'Selasa', value: 'TUESDAY' },
  { label: 'Rabu', value: 'WEDNESDAY' },
  { label: 'Kamis', value: 'THURSDAY' },
  { label: 'Jumat', value: 'FRIDAY' },
  { label: 'Sabtu', value: 'SATURDAY' },
];

const testimonialTypes = [
  { label: 'Orang Tua', value: 'PARENT' },
  { label: 'Siswa', value: 'STUDENT' },
  { label: 'Guru', value: 'TEACHER' },
];

export {
  admissionStagePostStatuses,
  admissionStagePreStatuses,
  bloodTypes,
  days,
  employeeStatus,
  genders,
  maritalStatuses,
  religions,
  schoolInformationSources,
  testimonialTypes,
  units,
};
