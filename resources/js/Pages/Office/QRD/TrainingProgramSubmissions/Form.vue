<script>
import { initFlowbite } from 'flowbite';
export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import { ElNotification } from 'element-plus';
import { useForm } from '@inertiajs/vue3';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { ref, watch, computed, onMounted } from 'vue';
import axios from 'axios';
import moment from 'moment';

// Props
const props = defineProps({
    submission: {
        type: Object,
        default: null
    }
});

// Check if edit mode
const isEditMode = computed(() => !!props.submission);

// Dynamic breadcrumbs based on mode
const breadcrumbs = computed(() => {
    const baseBreadcrumbs = [
        { label: 'Yayasan', href: route('office') },
        { label: 'QRD', href: route('office.qrd') },
        { label: 'Pengajuan Training Program', href: route('office.qrd.manage.training-program-submission.index') }
    ];
    
    if (isEditMode.value) {
        baseBreadcrumbs.push({ label: 'Edit Pengajuan', href: route('office.qrd.manage.training-program-submission.edit', props.submission.uuid) });
    } else {
        baseBreadcrumbs.push({ label: 'Buat Pengajuan', href: route('office.qrd.manage.training-program-submission.create') });
    }
    
    return baseBreadcrumbs;
});

// Form data
const form = useForm({
    datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
    training_type: 'internal',
    training_program_id: '',
    // External training fields - to be sent only for external type
    external_training_title: '',
    external_training_provider: '',
    external_training_location: '',
    external_training_method: '',
    external_training_description: '',
    // Common fields
    start_date: '',
    end_date: '',
    daily_start_time: null,
    daily_end_time: null,
    training_days: [], // Changed to array for specific days
    justification: '',
    expected_outcomes: '',
    goals: [
        {
            goal_type: 'knowledge',
            description: '',
            success_indicator: '',
            order: 1
        }
    ],
    budget_items: [
        {
            category: 'venue',
            item_name: '',
            description: '',
            quantity: 1,
            unit_price: 0
        }
    ],
    participant_type: 'employee', // New field for participant type selection
    participants: [],
    participant_details: [], // Store detailed participant info separately
    attachments: []
});

// Form validation rules
const rules = {
    training_type: [{ required: true, message: 'Tipe training wajib dipilih', trigger: 'change' }],
    training_program_id: [
        { 
            validator: (rule, value, callback) => {
                if (form.training_type === 'internal' && !value) {
                    callback(new Error('Program training wajib dipilih untuk tipe internal'));
                } else {
                    callback();
                }
            }, 
            trigger: 'change' 
        }
    ],
    external_training_title: [
        { 
            validator: (rule, value, callback) => {
                if (form.training_type === 'external' && !value) {
                    callback(new Error('Judul training wajib diisi untuk tipe eksternal'));
                } else {
                    callback();
                }
            }, 
            trigger: 'blur' 
        }
    ],
    external_training_provider: [
        { 
            validator: (rule, value, callback) => {
                if (form.training_type === 'external' && !value) {
                    callback(new Error('Provider wajib diisi untuk tipe eksternal'));
                } else {
                    callback();
                }
            }, 
            trigger: 'blur' 
        }
    ],
    start_date: [{ required: true, message: 'Tanggal mulai wajib diisi', trigger: 'change' }],
    end_date: [{ required: true, message: 'Tanggal selesai wajib diisi', trigger: 'change' }],
    daily_start_time: [{ required: true, message: 'Waktu mulai wajib diisi', trigger: 'change' }],
    daily_end_time: [{ required: true, message: 'Waktu selesai wajib diisi', trigger: 'change' }],
    participants: [{ required: true, type: 'array', min: 1, message: 'Minimal satu peserta harus dipilih', trigger: 'change' }]
};

// Options data
const trainingPrograms = ref([]);
const participants = ref([]);
const loading = ref(false);

// Participant type options
const participantTypeOptions = [
    { value: 'employee', label: 'Karyawan' },
    // { value: 'student', label: 'Siswa', disabled: true }, // Disabled for now
    // { value: 'student_guardian', label: 'Wali Murid', disabled: true } // Disabled for now
];

// Days of week options
const daysOfWeekOptions = [
    { value: 'monday', label: 'Senin' },
    { value: 'tuesday', label: 'Selasa' },
    { value: 'wednesday', label: 'Rabu' },
    { value: 'thursday', label: 'Kamis' },
    { value: 'friday', label: 'Jumat' },
    { value: 'saturday', label: 'Sabtu' },
    { value: 'sunday', label: 'Minggu' }
];

// Load initial data
const loadTrainingPrograms = async (query = null) => {
    try {
        const response = await axios.get(route('office.qrd.manage.training-program-submission.option.training-programs', { search: query }));
        trainingPrograms.value = response.data;
    } catch (error) {
        console.error('Error loading training programs:', error);
    }
};

const loadParticipants = async (query = null) => {
    try {
        const response = await axios.get(route('office.qrd.manage.training-program-submission.option.participants', { 
            search: query,
            type: form.participant_type 
        }));
        participants.value = response.data;
    } catch (error) {
        console.error('Error loading participants:', error);
    }
};

// Options for dropdowns
const goalTypeOptions = [
    { value: 'knowledge', label: 'Pengetahuan (Knowledge)' },
    { value: 'skill', label: 'Keterampilan (Skill)' },
    { value: 'attitude', label: 'Sikap (Attitude)' }
];

const budgetCategoryOptions = [
    { value: 'venue', label: 'Tempat/Venue' },
    { value: 'instructor_fee', label: 'Biaya Instruktur' },
    { value: 'material', label: 'Materi' },
    { value: 'equipment', label: 'Peralatan' },
    { value: 'transportation', label: 'Transportasi' },
    { value: 'accommodation', label: 'Akomodasi' },
    { value: 'meal', label: 'Konsumsi' },
    { value: 'certification', label: 'Sertifikasi' },
    { value: 'other', label: 'Lainnya' }
];

const attachmentTypeOptions = [
    { value: 'proposal', label: 'Proposal' },
    { value: 'brochure', label: 'Brosur' },
    { value: 'curriculum', label: 'Kurikulum' },
    { value: 'quotation', label: 'Quotation' },
    { value: 'agreement', label: 'Perjanjian' },
    { value: 'other', label: 'Lainnya' }
];

// Computed properties
const totalBudget = computed(() => {
    return form.budget_items.reduce((total, item) => {
        return total + (item.quantity * item.unit_price);
    }, 0);
});

const formatCurrency = (amount) => {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0
    }).format(amount || 0);
};

// Populate form data for edit mode
const populateFormData = () => {
    if (!isEditMode.value || !props.submission) return;
    
    const submission = props.submission;
    
    // Basic information
    form.datetime = moment(submission.datetime).format('YYYY-MM-DD HH:mm:ss');
    form.training_type = submission.training_type;
    form.training_program_id = submission.training_program_id || '';
    console.log("training_program_id");
    console.log(form.training_program_id);
    form.external_training_title = submission.external_training_title || '';
    form.external_training_provider = submission.external_training_provider || '';
    form.external_training_location = submission.external_training_location || '';
    form.external_training_method = submission.external_training_method || '';
    form.external_training_description = submission.external_training_description || '';
    
    // Schedule
    form.start_date = submission.start_date;
    form.end_date = submission.end_date;
    form.daily_start_time = submission.daily_start_time;
    form.daily_end_time = submission.daily_end_time;
    form.training_days = submission.training_days || [];
    form.justification = submission.justification || '';
    form.expected_outcomes = submission.expected_outcomes || '';
    
    // Goals
    if (submission.goals && submission.goals.length > 0) {
        form.goals = submission.goals.map(goal => ({
            goal_type: goal.goal_type,
            description: goal.description,
            success_indicator: goal.success_indicator,
            order: goal.order
        }));
    }
    
    // Budget items
    if (submission.budget_items && submission.budget_items.length > 0) {
        form.budget_items = submission.budget_items.map(item => ({
            category: item.category,
            item_name: item.item_name,
            description: item.description || '',
            quantity: item.quantity,
            unit_price: item.unit_price
        }));
    }
    
    // Participants - handle polymorphic structure
    if (submission.participants && submission.participants.length > 0) {
        // Determine participant type from first participant
        const firstParticipant = submission.participants[0];
        if (firstParticipant.participant_type) {
            form.participant_type = firstParticipant.participant_type.includes('Employee') ? 'employee' :
                                  firstParticipant.participant_type.includes('Student') && !firstParticipant.participant_type.includes('Guardian') ? 'student' :
                                  'student_guardian';
        }
        
        form.participants = submission.participants.map(p => p.participant_id);
        form.participant_details = submission.participants.map(p => ({
            participant_type: form.participant_type,
            participant_id: p.participant_id,
            is_primary_participant: p.is_primary_participant,
            role_description: p.role_description || '',
            selection_reason: p.selection_reason || ''
        }));
    }
    
    // Attachments - don't populate existing attachments, only allow new ones
    form.attachments = [];
};

// Method to delete attachment
const deleteAttachment = async (attachmentUuid) => {
    if (confirm('Apakah Anda yakin ingin menghapus attachment ini?')) {
        try {
            await axios.delete(route('office.qrd.manage.training-program-submission.deleteAttachment', {
                uuid: props.submission.uuid,
                attachmentUuid: attachmentUuid
            }));
            
            ElNotification({
                title: 'Berhasil',
                message: 'Attachment berhasil dihapus',
                type: 'success'
            });
            
            // Refresh the page to update the attachment list
            window.location.reload();
        } catch (error) {
            ElNotification({
                title: 'Gagal',
                message: 'Terjadi kesalahan saat menghapus attachment',
                type: 'error'
            });
        }
    }
};

// Watchers
watch(() => form.training_type, (newType) => {
    if (newType === 'internal') {
        // Clear external fields
        form.external_training_title = '';
        form.external_training_provider = '';
        form.external_training_location = '';
        form.external_training_method = '';
        form.external_training_description = '';
    } else {
        form.training_program_id = '';
    }
});

// Watch for participant type changes
watch(() => form.participant_type, (newType) => {
    // Clear selected participants when type changes
    form.participants = [];
    form.participant_details = [];
    participants.value = [];
    // Load new participants based on type
    loadParticipants();
});

// Clean up participant details when participants are removed
watch(() => form.participants, (newParticipants) => {
    form.participant_details = form.participant_details.filter(detail => 
        newParticipants.includes(detail.participant_id)
    );
}, { deep: true });

// Methods
const getParticipantDetail = (participantId) => {
    let detail = form.participant_details.find(d => d.participant_id === participantId);
    if (!detail) {
        detail = {
            participant_type: form.participant_type,
            participant_id: participantId,
            is_primary_participant: false,
            role_description: '',
            selection_reason: ''
        };
        form.participant_details.push(detail);
    }
    return detail;
};

const updateParticipantDetail = (participantId, field, value) => {
    const detail = getParticipantDetail(participantId);
    detail[field] = value;
};

const setPrimaryParticipant = (participantId, isPrimary) => {
    if (isPrimary) {
        // Set all others to false first
        form.participant_details.forEach(detail => {
            detail.is_primary_participant = false;
        });
    }
    const detail = getParticipantDetail(participantId);
    detail.is_primary_participant = isPrimary;
};

const getParticipantLabel = (participant) => {
    if (form.participant_type === 'employee') {
        return `${participant.label} - ${participant.position || 'N/A'} (${participant.area || 'N/A'})`;
    } else if (form.participant_type === 'student') {
        return `${participant.label} - ${participant.school || 'N/A'} (${participant.grade || 'N/A'})`;
    } else if (form.participant_type === 'student_guardian') {
        return `${participant.label} - Wali dari: ${participant.students || 'N/A'}`;
    }
    return participant.label;
};

const addGoal = () => {
    form.goals.push({
        goal_type: 'knowledge',
        description: '',
        success_indicator: '',
        order: form.goals.length + 1
    });
};

const removeGoal = (index) => {
    form.goals.splice(index, 1);
    // Reorder goals
    form.goals.forEach((goal, i) => {
        goal.order = i + 1;
    });
};

const addBudgetItem = () => {
    form.budget_items.push({
        category: 'venue',
        item_name: '', // Added missing field
        description: '',
        quantity: 1,
        unit_price: 0
    });
};

const removeBudgetItem = (index) => {
    form.budget_items.splice(index, 1);
};

const addAttachment = () => {
    form.attachments.push({
        attachment_type: 'proposal',
        title: '', // Changed from 'title' to 'description' as per backend
        description: '', // Added for backend compatibility
        file: null
    });
};

const removeAttachment = (index) => {
    form.attachments.splice(index, 1);
};

const handleFileChange = (file, index) => {
    form.attachments[index].file = file;
};

const submit = async (formRef, status = 'PENDING') => {
    if (!formRef) return;
    
    try {
        await formRef.validate();
        loading.value = true;

        // Create a clean copy of form data without Inertia.js methods and proxies
        const formData = {
            datetime: form.datetime,
            training_type: form.training_type,
            training_program_id: form.training_program_id,
            external_training_title: form.external_training_title,
            external_training_provider: form.external_training_provider,
            external_training_location: form.external_training_location,
            external_training_method: form.external_training_method,
            external_training_description: form.external_training_description,
            start_date: form.start_date,
            end_date: form.end_date,
            daily_start_time: form.daily_start_time,
            daily_end_time: form.daily_end_time,
            training_days: [...form.training_days],
            justification: form.justification,
            expected_outcomes: form.expected_outcomes,
            goals: form.goals.map(goal => ({
                goal_type: goal.goal_type,
                description: goal.description,
                success_indicator: goal.success_indicator,
                order: goal.order
            })),
            budget_items: form.budget_items.map(item => ({
                category: item.category,
                item_name: item.item_name,
                description: item.description,
                quantity: item.quantity,
                unit_price: item.unit_price
            })),
            participants: [...form.participants],
            participant_details: form.participant_details.map(detail => ({
                participant_type: form.participant_type,
                participant_id: detail.participant_id,
                is_primary_participant: detail.is_primary_participant,
                role_description: detail.role_description,
                selection_reason: detail.selection_reason
            })),
            attachments: form.attachments.map(attachment => ({
                attachment_type: attachment.attachment_type,
                description: attachment.description,
                file: attachment.file
            })),
            status: status
        };
        
        // Clean up participant details to only include selected participants
        formData.participant_details = formData.participant_details.filter(detail => 
            formData.participants.includes(detail.participant_id)
        );
        
        // Set primary participant if none selected
        if (formData.participants.length > 0) {
            const hasPrimary = formData.participant_details.some(p => p.is_primary_participant);
            if (!hasPrimary && formData.participant_details.length > 0) {
                formData.participant_details[0].is_primary_participant = true;
            }
        }
        
        // Update formData participants to include detailed info for submission
        formData.participants = formData.participant_details;
        
        // Use the original form object to make the POST/PUT request
        const method = isEditMode.value ? 'put' : 'post';
        const url = isEditMode.value 
            ? route('office.qrd.manage.training-program-submission.update', props.submission.uuid)
            : route('office.qrd.manage.training-program-submission.store');
        
        form.transform((data) => formData)[method](url, {
            onSuccess: (response) => {
                ElNotification({
                    title: 'Berhasil',
                    message: isEditMode.value 
                        ? 'Pengajuan training program berhasil diperbarui'
                        : 'Pengajuan training program berhasil dibuat',
                    type: 'success'
                });
            },
            onError: (errors) => {
                console.error('Submission errors:', errors);
                ElNotification({
                    title: 'Gagal',
                    message: 'Terjadi kesalahan saat menyimpan data',
                    type: 'error'
                });
            },
            onFinish: () => {
                loading.value = false;
            }
        });
    } catch (error) {
        console.error('Validation error:', error);
        ElNotification({
            title: 'Validasi Gagal',
            message: 'Mohon periksa kembali data yang diisi',
            type: 'warning'
        });
    }
};

// Initialize form data on mount
onMounted(() => {
    loadTrainingPrograms();
    loadParticipants();
    populateFormData();
});
</script>

<template>
    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
        </template>
        <template #sidebar>
            <QRDSidebar />
        </template>
        <template #content>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-gray-900">
                        {{ isEditMode ? 'Edit Pengajuan Training Program' : 'Buat Pengajuan Training Program' }}
                    </h1>
                    <p class="text-gray-600 mt-2">
                        {{ isEditMode 
                            ? 'Edit formulir pengajuan training program yang sudah ada'
                            : 'Isi formulir di bawah untuk membuat pengajuan training program baru' 
                        }}
                    </p>
                </div>

                <el-form 
                    ref="formRef" 
                    :model="form" 
                    :rules="rules" 
                    label-width="200px" 
                    label-position="left"
                    size="default">

                    <!-- Basic Information -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Informasi Dasar</h3>
                        
                        <el-form-item
                            class="font-medium"
                            label="Tanggal"
                            prop="datetime"
                            >
                            <el-date-picker
                                :disabled="true"
                                v-model="form.datetime"
                                type="date"
                                format="DD-MM-YYYY"
                                value-format="YYYY-MM-DD"
                            />
                        </el-form-item>

                        <el-form-item label="Tipe Training" prop="training_type">
                            <el-radio-group v-model="form.training_type">
                                <el-radio value="internal">Internal (Program Existing)</el-radio>
                                <el-radio value="external">Eksternal (Provider Luar)</el-radio>
                            </el-radio-group>
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'internal'"
                            label="Program Training" 
                            prop="training_program_id">
                            <el-select
                                v-model="form.training_program_id" 
                                placeholder="Pilih program training"
                                style="width: 100%"
                                :remote-method="loadTrainingPrograms"
                                :remote="true"
                                value-key="id"
                                reserve-keyword
                                clearable
                                autocomplete="off"
                                filterable>
                                <el-option
                                    v-for="program in trainingPrograms"
                                    :key="program.value"
                                    :label="program.label"
                                    :value="program.value" />
                            </el-select>
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'external'"
                            label="Judul Training" 
                            prop="external_training_title">
                            <el-input 
                                v-model="form.external_training_title" 
                                placeholder="Masukkan judul training eksternal" />
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'external'"
                            label="Provider" 
                            prop="external_training_provider">
                            <el-input 
                                v-model="form.external_training_provider" 
                                placeholder="Nama provider/penyelenggara" />
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'external'"
                            label="Lokasi">
                            <el-input 
                                v-model="form.external_training_location" 
                                placeholder="Lokasi pelaksanaan training" />
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'external'"
                            label="Metode">
                            <el-input 
                                v-model="form.external_training_method" 
                                placeholder="Metode pelaksanaan (online/offline/hybrid)" />
                        </el-form-item>

                        <el-form-item 
                            v-if="form.training_type === 'external'"
                            label="Deskripsi">
                            <el-input 
                                v-model="form.external_training_description" 
                                type="textarea" 
                                :rows="3"
                                placeholder="Deskripsi training eksternal" />
                        </el-form-item>

                        <el-form-item label="Justifikasi">
                            <el-input 
                                v-model="form.justification" 
                                type="textarea" 
                                :rows="3"
                                placeholder="Jelaskan alasan atau justifikasi mengapa training ini diperlukan" />
                        </el-form-item>

                        <el-form-item label="Hasil yang Diharapkan">
                            <el-input 
                                v-model="form.expected_outcomes" 
                                type="textarea" 
                                :rows="3"
                                placeholder="Jelaskan hasil atau outcome yang diharapkan dari training ini" />
                        </el-form-item>
                    </div>

                    <!-- Schedule Information -->
                    <div v-if="form.training_type === 'external'" class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Jadwal Training</h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <el-form-item label="Tanggal Mulai" prop="start_date">
                                <el-date-picker
                                    v-model="form.start_date"
                                    type="date"
                                    placeholder="Pilih tanggal mulai"
                                    format="DD/MM/YYYY"
                                    value-format="YYYY-MM-DD"
                                    style="width: 100%" />
                            </el-form-item>

                            <el-form-item label="Tanggal Selesai" prop="end_date">
                                <el-date-picker
                                    v-model="form.end_date"
                                    type="date"
                                    placeholder="Pilih tanggal selesai"
                                    format="DD/MM/YYYY"
                                    value-format="YYYY-MM-DD"
                                    style="width: 100%" />
                            </el-form-item>

                            <el-form-item label="Waktu Mulai" prop="daily_start_time">
                                <el-time-picker
                                    v-model="form.daily_start_time"
                                    placeholder="Waktu mulai"
                                    format="HH:mm"
                                    value-format="HH:mm"
                                    style="width: 100%" />
                            </el-form-item>

                            <el-form-item label="Waktu Selesai" prop="daily_end_time">
                                <el-time-picker
                                    v-model="form.daily_end_time"
                                    placeholder="Waktu selesai"
                                    format="HH:mm"
                                    value-format="HH:mm"
                                    style="width: 100%" />
                            </el-form-item>
                        </div>

                        <el-form-item label="Hari Training">
                            <el-checkbox-group v-model="form.training_days">
                                <el-checkbox 
                                    v-for="day in daysOfWeekOptions" 
                                    :key="day.value" 
                                    :value="day.value"
                                    :label="day.label" />
                            </el-checkbox-group>
                            <div class="text-sm text-gray-500 mt-1">
                                Pilih hari-hari pelaksanaan training (kosongkan jika setiap hari)
                            </div>
                        </el-form-item>
                    </div>

                    <!-- Goals Section -->
                    <div class="mb-8">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-semibold text-gray-800 border-b pb-2">Tujuan Training (K.S.A)</h3>
                            <el-button type="primary" plain @click="addGoal">
                                <i class="fas fa-plus mr-2"></i>Tambah Tujuan
                            </el-button>
                        </div>

                        <div v-for="(goal, index) in form.goals" :key="index" class="border rounded-lg p-4 mb-4">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-medium text-gray-700">Tujuan {{ index + 1 }}</h4>
                                <el-button 
                                    v-if="form.goals.length > 1"
                                    type="danger" 
                                    plain 
                                    size="small" 
                                    @click="removeGoal(index)">
                                    <i class="fas fa-trash"></i>
                                </el-button>
                            </div>

                            <el-form-item :label="`Tipe Tujuan ${index + 1}`" :prop="`goals.${index}.goal_type`">
                                <el-select 
                                    v-model="goal.goal_type" 
                                    placeholder="Pilih tipe tujuan"
                                    style="width: 100%">
                                    <el-option
                                        v-for="option in goalTypeOptions"
                                        :key="option.value"
                                        :label="option.label"
                                        :value="option.value" />
                                </el-select>
                            </el-form-item>

                            <el-form-item :label="`Deskripsi Tujuan ${index + 1}`" :prop="`goals.${index}.description`">
                                <el-input 
                                    v-model="goal.description" 
                                    type="textarea" 
                                    :rows="2"
                                    placeholder="Deskripsi tujuan pembelajaran" />
                            </el-form-item>

                            <el-form-item :label="`Indikator Keberhasilan ${index + 1}`" :prop="`goals.${index}.success_indicator`">
                                <el-input 
                                    v-model="goal.success_indicator" 
                                    type="textarea" 
                                    :rows="2"
                                    placeholder="Indikator keberhasilan" />
                            </el-form-item>
                        </div>
                    </div>

                    <!-- Budget Section -->
                    <div class="mb-8">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-semibold text-gray-800 border-b pb-2">Budget Planning</h3>
                            <el-button type="primary" plain @click="addBudgetItem">
                                <i class="fas fa-plus mr-2"></i>Tambah Item
                            </el-button>
                        </div>

                        <div v-for="(item, index) in form.budget_items" :key="index" class="border rounded-lg p-4 mb-4">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-medium text-gray-700">Budget Item {{ index + 1 }}</h4>
                                <el-button 
                                    v-if="form.budget_items.length > 1"
                                    type="danger" 
                                    plain 
                                    size="small" 
                                    @click="removeBudgetItem(index)">
                                    <i class="fas fa-trash"></i>
                                </el-button>
                            </div>

                            <!-- Row 1: Kategori dan Deskripsi -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                                <el-form-item label="Kategori" :prop="`budget_items.${index}.category`">
                                    <el-select 
                                        v-model="item.category" 
                                        placeholder="Pilih kategori budget"
                                        style="width: 100%">
                                        <el-option
                                            v-for="option in budgetCategoryOptions"
                                            :key="option.value"
                                            :label="option.label"
                                            :value="option.value" />
                                    </el-select>
                                </el-form-item>

                                <el-form-item label="Nama Item" :prop="`budget_items.${index}.item_name`">
                                    <el-input 
                                        v-model="item.item_name" 
                                        placeholder="Nama item budget" />
                                </el-form-item>
                            </div>

                            <!-- Row 2: Deskripsi -->
                            <el-form-item label="Deskripsi" :prop="`budget_items.${index}.description`">
                                <el-input 
                                    v-model="item.description" 
                                    placeholder="Deskripsi detail item budget (opsional)" />
                            </el-form-item>

                            <!-- Row 3: Kuantitas dan Harga Satuan -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <el-form-item label="Kuantitas" :prop="`budget_items.${index}.quantity`">
                                    <el-input-number 
                                        v-model="item.quantity" 
                                        :min="1" 
                                        :max="9999"
                                        placeholder="1"
                                        controls-position="right"
                                        style="width: 100%" />
                                </el-form-item>

                                <el-form-item label="Harga Satuan" :prop="`budget_items.${index}.unit_price`">
                                    <el-input-number 
                                        v-model="item.unit_price" 
                                        :min="0" 
                                        :max="999999999999"
                                        :precision="0"
                                        placeholder="0"
                                        :step="10000"
                                        :formatter="(value) => {
                                            if (!value) return '';
                                            return 'Rp ' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
                                        }"
                                        :parser="(value) => {
                                            if (!value) return 0;
                                            return value.replace(/Rp\s?|(\.)|(,)/g, '');
                                        }"
                                        controls-position="right"
                                        style="width: 100%" />
                                </el-form-item>
                            </div>

                            <!-- Row 4: Subtotal -->
                            <div class="flex justify-end">
                                <div class="bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 px-6 py-3 rounded-lg">
                                    <div class="text-sm text-green-600 mb-1">Subtotal Item {{ index + 1 }}</div>
                                    <div class="text-xl font-bold text-green-800">
                                        {{ formatCurrency(item.quantity * item.unit_price) }}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 p-6 rounded-lg">
                            <div class="flex items-center justify-between">
                                <div>
                                    <h4 class="text-lg font-semibold text-green-800 mb-1">Total Budget Keseluruhan</h4>
                                    <p class="text-sm text-green-600">{{ form.budget_items.length }} item budget</p>
                                </div>
                                <div class="text-right">
                                    <div class="text-2xl font-bold text-green-800">
                                        {{ formatCurrency(totalBudget) }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Participants Section -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Peserta Training</h3>
                        
                        <el-form-item label="Tipe Peserta" prop="participant_type">
                            <el-radio-group v-model="form.participant_type">
                                <el-radio 
                                    v-for="type in participantTypeOptions"
                                    :key="type.value"
                                    :value="type.value"
                                    :disabled="type.disabled">
                                    {{ type.label }}
                                    <span v-if="type.disabled" class="text-sm text-gray-500 ml-1">(Coming Soon)</span>
                                </el-radio>
                            </el-radio-group>
                        </el-form-item>
                        
                        <el-form-item label="Pilih Peserta" prop="participants">
                            <el-select 
                                v-model="form.participants" 
                                multiple
                                placeholder="Pilih peserta training"
                                style="width: 100%"
                                :remote-method="loadParticipants"
                                :remote="true"
                                value-key="id"
                                reserve-keyword
                                clearable
                                filterable>
                                <el-option
                                    v-for="participant in participants"
                                    :key="participant.value"
                                    :label="getParticipantLabel(participant)"
                                    :value="participant.value" />
                            </el-select>
                        </el-form-item>

                        <div v-if="form.participants.length > 0" class="mt-4">
                            <h4 class="font-medium text-gray-700 mb-3">Detail Peserta</h4>
                            <div v-for="(participantId, index) in form.participants" :key="participantId" class="border rounded-lg p-4 mb-3">
                                <div class="flex items-center justify-between mb-2">
                                    <span class="font-medium">
                                        {{ participants.find(p => p.value === participantId)?.label }}
                                    </span>
                                    <el-checkbox 
                                        :model-value="getParticipantDetail(participantId).is_primary_participant"
                                        @change="(val) => setPrimaryParticipant(participantId, val)">
                                        Peserta Utama
                                    </el-checkbox>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <el-form-item label="Deskripsi Peran">
                                        <el-input 
                                            :model-value="getParticipantDetail(participantId).role_description"
                                            @input="(val) => updateParticipantDetail(participantId, 'role_description', val)"
                                            placeholder="Peran dalam training" />
                                    </el-form-item>
                                    
                                    <el-form-item label="Alasan Pemilihan">
                                        <el-input 
                                            :model-value="getParticipantDetail(participantId).selection_reason"
                                            @input="(val) => updateParticipantDetail(participantId, 'selection_reason', val)"
                                            placeholder="Alasan memilih peserta ini" />
                                    </el-form-item>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Existing Attachments (for edit mode) -->
                    <div v-if="isEditMode && submission.attachments && submission.attachments.length > 0" class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Lampiran Existing</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div v-for="attachment in submission.attachments" :key="attachment.uuid" class="border rounded-lg p-4">
                                <div class="flex items-center justify-between mb-2">
                                    <span class="text-sm font-medium text-gray-600">{{ attachment.attachment_type }}</span>
                                    <button 
                                        @click="deleteAttachment(attachment.uuid)"
                                        class="text-red-500 hover:text-red-700">
                                        <i class="fas fa-trash text-sm"></i>
                                    </button>
                                </div>
                                <p class="text-sm text-gray-800 mb-2">{{ attachment.description }}</p>
                                <a :href="`/storage/${attachment.file_path}`" target="_blank" 
                                   class="text-blue-600 hover:text-blue-800 text-sm">
                                    <i class="fas fa-download mr-1"></i>{{ attachment.file_name }}
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- New Attachments Section -->
                    <div class="mb-8">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-semibold text-gray-800 border-b pb-2">
                                {{ isEditMode ? 'Tambah Lampiran Baru' : 'Lampiran (Opsional)' }}
                            </h3>
                            <el-button type="primary" plain @click="addAttachment">
                                <i class="fas fa-plus mr-2"></i>Tambah Lampiran
                            </el-button>
                        </div>

                        <div v-for="(attachment, index) in form.attachments" :key="index" class="border rounded-lg p-4 mb-4">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-medium text-gray-700">Lampiran Baru {{ index + 1 }}</h4>
                                <el-button 
                                    type="danger" 
                                    plain 
                                    size="small" 
                                    @click="removeAttachment(index)">
                                    <i class="fas fa-trash"></i>
                                </el-button>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <el-form-item :label="`Tipe Lampiran ${index + 1}`">
                                    <el-select 
                                        v-model="attachment.attachment_type" 
                                        placeholder="Tipe lampiran"
                                        style="width: 100%">
                                        <el-option
                                            v-for="option in attachmentTypeOptions"
                                            :key="option.value"
                                            :label="option.label"
                                            :value="option.value" />
                                    </el-select>
                                </el-form-item>

                                <el-form-item :label="`Judul Lampiran ${index + 1}`">
                                    <el-input 
                                        v-model="attachment.description" 
                                        placeholder="Deskripsi lampiran" />
                                </el-form-item>
                            </div>

                            <el-form-item :label="`File ${index + 1}`">
                                <el-upload
                                    :auto-upload="false"
                                    :show-file-list="false"
                                    accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                                    :on-change="(file) => handleFileChange(file.raw, index)">
                                    <el-button type="primary" plain>
                                        <i class="fas fa-upload mr-2"></i>Upload File
                                    </el-button>
                                    <template #tip>
                                        <div class="el-upload__tip">
                                            File maksimal 10MB (PDF, DOC, DOCX, JPG, PNG)
                                        </div>
                                    </template>
                                </el-upload>
                                <div v-if="attachment.file" class="mt-2 text-sm text-green-600">
                                    <i class="fas fa-check mr-1"></i>{{ attachment.file.name }}
                                </div>
                            </el-form-item>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex justify-end space-x-4 pt-6 border-t">
                        <el-button @click="$inertia.visit(route('office.qrd.manage.training-program-submission.index'))">
                            Batal
                        </el-button>
                        <el-button 
                            type="primary" 
                            @click="submit($refs.formRef, 'DRAFT')"
                            :loading="loading">
                            <i class="fas fa-save mr-2"></i>
                            {{ isEditMode ? 'Update' : 'Simpan' }} Pengajuan (Draft)
                        </el-button>
                        <el-button 
                            type="primary" 
                            @click="submit($refs.formRef, 'PENDING')"
                            :loading="loading">
                            <i class="fas fa-save mr-2"></i>
                            {{ isEditMode ? 'Update & ' : '' }}Ajukan Pengajuan
                        </el-button>
                    </div>
                </el-form>
            </div>
        </template>
    </OfficeLayout>
</template>

<style scoped>
.form-item {
    margin-bottom: 18px;
}

.form-item label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: #606266;
}
</style> 