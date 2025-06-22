<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, useForm } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, onMounted, computed } from 'vue';
import { ElForm, ElFormItem, ElInput, ElSelect, ElOption, ElDatePicker, ElButton, ElMessage } from 'element-plus';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  }
});

const breadcrumbs = computed(() => [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Program Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
  { 
    label: props.activity.title, 
    href: props.activity.uuid ? route('office.qrd.activity.training-program-activity.show', props.activity.uuid) : '#'
  },
  { label: 'Edit', href: '#' }
]);

const form = useForm({
  title: props.activity.title || '',
  description: props.activity.description || '',
  training_program_id: props.activity.training_program?.uuid || '',
  submission_id: props.activity.submission?.uuid || '',
  start_date: props.activity.start_date || '',
  end_date: props.activity.end_date || '',
  status: props.activity.status?.toLowerCase() || 'planned',
  participant_ids: props.activity.participants?.map(p => p.profile.uuid) || []
});

// AJAX data for participants
const availableParticipants = ref([]);
const loadingParticipants = ref(false);

// Creation mode based on existing data
const creationMode = ref(props.activity.submission ? 'submission' : 
                        props.activity.training_program ? 'training_program' : 'manual');

// Fetch available participants with search
const fetchAvailableParticipants = async (query = '') => {
  if (loadingParticipants.value) return;
  
  loadingParticipants.value = true;
  try {
    console.log('Fetching participants with query:', query);
    const response = await window.axios.get(route('office.qrd.activity.training-program-activity.ajax.availableParticipants'), {
      params: { search: query }
    });
    console.log('Participants response:', response.data);
    availableParticipants.value = response.data.data;
  } catch (error) {
    console.error('Error fetching available participants:', error);
    ElMessage.error('Gagal memuat daftar peserta');
  } finally {
    loadingParticipants.value = false;
  }
};

const updateActivity = () => {
  if (!props.activity.uuid) {
    ElMessage.error('Error: Activity UUID tidak ditemukan');
    return;
  }
  
  console.log('Updating activity with data:', form.data());
  
  form.put(route('office.qrd.activity.training-program-activity.update', props.activity.uuid), {
    preserveScroll: true,
    onSuccess: () => {
      ElMessage.success('Aktivitas berhasil diperbarui');
    },
    onError: (errors) => {
      console.log('Form errors:', errors);
      if (errors.general) {
        ElMessage.error(errors.general);
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
};

// Load initial participants data
onMounted(() => {
  console.log('Current activity:', props.activity);
  console.log('Current form data:', form.data());
  fetchAvailableParticipants();
});
</script>

<template>
  <Head title="Edit Aktivitas Program Pelatihan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <h1 class="text-2xl font-bold text-gray-900">Edit Aktivitas Program Pelatihan</h1>
        <p class="mt-1 text-sm text-gray-600">
          Perbarui informasi aktivitas program pelatihan.
        </p>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <div class="p-6">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow">
          <div class="p-6">
            <ElForm @submit.prevent="updateActivity" label-position="top">
              <!-- Mode Pembuatan -->
              <div class="mb-6">
                <label class="text-base font-medium text-gray-900">Mode Pembuatan</label>
                <p class="text-sm leading-5 text-gray-500">Mode pembuatan aktivitas ini (tidak dapat diubah).</p>
                <div class="mt-4 space-y-2">
                  <div class="flex items-center">
                    <input 
                      id="manual" 
                      :checked="creationMode === 'manual'"
                      name="creation_mode" 
                      type="radio" 
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                      disabled
                    />
                    <label for="manual" class="ml-3 block text-sm font-medium leading-6 text-gray-900">
                      Manual
                    </label>
                  </div>
                  <div class="flex items-center">
                    <input 
                      id="training_program" 
                      :checked="creationMode === 'training_program'"
                      name="creation_mode" 
                      type="radio" 
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                      disabled
                    />
                    <label for="training_program" class="ml-3 block text-sm font-medium leading-6 text-gray-900">
                      Dari Program Pelatihan: {{ activity.training_program?.name || 'N/A' }}
                    </label>
                  </div>
                  <div class="flex items-center">
                    <input 
                      id="submission" 
                      :checked="creationMode === 'submission'"
                      name="creation_mode" 
                      type="radio" 
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                      disabled
                    />
                    <label for="submission" class="ml-3 block text-sm font-medium leading-6 text-gray-900">
                      Dari Pengajuan: {{ activity.submission?.reference_number || 'N/A' }}
                    </label>
                  </div>
                </div>
              </div>

              <!-- Basic Information -->
              <div class="space-y-6">
                <ElFormItem label="Judul Aktivitas" required>
                  <ElInput 
                    v-model="form.title" 
                    placeholder="Masukkan judul aktivitas"
                    maxlength="255"
                    show-word-limit
                  />
                  <div v-if="form.errors.title" class="text-red-600 text-sm">{{ form.errors.title }}</div>
                </ElFormItem>

                <ElFormItem label="Deskripsi">
                  <ElInput 
                    v-model="form.description" 
                    type="textarea" 
                    :rows="4"
                    placeholder="Masukkan deskripsi aktivitas"
                  />
                  <div v-if="form.errors.description" class="text-red-600 text-sm">{{ form.errors.description }}</div>
                </ElFormItem>

                <div class="grid grid-cols-2 gap-6">
                  <ElFormItem label="Tanggal Mulai" required>
                    <ElDatePicker
                      v-model="form.start_date"
                      type="date"
                      placeholder="Pilih tanggal mulai"
                      format="DD/MM/YYYY"
                      value-format="YYYY-MM-DD"
                      style="width: 100%"
                    />
                    <div v-if="form.errors.start_date" class="text-red-600 text-sm">{{ form.errors.start_date }}</div>
                  </ElFormItem>

                  <ElFormItem label="Tanggal Selesai" required>
                    <ElDatePicker
                      v-model="form.end_date"
                      type="date"
                      placeholder="Pilih tanggal selesai"
                      format="DD/MM/YYYY"
                      value-format="YYYY-MM-DD"
                      style="width: 100%"
                    />
                    <div v-if="form.errors.end_date" class="text-red-600 text-sm">{{ form.errors.end_date }}</div>
                  </ElFormItem>
                </div>

                <ElFormItem label="Status" required>
                  <ElSelect v-model="form.status" placeholder="Pilih status" style="width: 100%">
                    <ElOption label="Direncanakan" value="planned" />
                    <ElOption label="Sedang Berlangsung" value="ongoing" />
                    <ElOption label="Selesai" value="completed" />
                    <ElOption label="Dibatalkan" value="cancelled" />
                  </ElSelect>
                  <div v-if="form.errors.status" class="text-red-600 text-sm">{{ form.errors.status }}</div>
                </ElFormItem>

                <!-- Participants Selection with AJAX -->
                <ElFormItem label="Peserta" required>
                  <ElSelect 
                    v-model="form.participant_ids" 
                    multiple 
                    filterable
                    remote
                    :remote-method="fetchAvailableParticipants"
                    :loading="loadingParticipants"
                    placeholder="Ketik untuk mencari peserta"
                    style="width: 100%"
                    collapse-tags
                    collapse-tags-tooltip
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
                  <div v-if="form.errors.participant_ids" class="text-red-600 text-sm">{{ form.errors.participant_ids }}</div>
                  <div class="text-sm text-gray-500 mt-1">
                    {{ form.participant_ids.length }} peserta dipilih
                  </div>
                  
                  <!-- Selected participants display -->
                  <div v-if="form.participant_ids.length > 0" class="mt-3">
                    <p class="text-sm text-gray-600 mb-2">Peserta yang dipilih:</p>
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
                </ElFormItem>
              </div>

              <!-- Actions -->
              <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                <OutlineButton 
                  type="secondary" 
                  @click="$inertia.get(route('office.qrd.activity.training-program-activity.show', activity.uuid))"
                >
                  Batal
                </OutlineButton>
                <ElButton 
                  type="primary" 
                  native-type="submit" 
                  :loading="form.processing"
                >
                  Perbarui Aktivitas
                </ElButton>
              </div>
            </ElForm>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 