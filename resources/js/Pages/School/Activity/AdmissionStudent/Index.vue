<script setup>
import Pagination from '@/Components/Pagination.vue';
import Badge from '@/Components/Badge.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Pendaftaran Siswa Baru', href: route('school.activity.admissionStudent') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    product: Object,
    admission_students: Object,
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
      </div>
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <!-- Data -->
      <section>
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800">
          <!-- Table List -->
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
                  <th scope="col" class="p-4">Siswa</th>
                  <th scope="col" class="p-4">Nomor Pendaftaran</th>
                  <th scope="col" class="p-4">Terdaftar di Sekolah</th>
                  <th scope="col" class="p-4">Tanggal Terdaftar</th>
                  <th scope="col" class="p-4">Status</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(admission_student, index) in admission_students.data"
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
                      {{ admission_student.name }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div
                      class="bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-300 rounded py-0.5 font-medium"
                    >
                      {{ admission_student.registration_number }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ admission_student.school.area.name }}
                      > Tahun Ajaran
                      {{ admission_student.school_year.name }}
                      > Kelas
                      {{ admission_student.school_grade.title }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div v-if="admission_student.submitted_at">
                      {{ admission_student.submitted_at_label }}
                    </div>
                    <div v-else>
                      <Badge type="dark">Belum Terdaftar</Badge>
                    </div>
                  </td>
                  <td class="px-4 py-3">
                    <Badge v-if="admission_student.status == 'NEW'" type="default">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'DRAFT'" type="dark">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'PENDING'" type="yellow">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'VERIFIED'" type="purple">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'UNVERIFIED'" type="red">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'ACCEPTED'" type="green">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'REJECTED'" type="red">{{
                      admission_student.status_label
                    }}</Badge>
                    <Badge v-if="admission_student.status == 'ENROLLED'" type="dark">{{
                      admission_student.status_label
                    }}</Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <Link
                        :href="
                          route('school.activity.admissionStudent.detail', {
                            registration_number: admission_student.registration_number,
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
          <!-- Pagination -->
          <Pagination
            :search_params="search_params"
            :meta="admission_students.meta"
            :links="admission_students.links"
          />
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
