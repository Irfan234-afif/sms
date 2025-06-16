<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kelas', href: route('school.learningActivity.schoolClassroom') },
  { label: 'Lihat', href: '#' },
];
</script>

<script>
export default {
  props: {
    school_classroom: Object,
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
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-2">
            {{ school_classroom.data.title }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Tingkat Kelas</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.grade.title }}
                  </dd>
                </dl>
                <dl v-if="school_classroom.data.major">
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Jurusan</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.major?.title ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Wali Kelas</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.homeroom_teacher?.profile?.name ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
          <div class="mt-3 grid max-w-sm grid-cols-1 gap-2">
            <Link
              :href="
                route('school.learningActivity.schoolClassroom.assessmentSubject', {
                  school_classroom_id: school_classroom.data.uuid,
                })
              "
              class="group flex items-center space-x-2 rounded-xl bg-blue-800 px-4 py-3 text-xs font-medium text-white shadow hover:bg-blue-900 dark:bg-blue-800 dark:text-white"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-5 w-5 flex-shrink-0"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M19 4v16h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12z" />
                <path d="M19 16h-12a2 2 0 0 0 -2 2" />
                <path d="M9 8h6" />
              </svg>
              <span class="flex-1 whitespace-nowrap">Penilaian Mata Pelajaran</span>
            </Link>
            <Link
              href=""
              class="group flex items-center space-x-2 rounded-xl bg-blue-800 px-4 py-3 text-xs font-medium text-white shadow hover:bg-blue-900 dark:bg-blue-800 dark:text-white"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-5 w-5 flex-shrink-0"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M19 4v16h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12z" />
                <path d="M19 16h-12a2 2 0 0 0 -2 2" />
                <path d="M9 8h6" />
              </svg>
              <span class="flex-1 whitespace-nowrap">Rapor</span>
            </Link>
          </div>
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
