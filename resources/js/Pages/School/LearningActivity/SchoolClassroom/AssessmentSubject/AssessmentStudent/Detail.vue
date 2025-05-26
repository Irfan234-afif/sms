<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import AssessmentStudentForm from './Form.vue';
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
          label: 'Penilaian Akademik',
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
    };
  },
  created() {
    // this.assessment_students = this.assessment_record.data.students;
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
                    {{ assessment_record.data.classroom_name ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Mata Pelajaran</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_record.data.subject_name ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Modul</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_record.data.module_name ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
        </div>
        <AssessmentStudentForm :students="assessment_record.data.students" />
      </section>
    </template>
  </SchoolLayout>
</template>
