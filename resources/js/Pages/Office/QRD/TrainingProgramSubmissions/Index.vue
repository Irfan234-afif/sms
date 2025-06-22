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
  submissions: {
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
  { label: 'Pengajuan Training Program', href: route('office.qrd.manage.training-program-submission.index') }
];

const deleteSubmission = (submission) => {
  if (confirm('Apakah Anda yakin ingin menghapus pengajuan ini?')) {
    router.delete(route('office.qrd.manage.training-program-submission.destroy', submission.uuid), {
      preserveScroll: true,
      onSuccess: () => {
        // Success handled by Inertia response
      }
    });
  }
};

const submitSubmission = (submission) => {
  if (confirm('Apakah Anda yakin ingin mengirim pengajuan ini untuk persetujuan?')) {
    router.post(route('office.qrd.manage.training-program-submission.updateStatus', submission.uuid), {
      status: 'PENDING'
    }, {
      preserveScroll: true,
      onSuccess: () => {
        // Success handled by Inertia response
      }
    });
  }
};

const cancelSubmission = (submission) => {
  if (confirm('Apakah Anda yakin ingin membatalkan pengajuan ini?')) {
    router.post(route('office.qrd.manage.training-program-submission.updateStatus', submission.uuid), {
      status: 'CANCELLED'
    }, {
      preserveScroll: true,
      onSuccess: () => {
        // Success handled by Inertia response
      }
    });
  }
};

const getTrainingTypeLabel = (type) => {
  return type === 'internal' ? 'Internal' : 'Eksternal';
};

const formatCurrency = (amount) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    minimumFractionDigits: 0
  }).format(amount || 0);
};
</script>

<template>
  <Head title="Pengajuan Training Program" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0">
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" placeholder="Cari pengajuan..." />
        </div>
        <div
          class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0">
          <Link :href="route('office.qrd.manage.training-program-submission.create')"
            class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-xs px-2.5 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
            <svg class="mr-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                clip-rule="evenodd"></path>
            </svg>
            Buat Pengajuan Baru
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
                  <th scope="col" class="p-4">No. Referensi</th>
                  <th scope="col" class="p-4">Judul Training</th>
                  <th scope="col" class="p-4">Tipe</th>
                  <th scope="col" class="p-4">Pengaju</th>
                  <th scope="col" class="p-4">Peserta</th>
                  <th scope="col" class="p-4">Total Budget</th>
                  <th scope="col" class="p-4">Status</th>
                  <th scope="col" class="p-4">Tanggal</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="submission in submissions.data" :key="submission.uuid" class="border-b hover:bg-gray-50">
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900">
                    {{ submission.reference_number || '-' }}
                  </th>
                  <td class="px-4 py-3">
                    <div class="font-medium text-gray-900">{{ submission.title }}</div>
                    <div class="text-gray-500" v-if="submission.provider">{{ submission.provider }}</div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <Badge :type="submission.training_type === 'internal' ? 'blue' : 'purple'">
                      {{ getTrainingTypeLabel(submission.training_type) }}
                    </Badge>
                  </td>
                  <td class="px-4 py-3">
                    <div class="font-medium text-gray-900">{{ submission.submitter.name }}</div>
                    <div class="text-gray-500">{{ submission.submitter.area }}</div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div class="font-medium">{{ submission.participants_count }} orang</div>
                    <div class="text-gray-500" v-if="submission.primary_participant">
                      {{ submission.primary_participant.name }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium">
                    {{ formatCurrency(submission.total_budget) }}
                  </td>
                  <td class="px-4 py-3">
                    <Badge v-if="submission.submission.status == 'DRAFT'" type="dark">Draf</Badge>
                    <Badge v-else-if="submission.submission.status == 'PENDING'" type="yellow">Menunggu</Badge>
                    <Badge v-else-if="submission.submission.status == 'REJECTED'" type="red">Ditolak</Badge>
                    <Badge v-else-if="submission.submission.status == 'APPROVED'" type="green">Disetujui</Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div>{{ submission.start_date }} - {{ submission.end_date }}</div>
                    <div class="text-gray-500">{{ submission.start_time }} - {{ submission.end_time }}</div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900">
                    <div class="flex items-center justify-end space-x-2">
                      <!-- View Button -->
                      <Link :href="route('office.qrd.manage.training-program-submission.show', submission.uuid)"
                        class="text-primary-600 hover:text-primary-900">
                        <OutlineButton type="primary" size="sm">
                          <div class="flex items-center space-x-1">
                            <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                              <path fill-rule="evenodd"
                                d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                                clip-rule="evenodd"></path>
                            </svg>
                            <span>Detail</span>
                          </div>
                        </OutlineButton>
                      </Link>

                      <!-- Edit Button (only for draft) -->
                      <Link v-if="submission.can_edit" 
                        :href="route('office.qrd.manage.training-program-submission.edit', submission.uuid)"
                        class="text-yellow-600 hover:text-yellow-900">
                        <OutlineButton type="yellow" size="sm">
                          <div class="flex items-center space-x-1">
                            <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path
                                d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z">
                              </path>
                            </svg>
                            <span>Edit</span>
                          </div>
                        </OutlineButton>
                      </Link>

                      <!-- Submit Button (only for draft) -->
                      <OutlineButton v-if="submission.can_submit" 
                        @click="submitSubmission(submission)" 
                        type="green" size="sm">
                        <div class="flex items-center space-x-1">
                          <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          <span>Submit</span>
                        </div>
                      </OutlineButton>

                      <!-- Cancel Button -->
                      <OutlineButton v-if="submission.can_cancel" 
                        @click="cancelSubmission(submission)" 
                        type="orange" size="sm">
                        <div class="flex items-center space-x-1">
                          <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"></path>
                          </svg>
                          <span>Batal</span>
                        </div>
                      </OutlineButton>

                      <!-- Delete Button (only for draft/cancelled) -->
                      <OutlineButton v-if="submission.can_delete" 
                        @click="deleteSubmission(submission)" 
                        type="red" size="sm">
                        <div class="flex items-center space-x-1">
                          <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                              clip-rule="evenodd"></path>
                          </svg>
                          <span>Hapus</span>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
                <tr v-if="submissions.data.length === 0">
                  <td colspan="9" class="px-6 py-4 text-center">
                    <div class="flex flex-col items-center justify-center py-8">
                      <svg class="mb-3 h-10 w-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                      </svg>
                      <h3 class="text-sm font-medium text-gray-500">Belum ada pengajuan training program</h3>
                      <p class="mt-1 text-sm text-gray-500">Mulai dengan membuat pengajuan baru</p>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <Pagination :search_params="search_params" :meta="submissions.meta" :links="submissions.links" class="mb-4" />
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 