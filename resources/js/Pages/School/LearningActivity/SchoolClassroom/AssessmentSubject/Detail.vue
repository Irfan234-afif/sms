<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
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
          label: `Kelas (${this.school_classroom.data.title})`,
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

          <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
            <ul
              class="-mb-px flex flex-wrap text-center text-sm font-medium"
              id="default-tab"
              data-tabs-toggle="#default-tab-content"
              role="tablist"
            >
              <li
                v-for="(assessment_aspect, index) in assessment_record.data.module.aspects.filter(
                  (aspect) => aspect.use_sessions,
                )"
                :key="index"
                class="me-2"
                role="presentation"
              >
                <button
                  class="inline-block rounded-t-lg border-b-2 p-4"
                  :id="`tab-${index}`"
                  :data-tabs-target="`#tab-panel-${index}`"
                  type="button"
                  role="tab"
                  :aria-controls="`tab-panel-${index}`"
                  aria-selected="false"
                >
                  {{ assessment_aspect.name }}
                </button>
              </li>
            </ul>
          </div>

          <div id="default-tab-content" class="w-full">
            <div
              v-for="(assessment_aspect, index) in assessment_record.data.module.aspects.filter(
                (aspect) => aspect.use_sessions,
              )"
              :key="index"
              class="hidden rounded-lg"
              :id="`tab-panel-${index}`"
              role="tabpanel"
              :aria-labelledby="`tab-${index}`"
            >
              <div class="w-full">
                <AssessmentSessionForm
                  :assessment_record="assessment_record.data"
                  :assessment_aspect="assessment_aspect"
                  :assessment_sessions="assessment_record.data.sessions"
                />
              </div>
            </div>
          </div>

          <a
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
          </a>
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
