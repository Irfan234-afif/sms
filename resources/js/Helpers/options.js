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

const responsibleFee = [
  { value: 'FATHER', label: 'Ayah' },
  { value: 'MOTHER', label: 'Ibu' },
  { value: 'OTHER', label: 'Lainnya' },
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
const achievementTypes = [
  { label: 'Siswa', value: 'STUDENT' },
  { label: 'Guru', value: 'TEACHER' },
];
const discountTypes = [
  { label: 'Persen', value: 'PERCENTAGE' },
  { label: 'Tetap', value: 'FIXED' },
];

const languageSkillLevel = [
  {
    label: 'Native',
    value: 'NATIVE',
  },
  {
    label: 'Intermediate',
    value: 'INTERMEDIATE',
  },
  {
    label: 'Beginner',
    value: 'BEGINNER',
  },
];

const familyRelationTypes = [
  { label: 'Suami', value: 'HUSBAND' },
  { label: 'Istri', value: 'WIFE' },
  { label: 'Anak', value: 'CHILD' },
  { label: 'Ayah', value: 'FATHER' },
  { label: 'Ibu', value: 'MOTHER' },
  { label: 'Saudara', value: 'SIBLING' },
];

const attendanceTypes = [
  { label: 'Terlambat', value: 'LATE' },
  { label: 'Pulang', value: 'HOME' },
  { label: 'Sakit', value: 'SICK' },
  { label: 'Izin', value: 'PERMIT' },
];

const transportationTypes = [
  { label: 'Mobil Sekolah', value: 'SCHOOL_BUS' },
  { label: 'Bus Kecil', value: 'SMALL_BUS' },
  { label: 'Bus Besar', value: 'LARGE_BUS' },
  { label: 'Angkutan Umum (Kota)', value: 'CITY_PUBLIC_TRANSPORT' },
  { label: 'Taksi Online', value: 'ONLINE_TAXI' },
  { label: 'Kendaraan Pribadi', value: 'PRIVATE_VEHICLE' },
  { label: 'Rental Mobil', value: 'CAR_RENTAL' },
  { label: 'Sepeda Motor Online (Ojek Online)', value: 'ONLINE_MOTORCYCLE_TAXI' },
  { label: 'Pesawat Terbang', value: 'AIRPLANE' },
  { label: 'Kapal/Ferry', value: 'FERRY' },
  { label: 'Kereta Api', value: 'TRAIN' },
];

const participantTypes = [
  { label: 'Siswa', value: 'STUDENT' },
  { label: 'Guru', value: 'TEACHER' },
  { label: 'Asisten Guru', value: 'TEACHER_ASSISTANT' },
  { label: 'Orangtua', value: 'PARENT' },
  { label: 'Fotografer/Videografer', value: 'PHOTOGRAPHER_VIDEOGRAPHER' },
  { label: 'Jurnalis/Reporter', value: 'JOURNALIST_REPORTER' },
  { label: 'Pengemudi/Driver', value: 'DRIVER' },
  { label: 'Petugas Keamanan', value: 'SECURITY_OFFICER' },
  { label: 'Ahli Subjek', value: 'SUBJECT_EXPERT' },
  { label: 'Pembicara Tamu', value: 'GUEST_SPEAKER' },
  { label: 'Donatur/Sponsor', value: 'DONOR_SPONSOR' },
  { label: 'Pengawas dari Eksternal', value: 'EXTERNAL_SUPERVISOR' },
  { label: 'Administrator Sekolah', value: 'SCHOOL_ADMINISTRATOR' },
  { label: 'Wakil Kepala Sekolah', value: 'VICE_PRINCIPAL' },
  { label: 'Kepala Sekolah', value: 'PRINCIPAL' },
  { label: 'Lainnya', value: 'OTHER' },
];

const materialStatuses = [
  { label: 'Draf', value: 'DRAFT' },
  { label: 'Menunggu', value: 'PENDING' },
  { label: 'Ditolak', value: 'REJECTED' },
  { label: 'Dipesan', value: 'ORDERED' },
  { label: 'Dikirim', value: 'DELIVERED' },
  { label: 'Diterima', value: 'RECEIVED' },
  { label: 'Dibatalkan', value: 'CANCELED' },
];

export {
  achievementTypes,
  admissionStagePostStatuses,
  admissionStagePreStatuses,
  attendanceTypes,
  bloodTypes,
  days,
  discountTypes,
  employeeStatus,
  familyRelationTypes,
  genders,
  languageSkillLevel,
  maritalStatuses,
  materialStatuses,
  participantTypes,
  religions,
  responsibleFee,
  schoolInformationSources,
  testimonialTypes,
  transportationTypes,
  units,
};
