<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kegiatan Kelas', href: route('school.learningActivity.schoolClassroom') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    school_classrooms: Object,
  },
  data() {},
  methods: {},
};
</script>

<template>
  <Head title="Sekolah" />

  <SchoolLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
      >
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" />
        </div>
        <div
          class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0"
        ></div>
      </div>
    </template>
    <template #sidebar>
      <SchoolSidebar />
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
                  <th scope="col" class="p-4">Kelas</th>
                  <th scope="col" class="p-4">Tingkat Kelas</th>
                  <th v-if="$page.props.auth.active_school.use_major" scope="col" class="p-4">Jurusan</th>
                  <th scope="col" class="p-4">Wali Kelas</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(school_classroom, index) in school_classrooms.data"
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
                      {{ school_classroom.title }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ school_classroom.grade.title }}
                    </div>
                  </th>
                  <th
                    v-if="$page.props.auth.active_school.use_major"
                    scope="row"
                    class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                  >
                    <div class="flex items-center">
                      {{ school_classroom.major?.title ?? '-' }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ school_classroom.homeroom_teacher?.profile?.name ?? '-' }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <Link
                        :href="
                          route('school.learningActivity.schoolClassroom.detail', {
                            school_classroom_id: school_classroom.uuid,
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
          <Pagination :search_params="search_params" :meta="school_classrooms.meta" :links="school_classrooms.links" />
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
