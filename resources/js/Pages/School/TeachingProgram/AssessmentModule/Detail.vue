<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import AssessmentAspectForm from './AssessmentAspect/Form.vue';
import AssessmentThresholdForm from './AssessmentThreshold/Form.vue';
import AssessmentRubricForm from './AssessmentRubric/Form.vue';
import AssessmentFinalRuleForm from './AssessmentFinalRule/Form.vue';
</script>

<script>
export default {
  props: {
    school_curriculum: Object,
    assessment_module: Object,
  },
  data() {
    return {
      breadcrumbs: [
        { label: 'Sekolah', href: route('school') },
        {
          label: `Modul Penilaian (${this.school_curriculum.data.title})`,
          href: route('school.teachingProgram.assessmentModule'),
        },
        {
          label: this.assessment_module.data.name,
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
            {{ assessment_module.data.name }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Keterangan</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ assessment_module.data.description ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
          <div
            class="my-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Penilaian Aspek</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Penilaian Aspek Baru',
                    mode: 'assessment-aspect-create-form',
                    maxWidth: 'md',
                    data: {
                      assessment_module: assessment_module.data,
                      sort_order: assessment_module.data.aspects.length + 1,
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
                  <div>Penilaian Aspek Baru</div>
                </div>
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li
                  v-for="(assessment_aspect, index) in assessment_module.data.aspects"
                  :key="index"
                  class="py-3 sm:py-4"
                >
                  <div class="flex items-center space-x-2">
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ assessment_aspect.name }}
                      </p>
                      <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                        <div></div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Penilaian Aspek',
                          mode: 'assessment-aspect-edit-form',
                          maxWidth: 'md',
                          data: {
                            assessment_module: assessment_module.data,
                            assessment_aspect: assessment_aspect,
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
                          title: 'Hapus Penilaian Aspek',
                          mode: 'assessment-aspect-delete-confirm',
                          maxWidth: 'md',
                          data: {
                            actionUrl: route('school.teachingProgram.assessmentModule.assessmentAspect.delete', {
                              assessment_aspect_id: assessment_aspect.uuid,
                            }),
                            redirectUrl: route('school.teachingProgram.assessmentModule.detail', {
                              school_curriculum_id: school_curriculum.data.uuid,
                            }),
                            message:
                              'Ingin menghapus Penilaian Aspek? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
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
                </li>
              </ul>
            </div>
          </div>
          <hr />
          <div
            class="my-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Kriteria Ketercapaian</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Kriteria Ketercapaian Baru',
                    mode: 'assessment-threshold-create-form',
                    maxWidth: 'md',
                    data: {
                      assessment_module: assessment_module.data,
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
                  <div>Kriteria Ketercapaian Baru</div>
                </div>
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li
                  v-for="(assessment_threshold, index) in assessment_module.data.thresholds"
                  :key="index"
                  class="py-3 sm:py-4"
                >
                  <div class="flex items-center space-x-2">
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ assessment_threshold.name }}
                      </p>
                      <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                        <div></div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Kriteria Ketercapaian',
                          mode: 'assessment-threshold-edit-form',
                          maxWidth: 'md',
                          data: {
                            assessment_module: assessment_module.data,
                            assessment_threshold: assessment_threshold,
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
                          title: 'Hapus Kriteria Ketercapaian',
                          mode: 'assessment-threshold-delete-confirm',
                          maxWidth: 'md',
                          data: {
                            actionUrl: route('school.teachingProgram.assessmentModule.assessmentThreshold.delete', {
                              assessment_threshold_id: assessment_threshold.uuid,
                            }),
                            redirectUrl: route('school.teachingProgram.assessmentModule.detail', {
                              school_curriculum_id: school_curriculum.data.uuid,
                            }),
                            message:
                              'Ingin menghapus Kriteria Ketercapaian? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
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
                </li>
              </ul>
            </div>
          </div>
          <hr />
          <div
            class="my-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Rubrik</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Rubrik Baru',
                    mode: 'assessment-rubric-create-form',
                    maxWidth: 'md',
                    data: {
                      assessment_module: assessment_module.data,
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
                  <div>Rubrik Baru</div>
                </div>
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li
                  v-for="(assessment_rubric, index) in assessment_module.data.rubrics"
                  :key="index"
                  class="py-3 sm:py-4"
                >
                  <div class="flex items-center space-x-2">
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ assessment_rubric.name }}
                      </p>
                      <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                        <div></div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Rubrik',
                          mode: 'assessment-rubric-edit-form',
                          maxWidth: 'md',
                          data: {
                            assessment_module: assessment_module.data,
                            assessment_rubric: assessment_rubric,
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
                          title: 'Hapus Rubrik',
                          mode: 'assessment-rubric-delete-confirm',
                          maxWidth: 'md',
                          data: {
                            actionUrl: route('school.teachingProgram.assessmentModule.assessmentRubric.delete', {
                              assessment_rubric_id: assessment_rubric.uuid,
                            }),
                            redirectUrl: route('school.teachingProgram.assessmentModule.detail', {
                              school_curriculum_id: school_curriculum.data.uuid,
                            }),
                            message:
                              'Ingin menghapus Rubrik? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
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
                </li>
              </ul>
            </div>
          </div>
          <div v-if="assessment_module.data.aspects.length > 0">
            <hr />
            <div
              class="my-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
            >
              <div class="flex items-center justify-between border-b pb-4">
                <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Penilaian Akhir</h5>
                <DefaultButton
                  type="default"
                  @click="
                    openModal({
                      title: 'Penilaian Akhir Baru',
                      mode: 'assessment-final-rule-create-form',
                      maxWidth: 'md',
                      data: {
                        assessment_module: assessment_module.data,
                        assessment_aspects: assessment_module.data.aspects,
                        assessment_aspects_using_lo: assessment_module.data.aspects.filter(
                          (aspect) => aspect.use_learning_objective,
                        ),
                        sort_order: assessment_module.data.final_rules.length + 1,
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
                    <div>Penilaian Akhir Baru</div>
                  </div>
                </DefaultButton>
              </div>
              <div class="flow-root">
                <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                  <li
                    v-for="(assessment_final_rule, index) in assessment_module.data.final_rules"
                    :key="index"
                    class="py-3 sm:py-4"
                  >
                    <div class="flex items-center space-x-2">
                      <div class="ms-4 min-w-0 flex-1">
                        <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                          {{ assessment_final_rule.name }}
                        </p>
                        <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                          <div></div>
                        </div>
                      </div>
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: 'Sunting Penilaian Akhir',
                            mode: 'assessment-final-rule-edit-form',
                            maxWidth: 'md',
                            data: {
                              assessment_module: assessment_module.data,
                              assessment_final_rule: assessment_final_rule,
                              assessment_aspects: assessment_module.data.aspects,
                              assessment_aspects_using_lo: assessment_module.data.aspects.filter(
                                (aspect) => aspect.use_learning_objective,
                              ),
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
                            title: 'Hapus Penilaian Akhir',
                            mode: 'assessment-final-rule-delete-confirm',
                            maxWidth: 'md',
                            data: {
                              actionUrl: route('school.teachingProgram.assessmentModule.assessmentFinalRule.delete', {
                                assessment_final_rule_id: assessment_final_rule.uuid,
                              }),
                              redirectUrl: route('school.teachingProgram.assessmentModule.detail', {
                                school_curriculum_id: school_curriculum.data.uuid,
                              }),
                              message:
                                'Ingin menghapus Penilaian Akhir? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
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
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <AssessmentAspectForm
            v-if="
              propertyModal?.mode == 'assessment-aspect-create-form' ||
              propertyModal?.mode == 'assessment-aspect-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <AssessmentThresholdForm
            v-if="
              propertyModal?.mode == 'assessment-threshold-create-form' ||
              propertyModal?.mode == 'assessment-threshold-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <AssessmentRubricForm
            v-if="
              propertyModal?.mode == 'assessment-rubric-create-form' ||
              propertyModal?.mode == 'assessment-rubric-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <AssessmentFinalRuleForm
            v-if="
              propertyModal?.mode == 'assessment-final-rule-create-form' ||
              propertyModal?.mode == 'assessment-final-rule-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DialogConfirm
            v-if="
              propertyModal?.mode == 'assessment-aspect-delete-confirm' ||
              propertyModal?.mode == 'assessment-rubric-delete-confirm' ||
              propertyModal?.mode == 'assessment-final-rule-delete-confirm'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
