<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import StudentImportForm from './Import/Form.vue';
import { Head, Link } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import StudentForm from './Form.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Siswa', href: route('school.student') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    students: Object,
  },
  data() {
    return {
      showModal: false,
      closeable: true,
      propertyModal: {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      },
    };
  },
  methods: {
    openModal(property) {
      this.showModal = true;
      this.propertyModal = property;
    },
    closeModal() {
      this.showModal = false;
      this.propertyModal = {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      };
    },
  },
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
        >
          <DefaultButton
            type="purple"
            @click="
              closeable = false;
              openModal({
                title: 'Import CSV Siswa',
                mode: 'student-import-form',
                maxWidth: '7xl',
                data: {},
              });
            "
          >
            <div class="flex items-center space-x-1 text-xs">
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
                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
                <path d="M15 15h-6" />
                <path d="M11.5 17.5l-2.5 -2.5l2.5 -2.5" />
              </svg>
              <div>Import CSV Siswa</div>
            </div>
          </DefaultButton>
          <DefaultButton
            type="default"
            @click="
              closeable = true;
              openModal({
                title: 'Siswa Baru',
                mode: 'student-create-form',
                maxWidth: '4xl',
                data: {},
              });
            "
          >
            <div class="flex items-center space-x-1 text-xs">
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
                <path d="M12 5l0 14" />
                <path d="M5 12l14 0" />
              </svg>
              <div>Siswa Baru</div>
            </div>
          </DefaultButton>
        </div>
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
                  <th scope="col" class="p-4">Siswa</th>
                  <th scope="col" class="p-4">Nomor Induk</th>
                  <th scope="col" class="p-4">Tingkat Kelas</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(student, index) in students.data"
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
                      {{ student.profile.name }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div
                      class="bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-300 rounded py-0.5 font-medium"
                    >
                      {{ student.school_national_id }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      Kelas
                      {{ student.school_grade.title }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <OutlineButton
                        type="default"
                        @click="
                          closeable = true;
                          openModal({
                            title: 'Sunting Siswa',
                            mode: 'student-edit-form',
                            maxWidth: '4xl',
                            data: {
                              student: student,
                            },
                          });
                        "
                      >
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
                            <path d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1" />
                            <path d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z" />
                            <path d="M16 5l3 3" />
                          </svg>
                          <div>Sunting</div>
                        </div>
                      </OutlineButton>
                      <Link
                        :href="
                          route('school.student.detail', {
                            student_id: student.uuid,
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
          <Pagination :search_params="search_params" :meta="students.meta" :links="students.links" />
        </div>
      </section>
      <!-- modal -->
      <Modal
        :show="showModal"
        :property="propertyModal"
        :maxWidth="propertyModal?.maxWidth"
        @close="closeModal"
        :closeable="closeable"
      >
        <template v-slot="{ propertyModal }">
          <StudentForm
            v-if="propertyModal?.mode == 'student-create-form' || propertyModal?.mode == 'student-edit-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <StudentImportForm
            v-if="propertyModal?.mode == 'student-import-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
