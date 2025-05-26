<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import AssessmentSessionForm from './AssessmentSession/Form.vue';
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
          <div
            v-for="(assessment_aspect, index) in assessment_record.data.module.aspects.filter((aspect) => {
              return aspect.use_sessions;
            })"
            :key="index"
            class="my-4 w-full rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-sm font-medium leading-none text-gray-900 dark:text-white">
                Sesi Aspek {{ assessment_aspect.name }}
              </h5>
            </div>
            <div class="flow-root">
              <AssessmentSessionForm
                :assessment_record="assessment_record.data"
                :assessment_aspect="assessment_aspect"
                :assessment_sessions="assessment_record.data.sessions"
              />
            </div>
          </div>
          <Link
            :href="
              route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentStudent', {
                assessment_record_id: assessment_record.data.uuid,
                school_classroom_id: school_classroom.data.uuid,
              })
            "
          >
            <DefaultButton type="yellow">
              <div class="flex items-center space-x-1">
                <div>Lakukan Penilaian</div>
              </div>
            </DefaultButton>
          </Link>
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
