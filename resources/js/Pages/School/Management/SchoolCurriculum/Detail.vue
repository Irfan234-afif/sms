<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import LearningObjectiveCategoryForm from './LearningObjectiveCategory/Form.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import DeleteConfirm from '@/Components/DeleteConfirm.vue';
import Badge from '@/Components/Badge.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kurikulum', href: route('school.management.schoolCurriculum') },
  { label: 'Lihat', href: '#' },
];
</script>

<script>
export default {
  components: { Badge },
  props: {
    school_curriculum: Object,
    learning_objective_categories: Object,
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
            {{ school_curriculum.data.title }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Kode</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_curriculum.data.code }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
          <div
            class="mt-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">
                Kategori Indikator Pembelajaran
              </h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Kategori Indikator Pembelajaran Baru',
                    mode: 'learning-objective-category-create-form',
                    maxWidth: 'md',
                    data: {
                      school_curriculum: school_curriculum.data,
                    },
                  })
                "
              >
                Kategori Baru
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li
                  v-for="(learning_objective_category, index) in learning_objective_categories.data"
                  :key="index"
                  class="py-3 sm:py-4"
                >
                  <div class="flex items-center space-x-2">
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ learning_objective_category.title }}
                      </p>
                      <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                        <div>
                          {{ learning_objective_category.code }}
                        </div>
                        <Badge v-if="learning_objective_category.parent" type="purple">
                          Grup {{ learning_objective_category.parent.title }}
                        </Badge>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Kategori Indikator Pembelajaran',
                          mode: 'learning-objective-category-edit-form',
                          maxWidth: 'md',
                          data: {
                            school_curriculum: school_curriculum.data,
                            learning_objective_category: learning_objective_category,
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
                          title: 'Hapus Kategori Indikator Pembelajaran',
                          mode: 'learning-objective-category-delete-confirm',
                          maxWidth: 'md',
                          data: {
                            actionUrl: route('school.management.schoolCurriculum.learningObjectiveCategory.delete', {
                              learning_objective_category_id: learning_objective_category.uuid,
                            }),
                            redirectUrl: route('school.management.schoolCurriculum.detail', {
                              school_curriculum_id: school_curriculum.data.uuid,
                            }),
                            message:
                              'Ingin menghapus Kategori Indikator Pembelajaran? Tindakan ini akan memengaruhi data terkait serta hasil penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
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
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <LearningObjectiveCategoryForm
            v-if="
              propertyModal?.mode == 'learning-objective-category-create-form' ||
              propertyModal?.mode == 'learning-objective-category-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DeleteConfirm
            v-if="propertyModal?.mode == 'learning-objective-category-delete-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
