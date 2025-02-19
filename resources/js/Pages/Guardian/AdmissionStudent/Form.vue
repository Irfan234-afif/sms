<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { schoolInformationSources } from '@/Helpers/options';
import questionnaires from '@/Helpers/questionnaires';
import CenterLayout from '@/Layouts/CenterLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
import { ElNotification } from 'element-plus';
</script>

<script>
export default {
    props: {
        admission_student: Object,
    },
    data() {
        return {
            process: false,
            loaded: true,
            isValidStudentForm: true,
            isValidFamilyForm: true,
            isValidHealthForm: true,
            isValidAdditionalForm: true,
            isValidAttachmentForm: true,
            isValidSurveyForm: true,
            showSubmitSuccessAlert: false,
            activeForm: 0,

            avatarPreview: null,
            avatarFile: null,
            fileList: [],

            fatherAvatarPreview: null,
            fatherAvatarFile: null,
            fatherFileList: [],

            motherAvatarPreview: null,
            motherAvatarFile: null,
            motherFileList: [],

            familyCardPreview: null,
            familyCardFile: null,
            familyCardFileList: [],

            fatherIdCardPreview: null,
            fatherIdCardFile: null,
            fatherIdCardFileList: [],

            motherIdCardPreview: null,
            motherIdCardFile: null,
            motherIdCardFileList: [],

            birthCertificatePreview: null,
            birthCertificateFile: null,
            birthCertificateFileList: [],

            lastReportPreview: null,
            lastReportFile: null,
            lastReportFileList: [],

            previousSchoolLetterPreview: null,
            previousSchoolLetterFile: null,
            previousSchoolLetterFileList: [],

            studentForm: {
                admission_student_id: this.admission_student.data.uuid,
                name: this.admission_student.data.name,
                avatar: null,
                birth_place: null,
                birth_date: this.admission_student.data.birth_date,
                gender: null,
                blood_type: null,
                religion: null,
                languages: null,
                phone: null,
                address: null,
                postal_code: null,
                previous_school: null,
            },

            parentForm: {
                father_name: null,
                father_avatar: null,
                father_birth_place: null,
                father_birth_date: null,
                father_religion: null,
                father_languages: null,
                father_phone: null,
                father_email: null,
                father_address: null,
                father_occupation: null,
                father_company: null,
                father_position: null,
                father_national_id: null,

                mother_name: null,
                mother_avatar: null,
                mother_birth_place: null,
                mother_birth_date: null,
                mother_religion: null,
                mother_languages: null,
                mother_phone: null,
                mother_email: null,
                mother_address: null,
                mother_occupation: null,
                mother_company: null,
                mother_position: null,
                mother_national_id: null,
            },

            healthForm: {
                health_info_remark: null,
                health_relate_family: null,
                use_insurance: null,
                insurance_name: null,
                insurance_network: null,
                recomended_hospital: null,
                doctor_name: null,
                questionnaires: questionnaires,
            },

            additionalForm: {
                need_vehicle: null,

                emergency_name: null,
                emergency_phone: null,
                emergency_home_phone: null,
                emergency_relation: null,

                responsible_fee: null,
                payer_name: null,
                payer_home_phone: null,
                payer_phone: null,
                payer_email: null,
                payer_relation: null,
                payer_address: null,
                payer_company: null,
                payer_company_letter: null,

                families: [],
            },

            attachmentForm: {
                family_card_attachment: null,
                father_id_card_attachment: null,
                mother_id_card_attachment: null,
                birth_certificate_attachment: null,
                last_report_attachment: null,
                previous_school_letter_attachment: null,
            },

            surveyForm: {
                school_info_sources: [],
            },

            field: {
                name: {
                    label: 'Nama Lengkap',
                    rules: [fieldValidation.isRequired('Nama Lengkap')],
                    error: null,
                },
                avatar: {
                    label: 'Foto',
                    rules: [],
                    error: null,
                },
                birth_place: {
                    label: 'Tempat Lahir',
                    rules: [fieldValidation.isRequired('Tempat Lahir')],
                    error: null,
                },
                birth_date: {
                    label: 'Tanggal Lahir',
                    rules: [fieldValidation.isRequired('Tanggal Lahir')],
                    error: null,
                },
                gender: {
                    label: 'Jenis Kelamin',
                    rules: [fieldValidation.isRequired('Jenis Kelamin')],
                    error: null,
                    options: [
                        {
                            value: 'MALE',
                            label: 'Laki-laki',
                        },
                        {
                            value: 'FEMALE',
                            label: 'Perempuan',
                        },
                    ],
                },
                blood_type: {
                    label: 'Golongan Darah',
                    rules: [],
                    error: null,
                    options: ['A', 'B', 'AB', 'O'],
                },
                religion: {
                    label: 'Agama',
                    rules: [fieldValidation.isRequired('Agama')],
                    error: null,
                    options: [
                        { value: 'ISLAM', label: 'Islam' },
                        { value: 'CHRISTIAN', label: 'Kristen' },
                        { value: 'CATHOLIC', label: 'Katolik' },
                        { value: 'HINDU', label: 'Hindu' },
                        { value: 'BUDDHIST', label: 'Buddha' },
                        { value: 'CONFUCIAN', label: 'Konghucu' },
                        { value: 'OTHER', label: 'Lainnya' },
                    ],
                },
                languages: {
                    label: 'Bahasa yang Dikuasai',
                    rules: [],
                    error: null,
                    options: ['Indonesia', 'Inggris'],
                },
                phone: {
                    label: 'Nomor Telepon',
                    rules: [],
                    error: null,
                },
                address: {
                    label: 'Alamat',
                    rules: [fieldValidation.isRequired('Alamat')],
                    error: null,
                },
                postal_code: {
                    label: 'Kode Pos',
                    rules: [],
                    error: null,
                },
                previous_school: {
                    label: 'Sekolah Sebelumnya',
                    rules: [],
                    error: null,
                },
                father_name: {
                    label: 'Nama',
                    rules: [fieldValidation.isRequired('Nama')],
                    error: null,
                },
                father_avatar: {
                    label: 'Foto',
                    rules: [],
                    error: null,
                },
                father_birth_place: {
                    label: 'Tempat Lahir',
                    rules: [],
                    error: null,
                },
                father_birth_date: {
                    label: 'Tanggal Lahir',
                    rules: [],
                    error: null,
                },
                father_religion: {
                    label: 'Agama',
                    rules: [],
                    error: null,
                    options: [
                        { value: 'ISLAM', label: 'Islam' },
                        { value: 'CHRISTIAN', label: 'Kristen' },
                        { value: 'CATHOLIC', label: 'Katolik' },
                        { value: 'HINDU', label: 'Hindu' },
                        { value: 'BUDDHIST', label: 'Buddha' },
                        { value: 'CONFUCIAN', label: 'Konghucu' },
                        { value: 'OTHER', label: 'Lainnya' },
                    ],
                },
                father_languages: {
                    label: 'Bahasa yang Dikuasai',
                    rules: [],
                    error: null,
                    options: ['Indonesia', 'Inggris'],
                },
                father_phone: {
                    label: 'Nomor Telepon',
                    rules: [],
                    error: null,
                },
                father_email: {
                    label: 'Email',
                    rules: [],
                    error: null,
                },
                father_address: {
                    label: 'Alamat',
                    rules: [],
                    error: null,
                },
                father_occupation: {
                    label: 'Pekerjaan',
                    rules: [],
                    error: null,
                },
                father_company: {
                    label: 'Perusahaan',
                    rules: [],
                    error: null,
                },
                father_position: {
                    label: 'Jabatan',
                    rules: [],
                    error: null,
                },
                father_national_id: {
                    label: 'Nomor Kependudukan',
                    rules: [],
                    error: null,
                },
                mother_name: {
                    label: 'Nama',
                    rules: [fieldValidation.isRequired('Nama')],
                    error: null,
                },
                mother_avatar: {
                    label: 'Foto',
                    rules: [],
                    error: null,
                },
                mother_birth_place: {
                    label: 'Tempat Lahir',
                    rules: [],
                    error: null,
                },
                mother_birth_date: {
                    label: 'Tanggal Lahir',
                    rules: [],
                    error: null,
                },
                mother_religion: {
                    label: 'Agama',
                    rules: [],
                    error: null,
                    options: [
                        { value: 'ISLAM', label: 'Islam' },
                        { value: 'CHRISTIAN', label: 'Kristen' },
                        { value: 'CATHOLIC', label: 'Katolik' },
                        { value: 'HINDU', label: 'Hindu' },
                        { value: 'BUDDHIST', label: 'Buddha' },
                        { value: 'CONFUCIAN', label: 'Konghucu' },
                        { value: 'OTHER', label: 'Lainnya' },
                    ],
                },
                mother_languages: {
                    label: 'Bahasa yang Dikuasai',
                    rules: [],
                    error: null,
                    options: ['Indonesia', 'Inggris'],
                },
                mother_phone: {
                    label: 'Nomor Telepon',
                    rules: [],
                    error: null,
                },
                mother_email: {
                    label: 'Email',
                    rules: [],
                    error: null,
                },
                mother_address: {
                    label: 'Alamat',
                    rules: [],
                    error: null,
                },
                mother_occupation: {
                    label: 'Pekerjaan',
                    rules: [],
                    error: null,
                },
                mother_company: {
                    label: 'Perusahaan',
                    rules: [],
                    error: null,
                },
                mother_position: {
                    label: 'Jabatan',
                    rules: [],
                    error: null,
                },
                mother_national_id: {
                    label: 'Nomor Kependudukan',
                    rules: [],
                    error: null,
                },
                emergency_name: {
                    label: 'Nama',
                    rules: [fieldValidation.isRequired('Nama')],
                    error: null,
                },
                emergency_phone: {
                    label: 'Nomor Telepon',
                    rules: [fieldValidation.isRequired('Nomor Telepon')],
                    error: null,
                },
                emergency_home_phone: {
                    label: 'Nomor Telepon Rumah',
                    rules: [],
                    error: null,
                },
                emergency_relation: {
                    label: 'Hubungan dengan Siswa',
                    rules: [],
                    error: null,
                },
                need_vehicle: {
                    label: 'Membutuhkan Kendaraan Sekolah',
                    rules: [],
                    error: null,
                    options: ['Ya', 'Tidak'],
                },
                responsible_fee: {
                    label: 'Penanggung Biaya',
                    rules: [fieldValidation.isRequired('Penanggung Biaya')],
                    error: null,
                    options: [
                        { value: 'FATHER', label: 'Ayah' },
                        { value: 'MOTHER', label: 'Ibu' },
                        { value: 'OTHER', label: 'Lainnya' },
                    ],
                },
                payer_name: {
                    label: 'Nama',
                    rules: [],
                    error: null,
                },
                payer_home_phone: {
                    label: 'Nomor Telepon Rumah',
                    rules: [],
                    error: null,
                },
                payer_phone: {
                    label: 'Nomor Telepon',
                    rules: [],
                    error: null,
                },
                payer_email: {
                    label: 'Email',
                    rules: [],
                    error: null,
                },
                payer_relation: {
                    label: 'Hubungan dengan Siswa',
                    rules: [],
                    error: null,
                },
                payer_address: {
                    label: 'Alamat',
                    rules: [],
                    error: null,
                },
                payer_company: {
                    label: 'Perusahaan',
                    rules: [],
                    error: null,
                },
                payer_company_letter: {
                    label: 'Surat Keterangan dari Perusahaan',
                    rules: [],
                    error: null,
                },
                health_info_remark: {
                    label: 'Keterangan Kesehatan',
                    rules: [],
                    error: null,
                },
                health_relate_family: {
                    label: 'Riwayat Penyakit Keluarga',
                    rules: [],
                    error: null,
                },
                use_insurance: {
                    label: 'Menggunakan Asuransi',
                    rules: [],
                    error: null,
                },
                insurance_name: {
                    label: 'Asuransi',
                    rules: [],
                    error: null,
                },
                insurance_network: {
                    label: 'Jaringan Asuransi',
                    rules: [],
                    error: null,
                },
                recomended_hospital: {
                    label: 'Rumah Sakit Rujukan',
                    rules: [],
                    error: null,
                },
                doctor_name: {
                    label: 'Nama Dokter',
                    rules: [],
                    error: null,
                },
                family_card_attachment: {
                    label: 'Kartu Keluarga',
                    rules: [],
                    error: null,
                },

                father_id_card_attachment: {
                    label: 'Kartu Tanda Penduduk Ayah',
                    rules: [],
                    error: null,
                },

                mother_id_card_attachment: {
                    label: 'Kartu Tanda Penduduk Ibu',
                    rules: [],
                    error: null,
                },

                birth_certificate_attachment: {
                    label: 'Akta Kelahiran',
                    rules: [],
                    error: null,
                },

                last_report_attachment: {
                    label: 'Raport Terakhir',
                    rules: [],
                    error: null,
                },

                previous_school_letter_attachment: {
                    label: 'Surat Pindah Sekolah',
                    rules: [],
                    error: null,
                },
                school_info_sources: {
                    label: 'Sumber Informasi Sekolah',
                    rules: [],
                    error: null,
                    options: schoolInformationSources,
                },
            },
        };
    },
    created() {
        if (this.admission_student.data) {
            // set studentForm
            this.studentForm.admission_student_id = this.admission_student.data.uuid;
            this.studentForm.name = this.admission_student.data.name;
            this.studentForm.avatar = this.admission_student.data.avatar;
            if (this.admission_student.data.avatar) {
                this.avatarPreview = this.admission_student.data.avatar_path;
            }
            this.studentForm.birth_place = this.admission_student.data.birth_place;
            this.studentForm.birth_date = this.admission_student.data.birth_date;
            this.studentForm.gender = this.admission_student.data.gender;
            this.studentForm.blood_type = this.admission_student.data.blood_type;
            this.studentForm.religion = this.admission_student.data.religion;
            this.studentForm.languages = this.admission_student.data.languages;
            if (this.admission_student.data.languages) {
                this.field.languages.options = this.admission_student.data.languages;
            }
            this.studentForm.phone = this.admission_student.data.phone;
            this.studentForm.address = this.admission_student.data.address;
            this.studentForm.postal_code = this.admission_student.data.postal_code;
            this.studentForm.previous_school = this.admission_student.data.previous_school;
            // set parentForm
            this.parentForm.father_name = this.admission_student.data.father_name;
            this.parentForm.father_avatar = this.admission_student.data.father_avatar;
            if (this.admission_student.data.father_avatar) {
                this.fatherAvatarPreview = this.admission_student.data.father_avatar_path;
            }
            this.parentForm.father_birth_place = this.admission_student.data.father_birth_place;
            this.parentForm.father_birth_date = this.admission_student.data.father_birth_date;
            this.parentForm.father_religion = this.admission_student.data.father_religion;
            this.parentForm.father_languages = this.admission_student.data.father_languages;
            if (this.admission_student.data.father_languages) {
                this.field.father_languages.options = this.admission_student.data.father_languages;
            }
            this.parentForm.father_phone = this.admission_student.data.father_phone;
            this.parentForm.father_email = this.admission_student.data.father_email;
            this.parentForm.father_address = this.admission_student.data.father_address;
            this.parentForm.father_occupation = this.admission_student.data.father_occupation;
            this.parentForm.father_company = this.admission_student.data.father_company;
            this.parentForm.father_position = this.admission_student.data.father_position;
            this.parentForm.father_national_id = this.admission_student.data.father_national_id;

            this.parentForm.mother_name = this.admission_student.data.mother_name;
            this.parentForm.mother_avatar = this.admission_student.data.mother_avatar;
            if (this.admission_student.data.mother_avatar) {
                this.motherAvatarPreview = this.admission_student.data.mother_avatar_path;
            }
            this.parentForm.mother_birth_place = this.admission_student.data.mother_birth_place;
            this.parentForm.mother_birth_date = this.admission_student.data.mother_birth_date;
            this.parentForm.mother_religion = this.admission_student.data.mother_religion;
            this.parentForm.mother_languages = this.admission_student.data.mother_languages;
            if (this.admission_student.data.mother_languages) {
                this.field.mother_languages.options = this.admission_student.data.mother_languages;
            }
            this.parentForm.mother_phone = this.admission_student.data.mother_phone;
            this.parentForm.mother_email = this.admission_student.data.mother_email;
            this.parentForm.mother_address = this.admission_student.data.mother_address;
            this.parentForm.mother_occupation = this.admission_student.data.mother_occupation;
            this.parentForm.mother_company = this.admission_student.data.mother_company;
            this.parentForm.mother_position = this.admission_student.data.mother_position;
            this.parentForm.mother_national_id = this.admission_student.data.mother_national_id;
            // set healthForm
            this.healthForm.health_info_remark = this.admission_student.data.health_info_remark;
            this.healthForm.health_relate_family = this.admission_student.data.health_relate_family;
            this.healthForm.use_insurance = this.admission_student.data.use_insurance;
            this.healthForm.insurance_name = this.admission_student.data.insurance_name;
            this.healthForm.insurance_network = this.admission_student.data.insurance_network;
            this.healthForm.recomended_hospital = this.admission_student.data.recomended_hospital;
            this.healthForm.doctor_name = this.admission_student.data.doctor_name;
            this.healthForm.questionnaires = this.admission_student.data.questionnaires ?? questionnaires;
            // set additionalForm
            this.additionalForm.need_vehicle = this.admission_student.data.need_vehicle;

            this.additionalForm.emergency_name = this.admission_student.data.emergency_name;
            this.additionalForm.emergency_phone = this.admission_student.data.emergency_phone;
            this.additionalForm.emergency_home_phone = this.admission_student.data.emergency_home_phone;
            this.additionalForm.emergency_relation = this.admission_student.data.emergency_relation;

            this.additionalForm.responsible_fee = this.admission_student.data.responsible_fee;
            this.additionalForm.payer_name = this.admission_student.data.payer_name;
            this.additionalForm.payer_home_phone = this.admission_student.data.payer_home_phone;
            this.additionalForm.payer_phone = this.admission_student.data.payer_phone;
            this.additionalForm.payer_email = this.admission_student.data.payer_email;
            this.additionalForm.payer_relation = this.admission_student.data.payer_relation;
            this.additionalForm.payer_address = this.admission_student.data.payer_address;
            this.additionalForm.payer_company = this.admission_student.data.payer_company;
            this.additionalForm.payer_company_letter = this.admission_student.data.payer_company_letter;
            // set attachmentForm
            this.attachmentForm.family_card_attachment = this.admission_student.data.family_card_attachment;
            if (this.admission_student.data.family_card_attachment) {
                this.familyCardPreview = this.admission_student.data.family_card_attachment_path;
            }
            this.attachmentForm.father_id_card_attachment = this.admission_student.data.father_id_card_attachment;
            if (this.admission_student.data.father_id_card_attachment) {
                this.fatherIdCardPreview = this.admission_student.data.father_id_card_attachment_path;
            }
            this.attachmentForm.mother_id_card_attachment = this.admission_student.data.mother_id_card_attachment;
            if (this.admission_student.data.mother_id_card_attachment) {
                this.motherIdCardPreview = this.admission_student.data.mother_id_card_attachment_path;
            }
            this.attachmentForm.birth_certificate_attachment = this.admission_student.data.birth_certificate_attachment;
            if (this.admission_student.data.birth_certificate_attachment) {
                this.birthCertificatePreview = this.admission_student.data.birth_certificate_attachment_path;
            }
            this.attachmentForm.last_report_attachment = this.admission_student.data.last_report_attachment;
            if (this.admission_student.data.last_report_attachment) {
                this.lastReportPreview = this.admission_student.data.last_report_attachment_path;
            }
            this.attachmentForm.previous_school_letter_attachment =
                this.admission_student.data.previous_school_letter_attachment;
            if (this.admission_student.data.previous_school_letter_attachment) {
                this.previousSchoolLetterPreview = this.admission_student.data.previous_school_letter_attachment_path;
            }

            this.additionalForm.families = this.admission_student.data.families;
            // set surveyForm
            this.surveyForm.school_info_sources = this.admission_student.data.school_info_sources;
        }
    },
    methods: {
        async submit() {
            await this.validateAllForm();
            if (
                this.isValidStudentForm &&
                this.isValidFamilyForm &&
                this.isValidHealthForm &&
                this.isValidAdditionalForm &&
                this.isValidAttachmentForm &&
                this.isValidSurveyForm
            ) {
                this.process = true;
                const mergedForm = Object.assign(
                    {},
                    this.studentForm,
                    this.parentForm,
                    this.healthForm,
                    this.additionalForm,
                    this.attachmentForm,
                    this.surveyForm,
                );

                const formData = new FormData();
                formData.append('avatar_file', this.avatarFile);
                formData.append('father_avatar_file', this.fatherAvatarFile);
                formData.append('mother_avatar_file', this.motherAvatarFile);
                formData.append('family_card_file', this.familyCardFile);
                formData.append('father_id_card_file', this.fatherIdCardFile);
                formData.append('mother_id_card_file', this.motherIdCardFile);
                formData.append('birth_certificate_file', this.birthCertificateFile);
                formData.append('last_report_file', this.lastReportFile);
                formData.append('previous_school_letter_file', this.previousSchoolLetterFile);
                formData.append('full_form_data', JSON.stringify(mergedForm));

                axios
                    .post(route('guardian.admissionStudent.submit'), formData, {
                        headers: { 'Content-Type': 'multipart/form-data' },
                    })
                    .then((response) => {
                        if (response.data.status === 'success') {
                            ElNotification({
                                title: 'Berhasil',
                                message: response.data.message,
                                type: 'success',
                            });

                            this.showSubmitSuccessAlert = true;
                        } else if (response.data.status === 'error') {
                            ElNotification({
                                title: 'Error',
                                message: response.data.message,
                                type: 'error',
                            });
                        }
                    })
                    .catch((error) => {
                        let errorMessage = 'Terjadi kesalahan.';

                        if (error.response) {
                            switch (error.response.status) {
                                case 404:
                                    errorMessage = error.response.data?.message || 'Data tidak ditemukan.';
                                    break;
                                case 422:
                                    this.handleValidationErrors(error.response.data.errors);
                                    break;
                                default:
                                    errorMessage = error.response.data?.message || errorMessage;
                            }
                        }

                        ElNotification({ title: 'Error', message: errorMessage, type: 'error' });
                    })
                    .finally(() => {
                        this.process = false;
                    });
            }
        },
        getFormLabel(activeForm) {
            switch (activeForm) {
                case 0:
                    return 'Informasi Siswa';
                case 1:
                    return 'Informasi Orang Tua / Wali';
                case 2:
                    return 'Informasi Dukungan';
                case 3:
                    return 'Riwayat Kesehatan';
                case 4:
                    return 'Lampiran';
                case 5:
                    return 'Survei Sekolah';
                default:
                    return '-';
            }
        },
        moveToForm(activeForm) {
            this.activeForm = activeForm;
        },
        scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth',
            });
        },
        handleValidationErrors(errors) {
            Object.keys(errors).forEach((field) => {
                if (this.field?.[field]) {
                    this.field[field].error = errors[field];
                }
            });

            this.$refs['studentForm']?.validate();
            this.$refs['parentForm']?.validate();
            this.$refs['healthForm']?.validate();
            this.$refs['additionalForm']?.validate();
            this.$refs['attachmentForm']?.validate();
            this.$refs['surveyForm']?.validate();
        },
        async validateAllForm() {
            await this.$refs['studentForm'].validate((valid) => {
                this.isValidStudentForm = valid;
            });
            await this.$refs['parentForm'].validate((valid) => {
                this.isValidFamilyForm = valid;
            });
            await this.$refs['healthForm'].validate((valid) => {
                this.isValidHealthForm = valid;
            });
            await this.$refs['additionalForm'].validate((valid) => {
                this.isValidAdditionalForm = valid;
            });
            await this.$refs['attachmentForm'].validate((valid) => {
                this.isValidAttachmentForm = valid;
            });
            await this.$refs['surveyForm'].validate((valid) => {
                this.isValidSurveyForm = valid;
            });
        },
        handleFileChange(file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                this.avatarPreview = e.target.result;
            };
            reader.readAsDataURL(file.raw);

            this.studentForm.avatar = null;
            this.avatarFile = file.raw;
        },
        handleFatherFileChange(file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                this.avatarFatherPreview = e.target.result;
            };
            reader.readAsDataURL(file.raw);

            this.parentForm.father_avatar = null;
            this.avatarFatherFile = file.raw;
        },
        handleMotherFileChange(file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                this.avatarMotherPreview = e.target.result;
            };
            reader.readAsDataURL(file.raw);

            this.parentForm.mother_avatar = null;
            this.avatarMotherFile = file.raw;
        },
        handleFamilyCardFileChange(event) {
            this.attachmentForm.family_card_attachment = null;
            this.familyCardFile = event.target.files[0];
        },

        handleFatherIdCardFileChange(event) {
            this.attachmentForm.father_id_card_attachment = null;
            this.fatherIdCardFile = event.target.files[0];
        },

        handleMotherIdCardFileChange(event) {
            this.attachmentForm.mother_id_card_attachment = null;
            this.motherIdCardFile = event.target.files[0];
        },

        handleBirthCertificateFileChange(event) {
            this.attachmentForm.birth_certificate_attachment = null;
            this.birthCertificateFile = event.target.files[0];
        },

        handleLastReportFileChange(event) {
            this.attachmentForm.last_report_attachment = null;
            this.lastReportFile = event.target.files[0];
        },

        handlePreviousSchoolLetterFileChange(event) {
            this.attachmentForm.previous_school_letter_attachment = null;
            this.previousSchoolLetterFile = event.target.files[0];
        },
    },
};
</script>

<template>
    <Head title="Wali" />

    <CenterLayout>
        <template #content>
            <!-- Data -->
            <section class="bg-white antialiased shadow-md dark:bg-gray-900 sm:rounded-lg">
                <div
                    class="flex flex-col justify-center space-y-3 p-4 md:flex-row md:items-center md:space-x-4 md:space-y-0"
                >
                    <div class="flex items-center justify-center space-x-2">
                        <h5>
                            <span class="text-xl font-bold text-gray-900"
                                >Formulir {{ admission_student.data.school.area.name }}</span
                            >
                        </h5>
                    </div>
                </div>
                <!-- Form -->
                <div class="mx-8 space-y-6 py-6" v-if="!showSubmitSuccessAlert">
                    <!-- stepper -->
                    <ol class="mb-4 flex w-full items-center sm:mb-5">
                        <!-- Step 1 -->
                        <li
                            class="flex w-full items-center after:inline-block after:h-1 after:w-full after:border-4 after:border-b after:content-['']"
                            :class="{
                                'after:border-blue-100 dark:after:border-blue-800':
                                    isValidStudentForm && activeForm > 0,
                                'after:border-red-100 dark:after:border-red-800': !isValidStudentForm && activeForm > 0,
                                'after:border-gray-100 dark:after:border-gray-700': activeForm <= 0,
                            }"
                        >
                            <button
                                type="button"
                                @click="moveToForm(0)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': isValidStudentForm,
                                    'bg-red-100 dark:bg-red-800': !isValidStudentForm,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidStudentForm,
                                        'text-red-600 dark:text-red-300': !isValidStudentForm,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                                    <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                </svg>
                            </button>
                        </li>
                        <!-- Step 2 -->
                        <li
                            class="flex w-full items-center after:inline-block after:h-1 after:w-full after:border-4 after:border-b after:content-['']"
                            :class="{
                                'after:border-blue-100 dark:after:border-blue-800': isValidFamilyForm && activeForm > 1,
                                'after:border-red-100 dark:after:border-red-800': !isValidFamilyForm && activeForm > 1,
                                'after:border-gray-100 dark:after:border-gray-700': activeForm <= 1,
                            }"
                        >
                            <button
                                type="button"
                                @click="moveToForm(1)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': isValidFamilyForm && activeForm >= 1,
                                    'bg-red-100 dark:bg-red-800': !isValidFamilyForm && activeForm >= 1,
                                    'bg-gray-100 dark:bg-gray-700': activeForm < 1,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidFamilyForm && activeForm >= 1,
                                        'text-red-600 dark:text-red-300': !isValidFamilyForm && activeForm >= 1,
                                        'bg-gray-100 dark:bg-gray-700': activeForm < 1,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" />
                                    <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                    <path d="M21 21v-2a4 4 0 0 0 -3 -3.85" />
                                </svg>
                            </button>
                        </li>
                        <!-- Step 3 -->
                        <li
                            class="flex w-full items-center after:inline-block after:h-1 after:w-full after:border-4 after:border-b after:content-['']"
                            :class="{
                                'after:border-blue-100 dark:after:border-blue-800':
                                    isValidAdditionalForm && activeForm > 2,
                                'after:border-red-100 dark:after:border-red-800':
                                    !isValidAdditionalForm && activeForm > 2,
                                'after:border-gray-100 dark:after:border-gray-700': activeForm <= 2,
                            }"
                        >
                            <button
                                type="button"
                                @click="moveToForm(2)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': isValidAdditionalForm && activeForm >= 2,
                                    'bg-red-100 dark:bg-red-800': !isValidAdditionalForm && activeForm >= 2,
                                    'bg-gray-100 dark:bg-gray-700': activeForm < 2,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidAdditionalForm && activeForm >= 2,
                                        'text-red-600 dark:text-red-300': !isValidAdditionalForm && activeForm >= 2,
                                        'bg-gray-100 dark:bg-gray-700': activeForm < 2,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path
                                        d="M7 3m0 2.667a2.667 2.667 0 0 1 2.667 -2.667h8.666a2.667 2.667 0 0 1 2.667 2.667v8.666a2.667 2.667 0 0 1 -2.667 2.667h-8.666a2.667 2.667 0 0 1 -2.667 -2.667z"
                                    />
                                    <path
                                        d="M4.012 7.26a2.005 2.005 0 0 0 -1.012 1.737v10c0 1.1 .9 2 2 2h10c.75 0 1.158 -.385 1.5 -1"
                                    />
                                    <path d="M11 7h5" />
                                    <path d="M11 10h6" />
                                    <path d="M11 13h3" />
                                </svg>
                            </button>
                        </li>
                        <!-- Step 4 -->
                        <li
                            class="flex w-full items-center after:inline-block after:h-1 after:w-full after:border-4 after:border-b after:content-['']"
                            :class="{
                                'after:border-blue-100 dark:after:border-blue-800': isValidHealthForm && activeForm > 3,
                                'after:border-red-100 dark:after:border-red-800': !isValidHealthForm && activeForm > 3,
                                'after:border-gray-100 dark:after:border-gray-700': activeForm <= 3,
                            }"
                        >
                            <button
                                type="button"
                                @click="moveToForm(3)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': isValidHealthForm && activeForm >= 3,
                                    'bg-red-100 dark:bg-red-800': !isValidHealthForm && activeForm >= 3,
                                    'bg-gray-100 dark:bg-gray-700': activeForm < 3,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidHealthForm && activeForm >= 3,
                                        'text-red-600 dark:text-red-300': !isValidHealthForm && activeForm >= 3,
                                        'bg-gray-100 dark:bg-gray-700': activeForm < 3,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M8 8v-2a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v2" />
                                    <path
                                        d="M4 8m0 2a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2z"
                                    />
                                    <path d="M10 14h4" />
                                    <path d="M12 12v4" />
                                </svg>
                            </button>
                        </li>
                        <!-- Step 5 -->
                        <li
                            class="flex w-full items-center after:inline-block after:h-1 after:w-full after:border-4 after:border-b after:content-['']"
                            :class="{
                                'after:border-blue-100 dark:after:border-blue-800':
                                    isValidAttachmentForm && activeForm > 4,
                                'after:border-red-100 dark:after:border-red-800':
                                    !isValidAttachmentForm && activeForm > 4,
                                'after:border-gray-100 dark:after:border-gray-700': activeForm <= 4,
                            }"
                        >
                            <button
                                type="button"
                                @click="moveToForm(4)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': isValidAttachmentForm && activeForm >= 4,
                                    'bg-red-100 dark:bg-red-800': !isValidAttachmentForm && activeForm >= 4,
                                    'bg-gray-100 dark:bg-gray-700': activeForm < 4,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidAttachmentForm && activeForm >= 4,
                                        'text-red-600 dark:text-red-300': !isValidAttachmentForm && activeForm >= 4,
                                        'bg-gray-100 dark:bg-gray-700': activeForm < 4,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path
                                        d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                                    />
                                </svg>
                            </button>
                        </li>
                        <!-- Step 6 -->
                        <li class="flex items-center">
                            <button
                                type="button"
                                @click="moveToForm(5)"
                                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full lg:h-12 lg:w-12"
                                :class="{
                                    'bg-blue-100 dark:bg-blue-800': activeForm >= 5,
                                    'bg-gray-100 dark:bg-gray-700': activeForm < 5,
                                }"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-4 w-4 lg:h-6 lg:w-6"
                                    :class="{
                                        'text-blue-600 dark:text-blue-300': isValidHealthForm && activeForm >= 5,
                                        'bg-gray-100 dark:bg-gray-700': activeForm < 5,
                                    }"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M12 15l8.385 -8.415a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3z" />
                                    <path d="M16 5l3 3" />
                                    <path d="M9 7.07a7 7 0 0 0 1 13.93a7 7 0 0 0 6.929 -6" />
                                </svg>
                            </button>
                        </li>
                    </ol>
                    <!-- form session -->
                    <div class="space-y-6">
                        <h2 class="border-b pb-4 text-lg font-bold text-gray-900">
                            {{ getFormLabel(activeForm) }}
                        </h2>
                        <!-- student form -->
                        <div v-show="activeForm == 0">
                            <el-form
                                v-if="loaded"
                                ref="studentForm"
                                label-position="top"
                                :model="studentForm"
                                :disabled="process"
                                class="grid grid-cols-1 gap-x-4 md:grid-cols-2"
                            >
                                <el-form-item
                                    class="font-bold"
                                    :label="field.avatar.label"
                                    :rules="field.avatar.rules"
                                    :error="field.avatar.error"
                                    prop="avatar"
                                >
                                    <el-upload
                                        class="avatar-uploader"
                                        action="#"
                                        :auto-upload="false"
                                        :show-file-list="false"
                                        :on-change="handleFileChange"
                                    >
                                        <img
                                            v-if="avatarPreview"
                                            :src="avatarPreview"
                                            class="flex h-28 w-28 rounded-lg object-cover"
                                        />
                                        <div
                                            v-else
                                            class="flex h-28 w-28 items-center justify-center rounded-lg bg-gray-100"
                                        >
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                viewBox="0 0 24 24"
                                                fill="none"
                                                stroke="currentColor"
                                                stroke-width="1.5"
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                class="h-16 w-16 text-gray-500"
                                            >
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                                                <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                            </svg>
                                        </div>
                                    </el-upload>
                                </el-form-item>

                                <div class="invisble"></div>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.name.label"
                                    :rules="field.name.rules"
                                    :error="field.name.error"
                                    prop="name"
                                >
                                    <el-input v-model="studentForm.name" autocomplete="off" />
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.birth_place.label"
                                    :rules="field.birth_place.rules"
                                    :error="field.birth_place.error"
                                    prop="birth_place"
                                >
                                    <el-input v-model="studentForm.birth_place" autocomplete="off" />
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.birth_date.label"
                                    :rules="field.birth_date.rules"
                                    :error="field.birth_date.error"
                                    prop="birth_date"
                                >
                                    <el-date-picker
                                        v-model="studentForm.birth_date"
                                        type="date"
                                        format="DD-MM-YYYY"
                                        value-format="YYYY-MM-DD"
                                    />
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.gender.label"
                                    :rules="field.gender.rules"
                                    :error="field.gender.error"
                                    prop="gender"
                                >
                                    <el-radio-group v-model="studentForm.gender">
                                        <el-radio
                                            v-for="option in field.gender.options"
                                            :key="option.value"
                                            :value="option.value"
                                            >{{ option.label }}</el-radio
                                        >
                                    </el-radio-group>
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.blood_type.label"
                                    :rules="field.blood_type.rules"
                                    :error="field.blood_type.error"
                                    prop="blood_type"
                                >
                                    <el-select v-model="studentForm.blood_type" placeholder="Pilih golongan darah">
                                        <el-option label="A" value="A" />
                                        <el-option label="B" value="B" />
                                        <el-option label="AB" value="AB" />
                                        <el-option label="O" value="O" />
                                    </el-select>
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.religion.label"
                                    :rules="field.religion.rules"
                                    :error="field.religion.error"
                                    prop="religion"
                                >
                                    <el-select
                                        v-model="studentForm.religion"
                                        :placeholder="`Pilih ${field.religion.label}`"
                                        clearable
                                    >
                                        <el-option
                                            v-for="option in field.religion.options"
                                            :key="option.value"
                                            :label="option.label"
                                            :value="option.value"
                                        />
                                    </el-select>
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.languages.label"
                                    :rules="field.languages.rules"
                                    :error="field.languages.error"
                                    prop="languages"
                                >
                                    <el-select
                                        v-model="studentForm.languages"
                                        multiple
                                        filterable
                                        allow-create
                                        default-first-option
                                        :reserve-keyword="false"
                                        :placeholder="`Pilih ${field.languages.label}`"
                                    >
                                        <el-option
                                            v-for="option in field.languages.options"
                                            :key="option"
                                            :label="option"
                                            :value="option"
                                        />
                                    </el-select>
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.phone.label"
                                    :rules="field.phone.rules"
                                    :error="field.phone.error"
                                    prop="phone"
                                >
                                    <el-input v-model="studentForm.phone" autocomplete="off" />
                                </el-form-item>

                                <el-form-item
                                    class="font-bold md:col-span-2"
                                    :label="field.address.label"
                                    :rules="field.address.rules"
                                    :error="field.address.error"
                                    prop="address"
                                >
                                    <el-input v-model="studentForm.address" type="textarea" />
                                </el-form-item>

                                <el-form-item
                                    class="font-bold"
                                    :label="field.postal_code.label"
                                    :rules="field.postal_code.rules"
                                    :error="field.postal_code.error"
                                    prop="postal_code"
                                >
                                    <el-input v-model="studentForm.postal_code" autocomplete="off" />
                                </el-form-item>
                            </el-form>
                        </div>
                        <!-- parent form -->
                        <div v-show="activeForm == 1">
                            <el-form
                                v-if="loaded"
                                ref="parentForm"
                                label-position="top"
                                :model="parentForm"
                                :disabled="process"
                            >
                                <!-- Father Information -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Ayah</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_avatar.label"
                                        :rules="field.father_avatar.rules"
                                        :error="field.father_avatar.error"
                                        prop="father_avatar"
                                    >
                                        <el-upload
                                            class="avatar-uploader"
                                            action="#"
                                            :auto-upload="false"
                                            :show-file-list="false"
                                            :on-change="handleFatherFileChange"
                                        >
                                            <img
                                                v-if="fatherAvatarPreview"
                                                :src="fatherAvatarPreview"
                                                class="flex h-28 w-28 rounded-lg object-cover"
                                            />
                                            <div
                                                v-else
                                                class="flex h-28 w-28 items-center justify-center rounded-lg bg-gray-100"
                                            >
                                                <svg
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 24 24"
                                                    fill="none"
                                                    stroke="currentColor"
                                                    stroke-width="1.5"
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    class="h-16 w-16 text-gray-500"
                                                >
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                    <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                                                    <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                                </svg>
                                            </div>
                                        </el-upload>
                                    </el-form-item>

                                    <div class="invisble"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_name.label"
                                        :rules="field.father_name.rules"
                                        :error="field.father_name.error"
                                        prop="father_name"
                                    >
                                        <el-input v-model="parentForm.father_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_national_id.label"
                                        :rules="field.father_national_id.rules"
                                        :error="field.father_national_id.error"
                                        prop="father_national_id"
                                    >
                                        <el-input v-model="parentForm.father_national_id" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_birth_place.label"
                                        :rules="field.father_birth_place.rules"
                                        :error="field.father_birth_place.error"
                                        prop="father_birth_place"
                                    >
                                        <el-input v-model="parentForm.father_birth_place" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_birth_date.label"
                                        :rules="field.father_birth_date.rules"
                                        :error="field.father_birth_date.error"
                                        prop="father_birth_date"
                                    >
                                        <el-date-picker
                                            v-model="parentForm.father_birth_date"
                                            type="date"
                                            format="DD-MM-YYYY"
                                            value-format="YYYY-MM-DD"
                                        />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_religion.label"
                                        :rules="field.father_religion.rules"
                                        :error="field.father_religion.error"
                                        prop="father_religion"
                                    >
                                        <el-select
                                            v-model="parentForm.father_religion"
                                            :placeholder="`Pilih ${field.father_religion.label}`"
                                            clearable
                                        >
                                            <el-option
                                                v-for="option in field.father_religion.options"
                                                :key="option.value"
                                                :label="option.label"
                                                :value="option.value"
                                            />
                                        </el-select>
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_languages.label"
                                        :rules="field.father_languages.rules"
                                        :error="field.father_languages.error"
                                        prop="father_languages"
                                    >
                                        <el-select
                                            v-model="parentForm.father_languages"
                                            multiple
                                            filterable
                                            allow-create
                                            default-first-option
                                            :reserve-keyword="false"
                                            :placeholder="`Pilih ${field.father_languages.label}`"
                                        >
                                            <el-option
                                                v-for="option in field.father_languages.options"
                                                :key="option"
                                                :label="option"
                                                :value="option"
                                            />
                                        </el-select>
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_phone.label"
                                        :rules="field.father_phone.rules"
                                        :error="field.father_phone.error"
                                        prop="father_phone"
                                    >
                                        <el-input v-model="parentForm.father_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_email.label"
                                        :rules="field.father_email.rules"
                                        :error="field.father_email.error"
                                        prop="father_email"
                                    >
                                        <el-input v-model="parentForm.father_email" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_address.label"
                                        :rules="field.father_address.rules"
                                        :error="field.father_address.error"
                                        prop="father_address"
                                    >
                                        <el-input
                                            type="textarea"
                                            v-model="parentForm.father_address"
                                            autocomplete="off"
                                        />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_occupation.label"
                                        :rules="field.father_occupation.rules"
                                        :error="field.father_occupation.error"
                                        prop="father_occupation"
                                    >
                                        <el-input v-model="parentForm.father_occupation" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_company.label"
                                        :rules="field.father_company.rules"
                                        :error="field.father_company.error"
                                        prop="father_company"
                                    >
                                        <el-input v-model="parentForm.father_company" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_position.label"
                                        :rules="field.father_position.rules"
                                        :error="field.father_position.error"
                                        prop="father_position"
                                    >
                                        <el-input v-model="parentForm.father_position" autocomplete="off" />
                                    </el-form-item>
                                </div>
                                <!-- Mother Information -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Ibu</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_avatar.label"
                                        :rules="field.mother_avatar.rules"
                                        :error="field.mother_avatar.error"
                                        prop="mother_avatar"
                                    >
                                        <el-upload
                                            class="avatar-uploader"
                                            action="#"
                                            :auto-upload="false"
                                            :show-file-list="false"
                                            :on-change="handleMotherFileChange"
                                        >
                                            <img
                                                v-if="motherAvatarPreview"
                                                :src="motherAvatarPreview"
                                                class="flex h-28 w-28 rounded-lg object-cover"
                                            />
                                            <div
                                                v-else
                                                class="flex h-28 w-28 items-center justify-center rounded-lg bg-gray-100"
                                            >
                                                <svg
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 24 24"
                                                    fill="none"
                                                    stroke="currentColor"
                                                    stroke-width="1.5"
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    class="h-16 w-16 text-gray-500"
                                                >
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                    <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                                                    <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                                </svg>
                                            </div>
                                        </el-upload>
                                    </el-form-item>

                                    <div class="invisble"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_name.label"
                                        :rules="field.mother_name.rules"
                                        :error="field.mother_name.error"
                                        prop="mother_name"
                                    >
                                        <el-input v-model="parentForm.mother_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_national_id.label"
                                        :rules="field.mother_national_id.rules"
                                        :error="field.mother_national_id.error"
                                        prop="mother_national_id"
                                    >
                                        <el-input v-model="parentForm.mother_national_id" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_birth_place.label"
                                        :rules="field.mother_birth_place.rules"
                                        :error="field.mother_birth_place.error"
                                        prop="mother_birth_place"
                                    >
                                        <el-input v-model="parentForm.mother_birth_place" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_birth_date.label"
                                        :rules="field.mother_birth_date.rules"
                                        :error="field.mother_birth_date.error"
                                        prop="mother_birth_date"
                                    >
                                        <el-date-picker
                                            v-model="parentForm.mother_birth_date"
                                            type="date"
                                            format="DD-MM-YYYY"
                                            value-format="YYYY-MM-DD"
                                        />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_religion.label"
                                        :rules="field.mother_religion.rules"
                                        :error="field.mother_religion.error"
                                        prop="mother_religion"
                                    >
                                        <el-select
                                            v-model="parentForm.mother_religion"
                                            :placeholder="`Pilih ${field.mother_religion.label}`"
                                            clearable
                                        >
                                            <el-option
                                                v-for="option in field.mother_religion.options"
                                                :key="option.value"
                                                :label="option.label"
                                                :value="option.value"
                                            />
                                        </el-select>
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_languages.label"
                                        :rules="field.mother_languages.rules"
                                        :error="field.mother_languages.error"
                                        prop="mother_languages"
                                    >
                                        <el-select
                                            v-model="parentForm.mother_languages"
                                            multiple
                                            filterable
                                            allow-create
                                            default-first-option
                                            :reserve-keyword="false"
                                            :placeholder="`Pilih ${field.mother_languages.label}`"
                                        >
                                            <el-option
                                                v-for="option in field.mother_languages.options"
                                                :key="option"
                                                :label="option"
                                                :value="option"
                                            />
                                        </el-select>
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_phone.label"
                                        :rules="field.mother_phone.rules"
                                        :error="field.mother_phone.error"
                                        prop="mother_phone"
                                    >
                                        <el-input v-model="parentForm.mother_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_email.label"
                                        :rules="field.mother_email.rules"
                                        :error="field.mother_email.error"
                                        prop="mother_email"
                                    >
                                        <el-input v-model="parentForm.mother_email" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_address.label"
                                        :rules="field.mother_address.rules"
                                        :error="field.mother_address.error"
                                        prop="mother_address"
                                    >
                                        <el-input
                                            type="textarea"
                                            v-model="parentForm.mother_address"
                                            autocomplete="off"
                                        />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_occupation.label"
                                        :rules="field.mother_occupation.rules"
                                        :error="field.mother_occupation.error"
                                        prop="mother_occupation"
                                    >
                                        <el-input v-model="parentForm.mother_occupation" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_company.label"
                                        :rules="field.mother_company.rules"
                                        :error="field.mother_company.error"
                                        prop="mother_company"
                                    >
                                        <el-input v-model="parentForm.mother_company" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_position.label"
                                        :rules="field.mother_position.rules"
                                        :error="field.mother_position.error"
                                        prop="mother_position"
                                    >
                                        <el-input v-model="parentForm.mother_position" autocomplete="off" />
                                    </el-form-item>
                                </div>
                            </el-form>
                        </div>
                        <!-- additional form -->
                        <div v-show="activeForm == 2">
                            <el-form
                                v-if="loaded"
                                ref="additionalForm"
                                label-position="top"
                                :model="additionalForm"
                                :disabled="process"
                            >
                                <!-- Emergency Contact -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Kontak Darurat</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.emergency_name.label"
                                        :rules="field.emergency_name.rules"
                                        :error="field.emergency_name.error"
                                        prop="emergency_name"
                                    >
                                        <el-input v-model="additionalForm.emergency_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.emergency_phone.label"
                                        :rules="field.emergency_phone.rules"
                                        :error="field.emergency_phone.error"
                                        prop="emergency_phone"
                                    >
                                        <el-input v-model="additionalForm.emergency_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.emergency_home_phone.label"
                                        :rules="field.emergency_home_phone.rules"
                                        :error="field.emergency_home_phone.error"
                                        prop="emergency_home_phone"
                                    >
                                        <el-input v-model="additionalForm.emergency_home_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.emergency_relation.label"
                                        :rules="field.emergency_relation.rules"
                                        :error="field.emergency_relation.error"
                                        prop="emergency_relation"
                                    >
                                        <el-input v-model="additionalForm.emergency_relation" autocomplete="off" />
                                    </el-form-item>
                                </div>
                                <!-- Payer Information -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Penanggung Biaya</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.responsible_fee.label"
                                        :rules="field.responsible_fee.rules"
                                        :error="field.responsible_fee.error"
                                        prop="responsible_fee"
                                    >
                                        <el-radio-group v-model="additionalForm.responsible_fee">
                                            <el-radio
                                                v-for="option in field.responsible_fee.options"
                                                :key="option.value"
                                                :value="option.value"
                                                >{{ option.label }}</el-radio
                                            >
                                        </el-radio-group>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_name.label"
                                        :rules="field.payer_name.rules"
                                        :error="field.payer_name.error"
                                        prop="payer_name"
                                    >
                                        <el-input v-model="additionalForm.payer_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_home_phone.label"
                                        :rules="field.payer_home_phone.rules"
                                        :error="field.payer_home_phone.error"
                                        prop="payer_home_phone"
                                    >
                                        <el-input v-model="additionalForm.payer_home_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_phone.label"
                                        :rules="field.payer_phone.rules"
                                        :error="field.payer_phone.error"
                                        prop="payer_phone"
                                    >
                                        <el-input v-model="additionalForm.payer_phone" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_email.label"
                                        :rules="field.payer_email.rules"
                                        :error="field.payer_email.error"
                                        prop="payer_email"
                                    >
                                        <el-input v-model="additionalForm.payer_email" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_relation.label"
                                        :rules="field.payer_relation.rules"
                                        :error="field.payer_relation.error"
                                        prop="payer_relation"
                                    >
                                        <el-input v-model="additionalForm.payer_relation" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_address.label"
                                        :rules="field.payer_address.rules"
                                        :error="field.payer_address.error"
                                        prop="payer_address"
                                    >
                                        <el-input v-model="additionalForm.payer_address" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_company.label"
                                        :rules="field.payer_company.rules"
                                        :error="field.payer_company.error"
                                        prop="payer_company"
                                    >
                                        <el-input v-model="additionalForm.payer_company" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="additionalForm.responsible_fee == 'OTHER'"
                                        class="font-bold"
                                        :label="field.payer_company_letter.label"
                                        :rules="field.payer_company_letter.rules"
                                        :error="field.payer_company_letter.error"
                                        prop="payer_company_letter"
                                    >
                                        <el-input v-model="additionalForm.payer_company_letter" autocomplete="off" />
                                    </el-form-item>
                                </div>
                                <!-- Other Information -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Kebutuhan Lain-lain</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.need_vehicle.label"
                                        :rules="field.need_vehicle.rules"
                                        :error="field.need_vehicle.error"
                                        prop="need_vehicle"
                                    >
                                        <el-checkbox
                                            border
                                            v-model="additionalForm.need_vehicle"
                                            :label="additionalForm.need_vehicle ? 'Ya' : 'Tidak'"
                                        />
                                    </el-form-item>
                                </div>
                            </el-form>
                        </div>
                        <!-- health form -->
                        <div v-show="activeForm == 3">
                            <el-form
                                v-if="loaded"
                                ref="healthForm"
                                label-position="top"
                                :model="healthForm"
                                :disabled="process"
                            >
                                <!-- General Information -->
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Informasi Umum</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.health_info_remark.label"
                                        :rules="field.health_info_remark.rules"
                                        :error="field.health_info_remark.error"
                                        prop="health_info_remark"
                                    >
                                        <el-input v-model="healthForm.health_info_remark" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.health_relate_family.label"
                                        :rules="field.health_relate_family.rules"
                                        :error="field.health_relate_family.error"
                                        prop="health_relate_family"
                                    >
                                        <el-input v-model="healthForm.health_relate_family" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.recomended_hospital.label"
                                        :rules="field.recomended_hospital.rules"
                                        :error="field.recomended_hospital.error"
                                        prop="recomended_hospital"
                                    >
                                        <el-input v-model="healthForm.recomended_hospital" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.doctor_name.label"
                                        :rules="field.doctor_name.rules"
                                        :error="field.doctor_name.error"
                                        prop="doctor_name"
                                    >
                                        <el-input v-model="healthForm.doctor_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.use_insurance.label"
                                        :rules="field.use_insurance.rules"
                                        :error="field.use_insurance.error"
                                        prop="use_insurance"
                                    >
                                        <el-checkbox
                                            border
                                            v-model="healthForm.use_insurance"
                                            :label="healthForm.use_insurance ? 'Ya' : 'Tidak'"
                                        />
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        v-if="healthForm.use_insurance"
                                        class="font-bold"
                                        :label="field.insurance_name.label"
                                        :rules="field.insurance_name.rules"
                                        :error="field.insurance_name.error"
                                        prop="insurance_name"
                                    >
                                        <el-input v-model="healthForm.insurance_name" autocomplete="off" />
                                    </el-form-item>

                                    <el-form-item
                                        v-if="healthForm.use_insurance"
                                        class="font-bold"
                                        :label="field.insurance_network.label"
                                        :rules="field.insurance_network.rules"
                                        :error="field.insurance_network.error"
                                        prop="insurance_network"
                                    >
                                        <el-input v-model="healthForm.insurance_network" autocomplete="off" />
                                    </el-form-item>
                                </div>
                                <h2 class="pb-4 text-lg font-bold text-gray-900">Kuesioner</h2>
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <template v-for="(field, index) in healthForm.questionnaires" :key="index">
                                        <el-form-item :label="field.question" class="font-bold md:col-span-2">
                                            <el-input
                                                v-if="field.type === 'text'"
                                                type="textarea"
                                                v-model="field.answer"
                                                autocomplete="off"
                                            />

                                            <el-radio-group v-else-if="field.type === 'radio'" v-model="field.answer">
                                                <el-radio value="YES">Ya</el-radio>
                                                <el-radio value="NO">Tidak</el-radio>
                                            </el-radio-group>

                                            <el-date-picker
                                                v-else-if="field.type === 'date'"
                                                v-model="field.answer"
                                                type="date"
                                                format="DD-MM-YYYY"
                                                value-format="YYYY-MM-DD"
                                            />
                                        </el-form-item>
                                        <template v-if="field.children && field.answer == 'YES'">
                                            <el-form-item
                                                v-for="(child, cIndex) in field.children"
                                                :key="cIndex"
                                                :label="child.question"
                                                class="col-span-1 font-bold"
                                            >
                                                <el-input type="textarea" v-model="child.answer" autocomplete="off" />
                                            </el-form-item>
                                        </template>
                                        <div class="invisible"></div>
                                    </template>
                                </div>
                            </el-form>
                        </div>
                        <!-- attachment form -->
                        <div v-show="activeForm == 4">
                            <el-form
                                v-if="loaded"
                                ref="attachmentForm"
                                label-position="top"
                                :model="attachmentForm"
                                :disabled="process"
                            >
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold"
                                        :label="field.family_card_attachment.label"
                                        :rules="field.family_card_attachment.rules"
                                        :error="field.family_card_attachment.error"
                                        prop="family_card"
                                        @change="handleFamilyCardFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDG (maks. 1mb).
                                        </p>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.father_id_card_attachment.label"
                                        :rules="field.father_id_card_attachment.rules"
                                        :error="field.father_id_card_attachment.error"
                                        prop="father_id_card"
                                        @change="handleFatherIdCardFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDF (maks. 1mb).
                                        </p>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.mother_id_card_attachment.label"
                                        :rules="field.mother_id_card_attachment.rules"
                                        :error="field.mother_id_card_attachment.error"
                                        prop="mother_id_card"
                                        @change="handleMotherIdCardFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDF (maks. 1mb).
                                        </p>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.birth_certificate_attachment.label"
                                        :rules="field.birth_certificate_attachment.rules"
                                        :error="field.birth_certificate_attachment.error"
                                        prop="birth_certificate"
                                        @change="handleBirthCertificateFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDF (maks. 1mb).
                                        </p>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.last_report_attachment.label"
                                        :rules="field.last_report_attachment.rules"
                                        :error="field.last_report_attachment.error"
                                        prop="last_report"
                                        @change="handleLastReportFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDF (maks. 1mb).
                                        </p>
                                    </el-form-item>

                                    <div class="invisible"></div>

                                    <el-form-item
                                        class="font-bold"
                                        :label="field.previous_school_letter_attachment.label"
                                        :rules="field.previous_school_letter_attachment.rules"
                                        :error="field.previous_school_letter_attachment.error"
                                        prop="previous_school_letter"
                                        @change="handlePreviousSchoolLetterFileChange"
                                    >
                                        <input
                                            class="block w-full cursor-pointer rounded-lg border border-gray-300 bg-gray-50 p-2 text-sm text-gray-900 focus:outline-none dark:border-gray-600 dark:bg-gray-700 dark:text-gray-400 dark:placeholder-gray-400"
                                            type="file"
                                            accept=".png, .jpg, .pdf"
                                        />
                                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                                            PNG, JPG atau PDF (maks. 1mb).
                                        </p>
                                    </el-form-item>
                                </div>
                            </el-form>
                        </div>
                        <!-- survey form -->
                        <div v-show="activeForm == 5">
                            <el-form
                                v-if="loaded"
                                ref="surveyForm"
                                label-position="top"
                                :model="surveyForm"
                                :disabled="process"
                            >
                                <div class="grid grid-cols-1 gap-x-4 md:grid-cols-2">
                                    <el-form-item
                                        class="font-bold md:col-span-2"
                                        :label="field.school_info_sources.label"
                                        :rules="field.school_info_sources.rules"
                                        :error="field.school_info_sources.error"
                                        prop="school_info_sources"
                                    >
                                        <el-select
                                            v-model="surveyForm.school_info_sources"
                                            :placeholder="`Pilih ${field.school_info_sources.label}`"
                                            loading-text="..."
                                            no-match-text="Data tidak ditemukan"
                                            no-data-text="Tidak ada data"
                                            multiple
                                            clearable
                                            autocomplete="off"
                                        >
                                            <el-option
                                                v-for="option in field.school_info_sources.options"
                                                :key="option.value"
                                                :label="option.label"
                                                :value="option.value"
                                            />
                                        </el-select>
                                    </el-form-item>
                                </div>
                            </el-form>
                        </div>
                    </div>
                    <!-- action button -->
                    <div class="flex justify-start space-x-4">
                        <DefaultButton
                            v-if="activeForm != 0"
                            type="light"
                            @click="
                                moveToForm(activeForm == 0 ? 5 : activeForm - 1);
                                scrollToTop();
                            "
                            >Sebelumnya: {{ getFormLabel(activeForm - 1) }}</DefaultButton
                        >
                        <DefaultButton
                            v-if="activeForm != 5"
                            type="default"
                            @click="
                                moveToForm(activeForm == 5 ? 0 : activeForm + 1);
                                scrollToTop();
                            "
                            >Selanjutnya: {{ getFormLabel(activeForm + 1) }}</DefaultButton
                        >
                        <DefaultButton v-if="activeForm == 5" @click="submit()" type="default"
                            >Simpan Pendaftaran</DefaultButton
                        >
                    </div>
                </div>
                <div class="mx-8 space-y-6 py-1 pb-5" v-else>
                    <div
                        class="mb-4 rounded-lg border border-green-300 bg-green-50 p-4 text-green-800 dark:border-green-800 dark:bg-gray-800 dark:text-green-400"
                    >
                        <div class="flex items-center">
                            <svg
                                class="me-2 h-4 w-4 shrink-0"
                                aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="currentColor"
                                viewBox="0 0 20 20"
                            >
                                <path
                                    d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
                                />
                            </svg>
                            <span class="sr-only">Info</span>
                            <h3 class="text-base font-medium">Pendaftaran Berhasil</h3>
                        </div>
                        <div class="mt-2 text-sm">
                            Pendaftaran siswa telah berhasil. Untuk melanjutkan, silakan lengkapi berkas-berkas yang
                            diperlukan.
                        </div>
                    </div>
                    <div class="flex justify-start space-x-4">
                        <Link
                            :href="
                                route('guardian.admissionStudent.form', {
                                    registration_number: admission_student.data.registration_number,
                                })
                            "
                        >
                            <DefaultButton type="light">Balik ke Form Pendaftaran </DefaultButton>
                        </Link>

                        <Link
                            :href="
                                route('guardian.admissionStudent.detail', {
                                    registration_number: admission_student.data.registration_number,
                                })
                            "
                        >
                            <DefaultButton>Lihat Detail Pendaftaran</DefaultButton>
                        </Link>
                    </div>
                </div>
            </section>
        </template>
    </CenterLayout>
</template>
