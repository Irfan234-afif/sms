<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import SchoolSubjectForm from './Form.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import DeleteConfirm from '@/Components/DeleteConfirm.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kelas', href: route('school.management.schoolClassroom') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    school_classrooms: Object,
  },
  data() {
    return {
      showModal: false,
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
            type="default"
            @click="
              openModal({
                title: 'Kelas Baru',
                mode: 'school-classroom-create-form',
                maxWidth: 'md',
                data: {
                  school: $page.props.auth.active_school,
                },
              })
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
              <div>Kelas Baru</div>
            </div>
          </DefaultButton>
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
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: 'Sunting Kelas',
                            mode: 'school-classroom-edit-form',
                            maxWidth: 'md',
                            data: {
                              school: $page.props.auth.active_school,
                              school_classroom: school_classroom,
                            },
                          })
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
                      <OutlineButton
                        type="red"
                        @click="
                          openModal({
                            title: 'Hapus Kelas',
                            mode: 'school-classroom-delete-confirm',
                            maxWidth: 'md',
                            data: {
                              actionUrl: route('school.management.schoolClassroom.delete', {
                                school_classroom_id: school_classroom.uuid,
                              }),
                              redirectUrl: route('school.management.schoolClassroom'),
                              message: 'Ingin menghapus Kelas?',
                            },
                          })
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
                            <path d="M4 7l16 0" />
                            <path d="M10 11l0 6" />
                            <path d="M14 11l0 6" />
                            <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" />
                            <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" />
                          </svg>
                          <div>Hapus</div>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- Pagination -->
          <Pagination :search_params="search_params" :meta="school_classrooms.meta" :links="school_classrooms.links" />
        </div>
      </section>
      <!-- Modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <SchoolSubjectForm
            v-if="
              propertyModal?.mode == 'school-classroom-edit-form' ||
              propertyModal?.mode == 'school-classroom-create-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DeleteConfirm
            v-if="propertyModal?.mode == 'school-classroom-delete-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
