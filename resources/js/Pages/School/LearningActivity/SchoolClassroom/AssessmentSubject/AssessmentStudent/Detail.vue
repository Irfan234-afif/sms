<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
</script>

<script>
export default {
  props: {
    school_classroom: Object,
    assessment_record: Object,
  },
  data() {
    return {
      breadcrumbs: [
        { label: 'Sekolah', href: route('school') },
        {
          label: `Kegiatan Kelas (${this.school_classroom.data.title})`,
          href: route('school.learningActivity.schoolClassroom'),
        },
        {
          label: 'Penilaian Mata Pelajaran',
          href: route('school.learningActivity.schoolClassroom.assessmentSubject', {
            school_classroom_id: this.school_classroom.data.uuid,
          }),
        },
        {
          label: this.assessment_record.data.name,
          href: '#',
        },
      ],
      showModal: false,
      propertyModal: {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      },
      assessment_students: [],
    };
  },
  created() {
    this.assessment_students = this.assessment_record.data.students;
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
            {{ assessment_record.data.name }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Kelas</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_record.data.classroom.title ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Mata Pelajaran</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_record.data.subject.title ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Modul</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_record.data.module.name ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
        </div>
        <div>
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
                  <th
                    scope="col"
                    class="p-4"
                    v-for="(session, index) in assessment_students[0].sessions.sort((a, b) => {
                      return a.session.aspect.sort_order - b.session.aspect.sort_order;
                    })"
                    :key="index"
                  >
                    {{ session.session.name }}
                  </th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(assessment_student, index) in assessment_students"
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
                      {{ assessment_student.student.profile.name }}
                    </div>
                  </th>
                  <td
                    class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                    v-for="(session, index) in assessment_student.sessions.sort((a, b) => {
                      return a.session.aspect.sort_order - b.session.aspect.sort_order;
                    })"
                    :key="index"
                  >
                    <el-input v-model="session.final_score"></el-input>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
