<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Search from '@/Components/Search.vue';
import { ref } from 'vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import Pagination from '@/Components/Pagination.vue';

const props = defineProps({
  activities: {
    type: Object,
    required: true
  },
  search_params: {
    type: Object,
    default: () => ({})
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Pelatihan', href: route('office.qrd.activity.training-program-activity.index') }
];

const deleteActivity = (activity) => {
  if (!activity.uuid) {
    alert('Error: Activity UUID tidak ditemukan');
    return;
  }
  
  if (confirm('Apakah Anda yakin ingin menghapus aktivitas ini?')) {
    router.delete(route('office.qrd.activity.training-program-activity.destroy', activity.uuid), {
      preserveScroll: true,
      onSuccess: () => {
        // Success handled by Inertia response
      }
    });
  }
};

const getStatusColor = (status) => {
  const colors = {
    'planned': 'blue',
    'ongoing': 'yellow', 
    'completed': 'green',
    'cancelled': 'red'
  };
  return colors[status] || 'gray';
};

const getStatusLabel = (status) => {
  const labels = {
    'planned': 'Direncanakan',
    'ongoing': 'Berlangsung',
    'completed': 'Selesai',
    'cancelled': 'Dibatalkan'
  };
  return labels[status] || status;
};

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
};
</script>

<template>
  <Head title="Aktivitas Pelatihan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0">
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" placeholder="Cari aktivitas pelatihan..." />
        </div>
        <div
          class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0">
          <Link :href="route('office.qrd.activity.training-program-activity.create')"
            class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-xs px-2.5 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
            <svg class="mr-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                clip-rule="evenodd"></path>
            </svg>
            Buat Aktivitas Baru
          </Link>
        </div>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <div class="bg-white">
        <div class="relative overflow-hidden bg-white shadow-md">
          <div class="overflow-x-auto">
            <table class="w-full text-left text-xs text-gray-500">
              <thead class="bg-gray-50 text-xs text-gray-700">
                <tr>
                  <th scope="col" class="p-4">Judul Aktivitas</th>
                  <th scope="col" class="p-4">Program Pelatihan</th>
                  <th scope="col" class="p-4">Peserta</th>
                  <th scope="col" class="p-4">Periode</th>
                  <th scope="col" class="p-4">Progress</th>
                  <th scope="col" class="p-4">Status</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="activity in activities.data" :key="activity.uuid" class="border-b hover:bg-gray-50">
                  <th scope="row" class="px-4 py-3">
                    <div class="font-medium text-gray-900">{{ activity.title }}</div>
                    <div class="text-gray-500 text-xs" v-if="activity.description">
                      {{ activity.description.substring(0, 80) }}{{ activity.description.length > 80 ? '...' : '' }}
                    </div>
                  </th>
                  <td class="px-4 py-3">
                    <div v-if="activity.training_program" class="font-medium text-gray-900">
                      {{ activity.training_program.name }}
                    </div>
                    <div v-else class="text-gray-500 italic">Manual Activity</div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div class="font-medium">{{ activity.participants_count || 0 }} orang</div>
                    <div class="text-gray-500">
                      {{ activity.completed_participants_count || 0 }} selesai
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div>{{ formatDate(activity.start_date) }}</div>
                    <div class="text-gray-500">{{ formatDate(activity.end_date) }}</div>
                  </td>
                  <td class="px-4 py-3">
                    <div class="w-full bg-gray-200 rounded-full h-2">
                      <div class="bg-blue-600 h-2 rounded-full" 
                           :style="`width: ${activity.overall_progress || 0}%`"></div>
                    </div>
                    <div class="text-xs text-gray-500 mt-1">{{ activity.overall_progress || 0 }}%</div>
                  </td>
                  <td class="px-4 py-3">
                    <Badge :type="getStatusColor(activity.status)">
                      {{ getStatusLabel(activity.status) }}
                    </Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900">
                    <div class="flex items-center justify-end space-x-3">
                      <!-- View Button -->
                      <Link :href="route('office.qrd.activity.training-program-activity.show', activity.uuid)">
                        <OutlineButton type="primary">
                          <div class="flex items-center space-x-1">
                            <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                              <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span>Lihat</span>
                          </div>
                        </OutlineButton>
                      </Link>

                      <!-- Edit Button (only for planned status) -->
                      <Link v-if="activity.status === 'planned' && activity.uuid" :href="route('office.qrd.activity.training-program-activity.edit', activity.uuid)">
                        <OutlineButton type="yellow">
                          <div class="flex items-center space-x-1">
                            <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"></path>
                            </svg>
                            <span>Edit</span>
                          </div>
                        </OutlineButton>
                      </Link>

                      <!-- Delete Button (only for planned status) -->
                      <OutlineButton v-if="activity.status === 'planned' && activity.uuid" @click="deleteActivity(activity)" type="red">
                        <div class="flex items-center space-x-1">
                          <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                          </svg>
                          <span>Hapus</span>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
                <tr v-if="activities.data.length === 0">
                  <td colspan="7" class="px-6 py-4 text-center">
                    <div class="flex flex-col items-center justify-center py-8">
                      <svg class="mb-3 h-10 w-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                      </svg>
                      <h3 class="text-sm font-medium text-gray-500">Tidak ada aktivitas pelatihan</h3>
                      <p class="mt-1 text-sm text-gray-500">Mulai dengan membuat aktivitas pelatihan baru</p>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <Pagination :search_params="search_params" :meta="activities.meta" :links="activities.links" class="mb-4" />
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 