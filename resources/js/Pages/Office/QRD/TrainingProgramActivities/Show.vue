<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, computed } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
  { label: props.activity.title, href: '#' }
];

// Helper functions
const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};

const formatDateTime = (datetime) => {
  if (!datetime) return '-';
  return new Date(datetime).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
};

const getStatusColor = (status) => {
  const statusColors = {
    'PLANNED': 'blue',
    'ONGOING': 'yellow', 
    'COMPLETED': 'green',
    'CANCELLED': 'red'
  };
  return statusColors[status] || 'gray';
};

const getStatusLabel = (status) => {
  const statusLabels = {
    'PLANNED': 'Direncanakan',
    'ONGOING': 'Sedang Berlangsung',
    'COMPLETED': 'Selesai', 
    'CANCELLED': 'Dibatalkan'
  };
  return statusLabels[status] || status;
};

// Actions
const updateStatus = (newStatus) => {
  const statusLabels = {
    'ongoing': 'Sedang Berlangsung',
    'completed': 'Selesai',
    'cancelled': 'Dibatalkan'
  };
  
  if (confirm(`Apakah Anda yakin ingin mengubah status menjadi ${statusLabels[newStatus]}?`)) {
    router.post(route('office.qrd.activity.training-program-activity.updateStatus', props.activity.uuid), {
      status: newStatus
    }, {
      preserveScroll: true,
    });
  }
};

const removeParticipant = (participant) => {
  if (!props.activity.uuid || !participant.uuid) {
    alert('Error: UUID tidak ditemukan');
    return;
  }
  
  if (confirm('Apakah Anda yakin ingin menghapus peserta ini?')) {
    router.delete(route('office.qrd.activity.training-program-activity.removeParticipant', {
      uuid: props.activity.uuid,
      participantUuid: participant.uuid
    }), {
      preserveScroll: true,
    });
  }
};

const issueCertificate = (participant) => {
  if (!props.activity.uuid || !participant.uuid) {
    alert('Error: UUID tidak ditemukan');
    return;
  }
  
  if (confirm('Apakah Anda yakin ingin menerbitkan sertifikat untuk peserta ini?')) {
    router.post(route('office.qrd.activity.training-program-activity.issueCertificate', {
      uuid: props.activity.uuid,
      participantUuid: participant.uuid
    }), {}, {
      preserveScroll: true,
    });
  }
};

const revokeCertificate = (participant) => {
  if (!props.activity.uuid || !participant.uuid) {
    alert('Error: UUID tidak ditemukan');
    return;
  }
  
  if (confirm('Apakah Anda yakin ingin mencabut sertifikat untuk peserta ini?')) {
    router.post(route('office.qrd.activity.training-program-activity.revokeCertificate', {
      uuid: props.activity.uuid,
      participantUuid: participant.uuid
    }), {}, {
      preserveScroll: true,
    });
  }
};

// Computed properties
const overallProgress = computed(() => {
  if (!props.activity.participants || props.activity.participants.length === 0) return 0;
  
  const totalProgress = props.activity.participants.reduce((sum, participant) => {
    return sum + (participant.overall_progress || 0);
  }, 0);
  
  return Math.round(totalProgress / props.activity.participants.length);
});

const completedParticipants = computed(() => {
  return props.activity.participants ? props.activity.participants.filter(p => p.completion_date).length : 0;
});

const certificateStats = computed(() => {
  if (!props.activity.participants) return { issued: 0, pending: 0 };
  
  const issued = props.activity.participants.filter(p => p.certificate_issued).length;
  const completed = props.activity.participants.filter(p => p.has_completed).length;
  
  return {
    issued,
    pending: completed - issued
  };
});
</script>

<template>
  <Head :title="activity.title" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ activity.title }}</h1>
            <p class="mt-1 text-sm text-gray-600">Detail aktivitas pelatihan dan pengelolaan peserta</p>
          </div>
          <div class="flex items-center space-x-3">
            <Badge :type="getStatusColor(activity.status)">
              {{ getStatusLabel(activity.status) }}
            </Badge>
            <Link v-if="activity.status === 'PLANNED' && activity.uuid" :href="route('office.qrd.activity.training-program-activity.edit', activity.uuid)">
              <OutlineButton type="yellow">
                <div class="flex items-center space-x-1">
                  <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"></path>
                  </svg>
                  <span>Edit</span>
                </div>
              </OutlineButton>
            </Link>
          </div>
        </div>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <div class="flex h-full bg-gray-50">
        <!-- Left Sidebar - Activity Info & Actions -->
        <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
          <div class="p-4 space-y-6">
            
            <!-- Basic Activity Info -->
            <div>
              <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Aktivitas</h3>
              <div class="bg-gray-50 rounded-lg p-4 space-y-3">
                <div>
                  <span class="text-sm font-medium text-gray-700">Program Pelatihan</span>
                  <p class="text-gray-900 mt-1">
                    {{ activity.training_program?.name || 'Manual Activity' }}
                  </p>
                </div>
                <div>
                  <span class="text-sm font-medium text-gray-700">Periode</span>
                  <p class="text-gray-900 mt-1">
                    {{ formatDate(activity.start_date) }} - {{ formatDate(activity.end_date) }}
                  </p>
                </div>
                <div v-if="activity.submission">
                  <span class="text-sm font-medium text-gray-700">Pengajuan Terkait</span>
                  <p class="text-gray-900 mt-1">{{ activity.submission.reference_number }}</p>
                </div>
                <div v-if="activity.description">
                  <span class="text-sm font-medium text-gray-700">Deskripsi</span>
                  <p class="text-gray-900 mt-1 text-sm">{{ activity.description }}</p>
                </div>
              </div>
            </div>

            <!-- Statistics -->
            <div>
              <h3 class="text-lg font-medium text-gray-900 mb-4">Statistik</h3>
              <div class="grid grid-cols-2 gap-3">
                <div class="bg-blue-50 rounded-lg p-3 text-center">
                  <div class="text-2xl font-bold text-blue-600">{{ activity.participants?.length || 0 }}</div>
                  <div class="text-xs text-blue-700">Total Peserta</div>
                </div>
                <div class="bg-green-50 rounded-lg p-3 text-center">
                  <div class="text-2xl font-bold text-green-600">{{ completedParticipants }}</div>
                  <div class="text-xs text-green-700">Selesai</div>
                </div>
                <div class="bg-purple-50 rounded-lg p-3 text-center">
                  <div class="text-2xl font-bold text-purple-600">{{ overallProgress }}%</div>
                  <div class="text-xs text-purple-700">Progress Rata-rata</div>
                </div>
                <div class="bg-yellow-50 rounded-lg p-3 text-center">
                  <div class="text-2xl font-bold text-yellow-600">{{ certificateStats.issued }}</div>
                  <div class="text-xs text-yellow-700">Sertifikat Terbit</div>
                </div>
              </div>
            </div>

            <!-- Status Management -->
            <div>
              <h3 class="text-lg font-medium text-gray-900 mb-4">Kelola Status</h3>
              <div class="space-y-2">
                <button 
                  v-if="activity.status === 'PLANNED'" 
                  @click="updateStatus('ongoing')"
                  class="w-full bg-green-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-green-700 transition-colors"
                >
                  🚀 Mulai Aktivitas
                </button>
                <button 
                  v-if="activity.status === 'ONGOING'" 
                  @click="updateStatus('completed')"
                  class="w-full bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors"
                >
                  ✅ Selesaikan Aktivitas
                </button>
                <button 
                  v-if="activity.status !== 'CANCELLED' && activity.status !== 'COMPLETED'" 
                  @click="updateStatus('cancelled')"
                  class="w-full bg-red-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-red-700 transition-colors"
                >
                  ❌ Batalkan Aktivitas
                </button>
              </div>
            </div>

            <!-- Participant Management -->
            <div>
              <h3 class="text-lg font-medium text-gray-900 mb-4">Kelola Peserta</h3>
              <Link 
                v-if="['PLANNED', 'ONGOING'].includes(activity.status) && activity.uuid"
                :href="route('office.qrd.activity.training-program-activity.addParticipants', activity.uuid)"
                class="block"
              >
                <OutlineButton type="primary" class="w-full justify-center">
                  <div class="flex items-center space-x-2">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                    </svg>
                    <span>Tambah Peserta</span>
                  </div>
                </OutlineButton>
              </Link>
            </div>

          </div>
        </div>

        <!-- Main Content - Participants Table -->
        <div class="flex-1 overflow-hidden">
          <div class="h-full overflow-y-auto">
            <div class="p-6">
              
              <!-- Participants Table -->
              <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                <div class="px-6 py-4 border-b border-gray-200">
                  <div class="flex justify-between items-center">
                    <div>
                      <h2 class="text-lg font-medium text-gray-900">Daftar Peserta</h2>
                      <p class="text-sm text-gray-600 mt-1">
                        {{ activity.participants?.length || 0 }} peserta terdaftar
                      </p>
                    </div>
                  </div>
                </div>

                <div class="overflow-x-auto">
                  <table class="w-full">
                    <thead class="bg-gray-50">
                      <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Peserta</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal Daftar</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Progress</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Sertifikat</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
                      </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                      <tr v-for="participant in activity.participants" :key="participant.uuid" class="hover:bg-gray-50">
                        <td class="px-6 py-4 whitespace-nowrap">
                          <div class="flex items-center">
                            <div class="flex-shrink-0 h-10 w-10">
                              <div class="h-10 w-10 rounded-full bg-gray-300 flex items-center justify-center">
                                <span class="text-sm font-medium text-gray-700">
                                  {{ participant.profile?.name?.charAt(0) || 'N' }}
                                </span>
                              </div>
                            </div>
                            <div class="ml-4">
                              <div class="text-sm font-medium text-gray-900">
                                {{ participant.profile?.name || 'N/A' }}
                              </div>
                              <div class="text-sm text-gray-500">
                                {{ participant.profile?.area?.name || 'N/A' }}
                              </div>
                            </div>
                          </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {{ formatDateTime(participant.enrollment_date) }}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <div class="flex items-center">
                            <div class="w-16 bg-gray-200 rounded-full h-2 mr-2">
                              <div class="bg-blue-600 h-2 rounded-full" 
                                   :style="`width: ${participant.overall_progress || 0}%`"></div>
                            </div>
                            <span class="text-sm text-gray-900">{{ participant.overall_progress || 0 }}%</span>
                          </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <Badge v-if="participant.has_completed" type="green" size="sm">Selesai</Badge>
                          <Badge v-else-if="participant.overall_progress > 0" type="yellow" size="sm">Belajar</Badge>
                          <Badge v-else type="gray" size="sm">Terdaftar</Badge>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <Badge v-if="participant.certificate_issued" type="green" size="sm">Diterbitkan</Badge>
                          <Badge v-else type="gray" size="sm">Belum</Badge>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                          <div class="flex items-center space-x-2">
                            <!-- Detail Button -->
                            <Link v-if="activity.uuid && participant.uuid" :href="route('office.qrd.activity.training-program-activity.participantDetail', {
                              uuid: activity.uuid,
                              participantUuid: participant.uuid
                            })">
                              <OutlineButton type="primary" size="sm">Detail</OutlineButton>
                            </Link>
                            
                            <!-- Certificate Actions -->
                            <template v-if="participant.has_completed">
                              <Link 
                                v-if="participant.certificate_issued"
                                :href="route('office.qrd.activity.training-program-activity.viewParticipantCertificate', {
                                  uuid: activity.uuid,
                                  participantUuid: participant.uuid
                                })"
                              >
                                <OutlineButton type="green" size="sm">Sertifikat</OutlineButton>
                              </Link>
                              <OutlineButton 
                                v-if="participant.certificate_issued && ['PLANNED', 'ONGOING'].includes(activity.status)"
                                type="orange" 
                                size="sm" 
                                @click="revokeCertificate(participant)"
                              >
                                Cabut
                              </OutlineButton>
                              <OutlineButton 
                                v-if="!participant.certificate_issued"
                                type="blue" 
                                size="sm" 
                                @click="issueCertificate(participant)"
                              >
                                Terbitkan
                              </OutlineButton>
                            </template>
                            
                            <!-- Remove Button -->
                            <OutlineButton 
                              v-if="activity.status !== 'COMPLETED' && activity.status !== 'CANCELLED'"
                              type="red" 
                              size="sm" 
                              @click="removeParticipant(participant)"
                            >
                              Hapus
                            </OutlineButton>
                          </div>
                        </td>
                      </tr>
                      
                      <!-- Empty State -->
                      <tr v-if="!activity.participants || activity.participants.length === 0">
                        <td colspan="6" class="px-6 py-12 text-center">
                          <div class="flex flex-col items-center justify-center">
                            <svg class="mb-4 h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"></path>
                            </svg>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Belum ada peserta</h3>
                            <p class="text-gray-500 mb-4">Mulai dengan menambahkan peserta ke aktivitas ini.</p>
                            <Link 
                              v-if="['PLANNED', 'ONGOING'].includes(activity.status) && activity.uuid"
                              :href="route('office.qrd.activity.training-program-activity.addParticipants', activity.uuid)"
                            >
                              <OutlineButton type="primary">
                                <div class="flex items-center space-x-2">
                                  <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                  </svg>
                                  <span>Tambah Peserta</span>
                                </div>
                              </OutlineButton>
                            </Link>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- Training Program Details (if exists) -->
              <div v-if="activity.training_program" class="mt-6 bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <h3 class="text-lg font-medium text-gray-900 mb-4">Detail Program Pelatihan</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <h4 class="font-medium text-gray-900 mb-3">Informasi Program</h4>
                    <dl class="space-y-2">
                      <div class="flex justify-between">
                        <dt class="text-sm text-gray-600">Tipe Program:</dt>
                        <dd class="text-sm font-medium text-gray-900">{{ activity.training_program.type }}</dd>
                      </div>
                      <div class="flex justify-between">
                        <dt class="text-sm text-gray-600">Level:</dt>
                        <dd class="text-sm font-medium text-gray-900">{{ activity.training_program.level }}</dd>
                      </div>
                      <div class="flex justify-between">
                        <dt class="text-sm text-gray-600">Total Fase:</dt>
                        <dd class="text-sm font-medium text-gray-900">{{ activity.training_program.phases?.length || 0 }}</dd>
                      </div>
                      <div class="flex justify-between">
                        <dt class="text-sm text-gray-600">Total Modul:</dt>
                        <dd class="text-sm font-medium text-gray-900">
                          {{ activity.training_program.phases?.reduce((total, phase) => total + (phase.modules?.length || 0), 0) || 0 }}
                        </dd>
                      </div>
                    </dl>
                  </div>
                  
                  <div v-if="activity.training_program.phases">
                    <h4 class="font-medium text-gray-900 mb-3">Fase Pembelajaran</h4>
                    <div class="space-y-2">
                      <div 
                        v-for="(phase, index) in activity.training_program.phases" 
                        :key="phase.uuid"
                        class="flex items-center p-2 bg-gray-50 rounded border"
                      >
                        <div class="flex-shrink-0 w-6 h-6 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                          <span class="text-xs font-medium text-blue-600">{{ index + 1 }}</span>
                        </div>
                        <div class="flex-1">
                          <div class="text-sm font-medium text-gray-900">{{ phase.name }}</div>
                          <div class="text-xs text-gray-500">{{ phase.modules?.length || 0 }} modul</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Back Button -->
              <div class="mt-6 flex justify-start">
                <Link :href="route('office.qrd.activity.training-program-activity.index')">
                  <OutlineButton type="secondary">
                    <div class="flex items-center space-x-2">
                      <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                      </svg>
                      <span>Kembali ke Daftar</span>
                    </div>
                  </OutlineButton>
                </Link>
              </div>

            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 