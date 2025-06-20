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
  programs: {
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
  { label: 'Program Pelatihan', href: route('office.qrd.manage.training-program.index') }
];

const deleteProgram = (program) => {
  if (confirm('Are you sure you want to delete this program?')) {
    router.delete(route('office.qrd.manage.training-program.destroy', program.uuid), {
      preserveScroll: true,
      onSuccess: () => {
        // Success handled by Inertia response
      }
    });
  }
};
</script>

<template>

  <Head title="Program Pelatihan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0">
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" />
        </div>
        <div
          class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0">
          <Link :href="route('office.qrd.manage.training-program.create')"
            class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-xs px-2.5 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
            <svg class="mr-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                clip-rule="evenodd"></path>
            </svg>
            Create New
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
                  <th scope="col" class="p-4">Name</th>
                  <th scope="col" class="p-4">Type</th>
                  <th scope="col" class="p-4">Level</th>
                  <th scope="col" class="p-4">Status</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="program in programs.data" :key="program.uuid" class="border-b hover:bg-gray-50">
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900">
                    {{ program.name }}
                  </th>
                  <td class="whitespace-nowrap px-4 py-3">
                    {{ program.type }}
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    {{ program.level }}
                  </td>
                  <td class="px-4 py-3">
                    <Badge v-if="program.status === 'active'" type="green">Active</Badge>
                    <Badge v-else type="red">Inactive</Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900">
                    <div class="flex items-center justify-end space-x-3">
                      <Link :href="route('office.qrd.manage.training-program.show', program.uuid)"
                        class="text-primary-600 hover:text-primary-900">
                      <OutlineButton type="primary">
                        <div class="flex items-center space-x-1">
                          <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                            <path fill-rule="evenodd"
                              d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          <div>View</div>
                        </div>
                      </OutlineButton>
                      </Link>
                      <Link :href="route('office.qrd.manage.training-program.edit', program.uuid)"
                        class="text-yellow-600 hover:text-yellow-900">
                      <OutlineButton type="yellow">
                        <div class="flex items-center space-x-1">
                          <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path
                              d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z">
                            </path>
                          </svg>
                          <div>Edit</div>
                        </div>
                      </OutlineButton>
                      </Link>
                      <OutlineButton @click="deleteProgram(program)" type="red">
                        <div class="flex items-center space-x-1">
                          <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                              clip-rule="evenodd"></path>
                          </svg>
                          <div>Delete</div>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
                <tr v-if="programs.data.length === 0">
                  <td colspan="5" class="px-6 py-4 text-center">
                    <div class="flex flex-col items-center justify-center py-8">
                      <svg class="mb-3 h-10 w-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                      </svg>
                      <h3 class="text-sm font-medium text-gray-500">No training programs found</h3>
                      <p class="mt-1 text-sm text-gray-500">Get started by creating a new program</p>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <Pagination :search_params="search_params" :meta="programs.meta" :links="programs.links" class="mb-4" />
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template>
