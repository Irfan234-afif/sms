<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import HCMSidebar from '@/Layouts/Sidebars/HCMSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'HCM', href: route('office.hcm') },
  { label: 'Penempatan', href: route('office.hcm.placement') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    areas: Object,
  },
};
</script>

<template>
  <Head title="Yayasan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
      >
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" />
        </div>
      </div>
    </template>
    <template #sidebar>
      <HCMSidebar />
    </template>
    <template #content>
      <section>
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800">
          <!-- table list -->
          <div class="overflow-x-auto">
            <table class="w-full text-left text-xs text-gray-500 dark:text-gray-400">
              <thead class="bg-gray-50 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                  <th scope="col" class="p-4" v-if="false">
                    <div class="flex items-center">
                      <input
                        id="checkbox-all"
                        type="checkbox"
                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                      />
                      <label for="checkbox-all" class="sr-only">checkbox</label>
                    </div>
                  </th>
                  <th scope="col" class="p-4">Area</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(area, index) in areas.data"
                  :key="index"
                  class="border-b hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-700"
                >
                  <td class="w-4 p-4" v-if="false">
                    <div class="flex items-center">
                      <input
                        id="checkbox-table-search"
                        type="checkbox"
                        onclick="event.stopPropagation()"
                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                      />
                      <label for="checkbox-table-search" class="sr-only">checkbox</label>
                    </div>
                  </td>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ area.name }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <Link
                        :href="
                          route('office.hcm.placement.area', {
                            area_id: area.uuid,
                          })
                        "
                      >
                        <OutlineButton type="yellow">
                          <div class="flex items-center space-x-1">
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="1.5"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="h-4"
                            >
                              <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                              <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
                              <path d="M21 21l-6 -6" />
                            </svg>
                            <div>Lihat</div>
                          </div>
                        </OutlineButton>
                      </Link>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- pagination -->
          <Pagination :search_params="search_params" :meta="areas.meta" :links="areas.links" />
        </div>
      </section>
    </template>
  </OfficeLayout>
</template>
