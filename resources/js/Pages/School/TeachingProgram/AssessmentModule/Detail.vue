<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import AssessmentAspectForm from './AssessmentAspect/Form.vue';
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
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Aspek Penilaian</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Aspek Penilaian Baru',
                    mode: 'assessment-aspect-create-form',
                    maxWidth: 'md',
                    data: {
                      assessment_module: assessment_module.data,
                      sort_number: assessment_module.data.aspects.length + 1,
                    },
                  })
                "
              >
                Aspek Penilaian Baru
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
                        <div>
                          {{ assessment_aspect.code }}
                        </div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Aspek Penilaian',
                          mode: 'assessment-aspect-edit-form',
                          maxWidth: 'md',
                          data: {
                            assessment_module: assessment_module.data,
                            assessment_aspect: assessment_aspect,
                          },
                        })
                      "
                    >
                      Sunting
                    </OutlineButton>
                    <OutlineButton
                      type="red"
                      @click="
                        openModal({
                          title: 'Hapus Aspek Penilaian',
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
                              'Ingin menghapus Aspek Penilaian? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
                          },
                        })
                      "
                    >
                      Hapus
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
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Rubrik Nilai</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Rubrik Nilai Baru',
                    mode: 'assessment-rubric-create-form',
                    maxWidth: 'md',
                    data: {
                      assessment_module: assessment_module.data,
                    },
                  })
                "
              >
                Rubrik Nilai Baru
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
                        <div>
                          {{ assessment_rubric.code }}
                        </div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Rubrik Nilai',
                          mode: 'assessment-rubric-edit-form',
                          maxWidth: 'md',
                          data: {
                            assessment_module: assessment_module.data,
                            assessment_rubric: assessment_rubric,
                          },
                        })
                      "
                    >
                      Sunting
                    </OutlineButton>
                    <OutlineButton
                      type="red"
                      @click="
                        openModal({
                          title: 'Hapus Rubrik Nilai',
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
                              'Ingin menghapus Rubrik Nilai? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
                          },
                        })
                      "
                    >
                      Hapus
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
                      mode: 'assessment-aspect-create-form',
                      maxWidth: 'md',
                      data: {
                        assessment_module: assessment_module.data,
                      },
                    })
                  "
                >
                  Penilaian Akhir Baru
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
                          <div>
                            {{ assessment_final_rule.code }}
                          </div>
                        </div>
                      </div>
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: 'Sunting Penilaian Akhir',
                            mode: 'assessment-aspect-edit-form',
                            maxWidth: 'md',
                            data: {
                              assessment_module: assessment_module.data,
                              assessment_final_rule: assessment_final_rule,
                            },
                          })
                        "
                      >
                        Sunting
                      </OutlineButton>
                      <OutlineButton
                        type="red"
                        @click="
                          openModal({
                            title: 'Hapus Penilaian Akhir',
                            mode: 'assessment-aspect-delete-confirm',
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
                        Hapus
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
