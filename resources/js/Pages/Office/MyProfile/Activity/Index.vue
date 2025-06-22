<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { computed, onMounted } from 'vue';

const props = defineProps({
  participants: {
    type: Object,
    required: true
  },
  search_params: {
    type: Object,
    default: () => ({})
  }
});

// Extract activities from participants data
const activities = computed(() => {
  return props.participants.data || [];
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') }
];

const getStatusColor = (completed) => {
  return completed ? 'green' : 'blue';
};

const getStatusLabel = (completed) => {
  return completed ? 'Selesai' : 'Sedang Belajar';
};

const getActivityStatusColor = (status) => {
  const colors = {
    'planned': 'gray',
    'ongoing': 'blue',
    'completed': 'green',
    'cancelled': 'red'
  };
  return colors[status?.toLowerCase()] || 'gray';
};

const getActivityStatusLabel = (status) => {
  const labels = {
    'planned': 'Direncanakan',
    'ongoing': 'Berlangsung',
    'completed': 'Selesai',
    'cancelled': 'Dibatalkan'
  };
  return labels[status?.toLowerCase()] || status;
};

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  });
};

const inProgressActivities = computed(() => {
  return activities.value.filter(participant => 
    !participant.completion_date && 
    participant.activity?.status?.toLowerCase() === 'ongoing'
  );
});

const completedActivities = computed(() => {
  return activities.value.filter(participant => participant.completion_date);
});

const upcomingActivities = computed(() => {
  return activities.value.filter(participant => 
    !participant.completion_date && 
    participant.activity?.status?.toLowerCase() === 'planned'
  );
});

onMounted(() => {
  console.log(props.participants);
  console.log(inProgressActivities.value);
});
</script>

<template>
  <Head title="Aktivitas Pelatihan Saya" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <h1 class="text-2xl font-bold text-gray-900">Aktivitas Pelatihan Saya</h1>
        <p class="mt-1 text-sm text-gray-600">
          Pantau progress dan akses materi pelatihan Anda
        </p>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <div class="bg-white">
        <div class="p-6 space-y-6">
          
          <!-- Statistics Cards -->
          <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="bg-white border border-gray-200 rounded-lg p-6">
              <div class="flex items-center">
                <div class="p-2 bg-blue-100 rounded-lg">
                  <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                  </svg>
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-600">Sedang Berlangsung</p>
                  <p class="text-2xl font-semibold text-gray-900">{{ inProgressActivities.length }}</p>
                </div>
              </div>
            </div>

            <div class="bg-white border border-gray-200 rounded-lg p-6">
              <div class="flex items-center">
                <div class="p-2 bg-green-100 rounded-lg">
                  <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                  </svg>
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-600">Selesai</p>
                  <p class="text-2xl font-semibold text-gray-900">{{ completedActivities.length }}</p>
                </div>
              </div>
            </div>

            <div class="bg-white border border-gray-200 rounded-lg p-6">
              <div class="flex items-center">
                <div class="p-2 bg-yellow-100 rounded-lg">
                  <svg class="w-6 h-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                  </svg>
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-600">Akan Datang</p>
                  <p class="text-2xl font-semibold text-gray-900">{{ upcomingActivities.length }}</p>
                </div>
              </div>
            </div>

            <div class="bg-white border border-gray-200 rounded-lg p-6">
              <div class="flex items-center">
                <div class="p-2 bg-purple-100 rounded-lg">
                  <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                  </svg>
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-600">Total Aktivitas</p>
                  <p class="text-2xl font-semibold text-gray-900">{{ activities.length }}</p>
                </div>
              </div>
            </div>
          </div>

          <!-- In Progress Activities -->
          <div v-if="inProgressActivities.length > 0" class="bg-white border border-gray-200 rounded-lg">
            <div class="p-6 border-b border-gray-200">
              <h3 class="text-lg font-medium">Pelatihan Sedang Berlangsung</h3>
              <p class="text-sm text-gray-600">Lanjutkan pelatihan yang sedang Anda ikuti</p>
            </div>
            <div class="divide-y divide-gray-200">
              <div v-for="participant in inProgressActivities" :key="participant.activity?.uuid" class="p-6">
                <div class="flex items-start justify-between">
                  <div class="flex-1">
                    <h4 class="text-lg font-medium text-gray-900">{{ participant.activity?.title }}</h4>
                    <p class="text-sm text-gray-600 mt-1" v-if="participant.activity?.description">
                      {{ participant.activity.description.substring(0, 120) }}{{ participant.activity.description.length > 120 ? '...' : '' }}
                    </p>
                    <div class="mt-3 flex items-center space-x-4">
                      <div class="flex items-center text-sm text-gray-500">
                        <svg class="mr-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                        {{ formatDate(participant.activity?.start_date) }} - {{ formatDate(participant.activity?.end_date) }}
                      </div>
                      <Badge :type="getStatusColor(participant.completion_date)">
                        {{ getStatusLabel(participant.completion_date) }}
                      </Badge>
                    </div>
                    <div class="mt-3">
                      <div class="flex items-center justify-between text-sm text-gray-600 mb-1">
                        <span>Progress</span>
                        <span>{{ participant.overall_progress || 0 }}%</span>
                      </div>
                      <div class="w-full bg-gray-200 rounded-full h-2">
                        <div class="bg-blue-600 h-2 rounded-full" 
                             :style="`width: ${participant.overall_progress || 0}%`"></div>
                      </div>
                    </div>
                  </div>
                  <div class="ml-6">
                    <Link v-if="participant.activity?.uuid && ['planned', 'ongoing'].includes(participant.activity?.status?.toLowerCase())" 
                          :href="route('office.myProfile.activity.trainingProgram.learn', { activityUuid: participant.activity.uuid })">
                      <OutlineButton type="primary">
                        <div class="flex items-center space-x-1">
                          <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                          </svg>
                          <span>Lanjutkan Belajar</span>
                        </div>
                      </OutlineButton>
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- All Activities -->
          <div class="bg-white border border-gray-200 rounded-lg">
            <div class="p-6 border-b border-gray-200">
              <h3 class="text-lg font-medium">Semua Aktivitas Pelatihan</h3>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs text-gray-500">
                <thead class="bg-gray-50 text-xs text-gray-700">
                  <tr>
                    <th scope="col" class="p-4">Judul Pelatihan</th>
                    <th scope="col" class="p-4">Program</th>
                    <th scope="col" class="p-4">Periode</th>
                    <th scope="col" class="p-4">Progress</th>
                    <th scope="col" class="p-4">Status</th>
                    <th scope="col" class="p-4">Aksi</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="participant in activities" :key="participant.activity?.uuid" class="border-b hover:bg-gray-50">
                    <td class="px-4 py-3">
                      <div class="font-medium text-gray-900">{{ participant.activity?.title }}</div>
                      <div class="text-xs text-gray-500" v-if="participant.activity?.description">
                        {{ participant.activity.description.substring(0, 60) }}{{ participant.activity.description.length > 60 ? '...' : '' }}
                      </div>
                    </td>
                    <td class="px-4 py-3">
                      <div v-if="participant.activity?.training_program" class="text-gray-900">
                        {{ participant.activity.training_program.name }}
                      </div>
                      <div v-else class="text-gray-500 italic">Manual Activity</div>
                    </td>
                    <td class="whitespace-nowrap px-4 py-3">
                      <div>{{ formatDate(participant.activity?.start_date) }}</div>
                      <div class="text-gray-500">{{ formatDate(participant.activity?.end_date) }}</div>
                    </td>
                    <td class="px-4 py-3">
                      <div class="w-20 bg-gray-200 rounded-full h-2">
                        <div class="bg-blue-600 h-2 rounded-full" 
                             :style="`width: ${participant.overall_progress || 0}%`"></div>
                      </div>
                      <div class="text-xs text-gray-500 mt-1">{{ participant.overall_progress || 0 }}%</div>
                    </td>
                    <td class="px-4 py-3">
                      <div class="space-y-1">
                        <Badge :type="getStatusColor(participant.completion_date)">
                          {{ getStatusLabel(participant.completion_date) }}
                        </Badge>
                        <div class="text-xs text-gray-500">
                          <Badge :type="getActivityStatusColor(participant.activity?.status)" size="sm">
                            {{ getActivityStatusLabel(participant.activity?.status) }}
                          </Badge>
                        </div>
                      </div>
                    </td>
                    <td class="px-4 py-3">
                      <div class="flex space-x-1">
                        <Link v-if="participant.activity?.uuid && ['planned', 'ongoing'].includes(participant.activity?.status?.toLowerCase())" 
                              :href="route('office.myProfile.activity.trainingProgram.learn', { activityUuid: participant.activity.uuid })">
                          <OutlineButton type="primary" size="sm">
                            Mulai Belajar
                          </OutlineButton>
                        </Link>
                        <Link v-else-if="participant.activity?.uuid" 
                              :href="route('office.myProfile.activity.trainingProgram.show', { activityUuid: participant.activity.uuid })">
                          <OutlineButton type="gray" size="sm">Detail</OutlineButton>
                        </Link>
                        <Link v-if="participant.activity?.uuid && participant.completion_date && participant.certificate_issued" 
                              :href="route('office.myProfile.activity.trainingProgram.certificate', { activityUuid: participant.activity.uuid })">
                          <OutlineButton type="green" size="sm">Sertifikat</OutlineButton>
                        </Link>
                      </div>
                    </td>
                  </tr>
                  <tr v-if="activities.length === 0">
                    <td colspan="6" class="px-6 py-4 text-center">
                      <div class="flex flex-col items-center justify-center py-8">
                        <svg class="mb-3 h-10 w-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                        </svg>
                        <h3 class="text-sm font-medium text-gray-500">Belum ada aktivitas pelatihan</h3>
                        <p class="mt-1 text-sm text-gray-500">Anda belum terdaftar dalam aktivitas pelatihan apapun.</p>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 