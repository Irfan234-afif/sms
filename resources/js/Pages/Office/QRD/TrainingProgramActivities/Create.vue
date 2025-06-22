<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link, router, useForm } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import { ref, reactive, computed } from 'vue';
import { ElForm, ElFormItem, ElInput, ElSelect, ElOption, ElDatePicker, ElButton, ElRow, ElCol, ElCard, ElMessage, ElLoading } from 'element-plus';

const props = defineProps({
  training_programs: {
    type: Array,
    default: () => []
  },
  approved_submissions: {
    type: Array,
    default: () => []
  },
  available_participants: {
    type: Array,
    default: () => []
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
  { label: 'Buat Baru', href: route('office.qrd.activity.training-program-activity.create') }
];

const form = useForm({
  title: '',
  description: '',
  training_program_id: '',
  submission_id: '',
  start_date: '',
  end_date: '',
  status: 'planned',
  participant_ids: []
});

const formRef = ref();
const creationType = ref('manual'); // 'manual' or 'from_program' or 'from_submission'

// AJAX data
const trainingPrograms = ref([]);
const approvedSubmissions = ref([]);
const availableParticipants = ref([]);

// Loading states
const loadingPrograms = ref(false);
const loadingSubmissions = ref(false);
const loadingParticipants = ref(false);

const rules = reactive({
  title: [
    { required: true, message: 'Judul aktivitas wajib diisi', trigger: 'blur' }
  ],
  start_date: [
    { required: true, message: 'Tanggal mulai wajib diisi', trigger: 'change' }
  ],
  end_date: [
    { required: true, message: 'Tanggal selesai wajib diisi', trigger: 'change' }
  ],
  status: [
    { required: true, message: 'Status aktivitas wajib dipilih', trigger: 'change' }
  ],
  participant_ids: [
    { required: true, type: 'array', min: 1, message: 'Minimal pilih 1 peserta', trigger: 'change' }
  ]
});

// Fetch training programs with search
const fetchTrainingPrograms = async (query = '') => {
  if (loadingPrograms.value) return;
  
  loadingPrograms.value = true;
  try {
    const response = await fetch(route('office.qrd.activity.training-program-activity.ajax.trainingPrograms') + 
      (query ? `?search=${encodeURIComponent(query)}` : ''), {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    });
    
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    
    const data = await response.json();
    trainingPrograms.value = data.data;
  } catch (error) {
    console.error('Error fetching training programs:', error);
    ElMessage.error('Gagal memuat program pelatihan');
  } finally {
    loadingPrograms.value = false;
  }
};

// Fetch approved submissions with search
const fetchApprovedSubmissions = async (query = '') => {
  if (loadingSubmissions.value) return;
  
  loadingSubmissions.value = true;
  try {
    const response = await fetch(route('office.qrd.activity.training-program-activity.ajax.approvedSubmissions') + 
      (query ? `?search=${encodeURIComponent(query)}` : ''), {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    });
    
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    
    const data = await response.json();
    approvedSubmissions.value = data.data;
  } catch (error) {
    console.error('Error fetching approved submissions:', error);
    ElMessage.error('Gagal memuat pengajuan yang disetujui');
  } finally {
    loadingSubmissions.value = false;
  }
};

// Fetch available participants with search
const fetchAvailableParticipants = async (query = '') => {
  if (loadingParticipants.value) return;
  
  loadingParticipants.value = true;
  try {
    const response = await fetch(route('office.qrd.activity.training-program-activity.ajax.availableParticipants') + 
      (query ? `?search=${encodeURIComponent(query)}` : ''), {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    });
    
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    
    const data = await response.json();
    availableParticipants.value = data.data;
  } catch (error) {
    console.error('Error fetching available participants:', error);
    ElMessage.error('Gagal memuat daftar peserta');
  } finally {
    loadingParticipants.value = false;
  }
};

const submitForm = async () => {
  if (!formRef.value) return;
  
  await formRef.value.validate((valid) => {
    if (valid) {
      // Ensure participant_ids array is not empty
      if (!form.participant_ids || form.participant_ids.length === 0) {
        ElMessage.error('Minimal pilih 1 peserta pelatihan');
        return;
      }

      form.post(route('office.qrd.activity.training-program-activity.store'), {
        onSuccess: (page) => {
          ElMessage.success('Aktivitas pelatihan berhasil dibuat');
        },
        onError: (errors) => {
          console.log('Form errors:', errors);

          if (errors.general) {
            ElMessage.error(errors.general);
          } else if (errors.title) {
            ElMessage.error(errors.title);
          } else if (errors.participant_ids) {
            ElMessage.error(errors.participant_ids);
          } else if (errors.training_program_id) {
            ElMessage.error(errors.training_program_id);
          } else if (errors.submission_id) {
            ElMessage.error(errors.submission_id);
          } else {
            const firstError = Object.values(errors)[0];
            if (firstError) {
              ElMessage.error(Array.isArray(firstError) ? firstError[0] : firstError);
            } else {
              ElMessage.error('Terjadi kesalahan. Silakan periksa form Anda.');
            }
          }
        }
      });
    } else {
      ElMessage.error('Silakan lengkapi form yang wajib diisi');
    }
  });
};

const onCreationTypeChange = () => {
  // Reset form when changing creation type
  form.training_program_id = '';
  form.submission_id = '';
  form.title = '';
  form.description = '';
  form.participant_ids = [];
  
  // Load initial data based on type
  if (creationType.value === 'from_program') {
    fetchTrainingPrograms();
  } else if (creationType.value === 'from_submission') {
    fetchApprovedSubmissions();
  }
};

const onTrainingProgramChange = () => {
  const selectedProgram = trainingPrograms.value.find(p => p.value === form.training_program_id);
  if (selectedProgram) {
    form.title = selectedProgram.label;
    form.description = selectedProgram.description;
  }
};

const onSubmissionChange = () => {
  const selectedSubmission = approvedSubmissions.value.find(s => s.value === form.submission_id);
  if (selectedSubmission) {
    form.title = selectedSubmission.title;
    form.description = selectedSubmission.description;
    form.start_date = selectedSubmission.start_date;
    form.end_date = selectedSubmission.end_date;
  }
};

// Load participants on component mount
fetchAvailableParticipants();
</script>

<template>
  <Head title="Buat Aktivitas Pelatihan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <div class="bg-white">
        <div class="p-6">
          <div class="mb-6">
            <h1 class="text-2xl font-bold text-gray-900">Buat Aktivitas Pelatihan Baru</h1>
            <p class="mt-2 text-sm text-gray-600">
              Buat aktivitas pelatihan baru dari program yang sudah ada, pengajuan yang disetujui, atau secara manual.
            </p>
          </div>

          <ElForm ref="formRef" :model="form" :rules="rules" label-width="160px" label-position="top">
            <!-- Creation Type Selection -->
            <ElCard class="mb-6">
              <template #header>
                <h3 class="text-lg font-medium">Tipe Pembuatan</h3>
              </template>
              
              <ElFormItem label="Pilih cara pembuatan aktivitas">
                <ElSelect v-model="creationType" @change="onCreationTypeChange" placeholder="Pilih tipe pembuatan">
                  <ElOption label="Manual (Buat dari awal)" value="manual" />
                  <ElOption label="Dari Program Pelatihan" value="from_program" />
                  <ElOption label="Dari Pengajuan yang Disetujui" value="from_submission" />
                </ElSelect>
              </ElFormItem>

              <!-- From Training Program -->
              <ElFormItem v-if="creationType === 'from_program'" label="Program Pelatihan">
                <ElSelect 
                  v-model="form.training_program_id" 
                  @change="onTrainingProgramChange"
                  placeholder="Pilih program pelatihan"
                  clearable
                  filterable
                  remote
                  :remote-method="fetchTrainingPrograms"
                  :loading="loadingPrograms"
                  no-data-text="Tidak ada program ditemukan"
                  no-match-text="Tidak ada program yang cocok"
                >
                  <ElOption 
                    v-for="program in trainingPrograms" 
                    :key="program.value" 
                    :label="program.label" 
                    :value="program.value"
                  />
                </ElSelect>
              </ElFormItem>

              <!-- From Submission -->
              <ElFormItem v-if="creationType === 'from_submission'" label="Pengajuan yang Disetujui">
                <ElSelect 
                  v-model="form.submission_id" 
                  @change="onSubmissionChange"
                  placeholder="Pilih pengajuan yang sudah disetujui"
                  clearable
                  filterable
                  remote
                  :remote-method="fetchApprovedSubmissions"
                  :loading="loadingSubmissions"
                  no-data-text="Tidak ada pengajuan ditemukan"
                  no-match-text="Tidak ada pengajuan yang cocok"
                >
                  <ElOption 
                    v-for="submission in approvedSubmissions" 
                    :key="submission.value" 
                    :label="submission.label" 
                    :value="submission.value"
                  />
                </ElSelect>
              </ElFormItem>
            </ElCard>

            <!-- Basic Information -->
            <ElCard class="mb-6">
              <template #header>
                <h3 class="text-lg font-medium">Informasi Dasar</h3>
              </template>

              <ElRow :gutter="20">
                <ElCol :span="24">
                  <ElFormItem label="Judul Aktivitas" prop="title">
                    <ElInput 
                      v-model="form.title" 
                      placeholder="Masukkan judul aktivitas pelatihan"
                      :disabled="form.processing"
                    />
                  </ElFormItem>
                </ElCol>
              </ElRow>

              <ElRow :gutter="20">
                <ElCol :span="24">
                  <ElFormItem label="Deskripsi">
                    <ElInput 
                      v-model="form.description" 
                      type="textarea"
                      :rows="4"
                      placeholder="Masukkan deskripsi aktivitas pelatihan"
                      :disabled="form.processing"
                    />
                  </ElFormItem>
                </ElCol>
              </ElRow>

              <ElRow :gutter="20">
                <ElCol :span="12">
                  <ElFormItem label="Tanggal Mulai" prop="start_date">
                    <ElDatePicker
                      v-model="form.start_date"
                      type="date"
                      placeholder="Pilih tanggal mulai"
                      format="DD/MM/YYYY"
                      value-format="YYYY-MM-DD"
                      :disabled="form.processing"
                      style="width: 100%"
                    />
                  </ElFormItem>
                </ElCol>
                <ElCol :span="12">
                  <ElFormItem label="Tanggal Selesai" prop="end_date">
                    <ElDatePicker
                      v-model="form.end_date"
                      type="date"
                      placeholder="Pilih tanggal selesai"
                      format="DD/MM/YYYY"
                      value-format="YYYY-MM-DD"
                      :disabled="form.processing"
                      style="width: 100%"
                    />
                  </ElFormItem>
                </ElCol>
              </ElRow>

              <ElRow :gutter="20">
                <ElCol :span="12">
                  <ElFormItem label="Status" prop="status">
                    <ElSelect v-model="form.status" :disabled="form.processing" placeholder="Pilih status aktivitas">
                      <ElOption label="Direncanakan" value="planned" />
                      <ElOption label="Berlangsung" value="ongoing" />
                      <ElOption label="Selesai" value="completed" />
                    </ElSelect>
                  </ElFormItem>
                </ElCol>
              </ElRow>
            </ElCard>

            <!-- Participants Selection -->
            <ElCard class="mb-6">
              <template #header>
                <h3 class="text-lg font-medium">Peserta Pelatihan</h3>
              </template>

              <ElFormItem label="Pilih Peserta" prop="participant_ids">
                <ElSelect 
                  v-model="form.participant_ids" 
                  multiple
                  filterable
                  remote
                  :remote-method="fetchAvailableParticipants"
                  :loading="loadingParticipants"
                  placeholder="Ketik untuk mencari peserta pelatihan"
                  :disabled="form.processing"
                  style="width: 100%"
                  no-data-text="Tidak ada peserta ditemukan"
                  no-match-text="Tidak ada peserta yang cocok"
                >
                  <ElOption 
                    v-for="participant in availableParticipants" 
                    :key="participant.value" 
                    :label="participant.label" 
                    :value="participant.value"
                  />
                </ElSelect>
              </ElFormItem>

              <div v-if="form.participant_ids.length > 0" class="mt-4">
                <p class="text-sm text-gray-600 mb-2">Peserta yang dipilih: {{ form.participant_ids.length }} orang</p>
                <div class="flex flex-wrap gap-2">
                  <span 
                    v-for="participantId in form.participant_ids" 
                    :key="participantId"
                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                  >
                    {{ availableParticipants.find(p => p.value === participantId)?.name || 'Loading...' }}
                  </span>
                </div>
              </div>
            </ElCard>

            <!-- Form Actions -->
            <div class="flex justify-between">
              <Link :href="route('office.qrd.activity.training-program-activity.index')">
                <ElButton :disabled="form.processing">
                  Kembali
                </ElButton>
              </Link>
              
              <div class="space-x-2">
                <ElButton 
                  type="primary" 
                  @click="submitForm"
                  :loading="form.processing"
                  :disabled="form.processing"
                >
                  {{ form.processing ? 'Menyimpan...' : 'Simpan Aktivitas' }}
                </ElButton>
              </div>
            </div>
          </ElForm>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 