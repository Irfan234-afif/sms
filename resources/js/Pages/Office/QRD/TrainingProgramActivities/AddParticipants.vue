<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, useForm } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, computed } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  employees: {
    type: Array,
    default: () => []
  },
  current_participants: {
    type: Array,
    default: () => []
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Program Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
  { label: props.activity.title, href: route('office.qrd.activity.training-program-activity.show', props.activity.uuid) },
  { label: 'Tambah Peserta', href: '#' }
];

const form = useForm({
  participant_ids: []
});

const searchQuery = ref('');
const selectedArea = ref('');

const currentParticipantIds = computed(() => {
  return props.current_participants.map(p => p.profile_id);
});

const availableEmployees = computed(() => {
  return props.employees.filter(employee => 
    !currentParticipantIds.value.includes(employee.uuid)
  );
});

const filteredEmployees = computed(() => {
  let filtered = availableEmployees.value;

  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase();
    filtered = filtered.filter(employee => 
      employee.full_name.toLowerCase().includes(query) ||
      employee.position?.toLowerCase().includes(query) ||
      employee.area?.name?.toLowerCase().includes(query)
    );
  }

  if (selectedArea.value) {
    filtered = filtered.filter(employee => 
      employee.area?.uuid === selectedArea.value
    );
  }

  return filtered;
});

const availableAreas = computed(() => {
  const areas = availableEmployees.value
    .map(employee => employee.area)
    .filter(area => area !== null && area !== undefined);
  
  const uniqueAreas = areas.reduce((acc, area) => {
    if (!acc.find(a => a.uuid === area.uuid)) {
      acc.push(area);
    }
    return acc;
  }, []);

  return uniqueAreas.sort((a, b) => a.name.localeCompare(b.name));
});

const isSelected = (employeeId) => {
  return form.participant_ids.includes(employeeId);
};

const toggleSelection = (employeeId) => {
  const index = form.participant_ids.indexOf(employeeId);
  if (index > -1) {
    form.participant_ids.splice(index, 1);
  } else {
    form.participant_ids.push(employeeId);
  }
};

const selectAll = () => {
  form.participant_ids = [...filteredEmployees.value.map(emp => emp.uuid)];
};

const clearAll = () => {
  form.participant_ids = [];
};

const addParticipants = () => {
  if (!props.activity.uuid) {
    alert('Error: Activity UUID tidak ditemukan');
    return;
  }
  
  if (form.participant_ids.length === 0) {
    alert('Pilih minimal satu peserta');
    return;
  }
  
  form.post(route('office.qrd.activity.training-program-activity.storeParticipants', props.activity.uuid));
};

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};
</script>

<template>
  <Head title="Tambah Peserta" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <h1 class="text-2xl font-bold text-gray-900">Tambah Peserta</h1>
        <p class="mt-1 text-sm text-gray-600">
          Tambahkan peserta baru ke aktivitas "{{ activity.title }}"
        </p>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <div class="p-6">
        <div class="max-w-6xl mx-auto space-y-6">
          <!-- Activity Info -->
          <div class="bg-white rounded-lg shadow p-6">
            <h2 class="text-lg font-medium text-gray-900 mb-4">Informasi Aktivitas</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div>
                <dt class="text-sm font-medium text-gray-500">Judul</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ activity.title }}</dd>
              </div>
              <div>
                <dt class="text-sm font-medium text-gray-500">Status</dt>
                <dd class="mt-1 text-sm text-gray-900">
                  <Badge :type="activity.status === 'ONGOING' ? 'green' : activity.status === 'COMPLETED' ? 'blue' : 'yellow'">
                    {{ activity.status === 'ONGOING' ? 'Sedang Berlangsung' : 
                       activity.status === 'COMPLETED' ? 'Selesai' : 
                       activity.status === 'PLANNED' ? 'Direncanakan' : 'Dibatalkan' }}
                  </Badge>
                </dd>
              </div>
              <div>
                <dt class="text-sm font-medium text-gray-500">Peserta Saat Ini</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ current_participants.length }} orang</dd>
              </div>
            </div>
          </div>

          <!-- Search and Filter -->
          <div class="bg-white rounded-lg shadow p-6">
            <div class="flex flex-col sm:flex-row gap-4 mb-6">
              <div class="flex-1">
                <el-input 
                  v-model="searchQuery" 
                  placeholder="Cari berdasarkan nama, posisi, atau area..." 
                  clearable
                >
                  <template #prefix>
                    <svg class="h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                  </template>
                </el-input>
              </div>
              <div class="w-full sm:w-64">
                <el-select 
                  v-model="selectedArea" 
                  placeholder="Filter berdasarkan area" 
                  clearable
                  class="w-full"
                >
                  <el-option 
                    v-for="area in availableAreas" 
                    :key="area.uuid" 
                    :label="area.name" 
                    :value="area.uuid" 
                  />
                </el-select>
              </div>
            </div>

            <!-- Selection Controls -->
            <div class="flex items-center justify-between mb-4">
              <div class="text-sm text-gray-600">
                {{ form.participant_ids.length }} dari {{ filteredEmployees.length }} dipilih
              </div>
              <div class="space-x-2">
                <OutlineButton @click="selectAll" type="secondary" size="sm">
                  Pilih Semua
                </OutlineButton>
                <OutlineButton @click="clearAll" type="secondary" size="sm">
                  Hapus Pilihan
                </OutlineButton>
              </div>
            </div>

            <!-- Employee List -->
            <div v-if="filteredEmployees.length > 0" class="space-y-2 max-h-96 overflow-y-auto">
              <div 
                v-for="employee in filteredEmployees" 
                :key="employee.uuid"
                @click="toggleSelection(employee.uuid)"
                :class="[
                  'p-4 border rounded-lg cursor-pointer transition-colors',
                  isSelected(employee.uuid) 
                    ? 'border-blue-500 bg-blue-50' 
                    : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                ]"
              >
                <div class="flex items-center justify-between">
                  <div class="flex items-center space-x-4">
                    <div 
                      :class="[
                        'w-5 h-5 rounded border-2 flex items-center justify-center transition-colors',
                        isSelected(employee.uuid) 
                          ? 'border-blue-500 bg-blue-500' 
                          : 'border-gray-300'
                      ]"
                    >
                      <svg 
                        v-if="isSelected(employee.uuid)" 
                        class="w-3 h-3 text-white" 
                        fill="none" 
                        stroke="currentColor" 
                        viewBox="0 0 24 24"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                      </svg>
                    </div>
                    <div>
                      <div class="font-medium text-gray-900">{{ employee.full_name }}</div>
                      <div class="text-sm text-gray-600">{{ employee.position || '-' }}</div>
                    </div>
                  </div>
                  <div class="text-right">
                    <div class="text-sm font-medium text-gray-900">{{ employee.area?.name || '-' }}</div>
                    <div class="text-xs text-gray-500">{{ employee.employee_id || '-' }}</div>
                  </div>
                </div>
              </div>
            </div>

            <!-- No Results -->
            <div v-else class="text-center py-8">
              <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
              </svg>
              <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak Ada Karyawan</h3>
              <p class="mt-1 text-sm text-gray-500">
                {{ searchQuery || selectedArea ? 'Tidak ditemukan karyawan yang sesuai dengan filter.' : 'Semua karyawan sudah menjadi peserta aktivitas ini.' }}
              </p>
            </div>
          </div>

          <!-- Form Actions -->
          <div class="bg-white rounded-lg shadow p-6">
            <form @submit.prevent="addParticipants">
              <div class="flex justify-between items-center">
                <div class="text-sm text-gray-600">
                  <span v-if="form.participant_ids.length > 0">
                    {{ form.participant_ids.length }} peserta akan ditambahkan
                  </span>
                  <span v-else>
                    Pilih peserta yang ingin ditambahkan
                  </span>
                </div>
                <div class="space-x-3">
                  <OutlineButton 
                    type="secondary" 
                    @click="activity.uuid ? $inertia.get(route('office.qrd.activity.training-program-activity.show', activity.uuid)) : $inertia.get(route('office.qrd.activity.training-program-activity.index'))"
                  >
                    Batal
                  </OutlineButton>
                  <el-button 
                    type="primary" 
                    native-type="submit" 
                    :loading="form.processing"
                    :disabled="form.participant_ids.length === 0"
                  >
                    Tambah {{ form.participant_ids.length }} Peserta
                  </el-button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 