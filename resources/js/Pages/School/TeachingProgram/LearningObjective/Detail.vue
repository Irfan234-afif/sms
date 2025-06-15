<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import LearningObjectiveForm from './Form.vue';
import DeleteConfirm from '@/Components/DeleteConfirm.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import Search from '@/Components/Search.vue';
</script>

<script>
export default {
  props: {
    search_params: Object,
    school_curriculum: Object,
    learning_objective_category: Object,
  },
  data() {
    return {
      breadcrumbs: [
        { label: 'Sekolah', href: route('school') },
        {
          label: `Objektif Pembelajaran (${this.school_curriculum.data.title})`,
          href: route('school.teachingProgram.learningObjective'),
        },
        { label: 'Lihat', href: '#' },
      ],
      showModal: false,
      propertyModal: {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      },
      learning_objectives: [],
      filters: {
        search: null,
        school_phase_id: null,
        school_grade_id: null,
        school_objective_id: null,
      },
      filterOptions: {
        school_phase_id: [],
        school_grade_id: [],
        school_objective_id: [],
      },
    };
  },
  methods: {
    updateSchoolGrade() {
      this.filters.school_grade_id = null;
      this.filterOptions.school_grade_id = [];
      if (this.filters.school_phase_id) {
        this.filterOptions.school_grade_id = this.filters.school_phase_id.grades;
      }
    },
    optionSchoolPhase(search) {
      axios
        .get(
          route('school.teachingProgram.learningObjective.optionSchoolPhase', {
            search: search,
          }),
        )
        .then((response) => {
          this.filterOptions.school_phase_id = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionSchoolGrade(search) {
      axios
        .get(
          route('school.teachingProgram.learningObjective.optionSchoolGrade', {
            search: search,
            school_phase_id: this.filters.school_phase_id?.uuid,
          }),
        )
        .then((response) => {
          this.filterOptions.school_grade_id = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionSchoolObjective(search) {
      axios
        .get(
          route('school.teachingProgram.learningObjective.optionSchoolObjective', {
            search: search,
            learning_objective_category_id: this.learning_objective_category.data.uuid,
          }),
        )
        .then((response) => {
          this.filterOptions.school_objective_id = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getLearningObjective() {
      if (
        this.learning_objective_category.data.options.scope_school_grade ||
        this.learning_objective_category.data.type == 'EXTRACURRICULAR'
      ) {
        axios
          .get(
            route('school.teachingProgram.learningObjective.getLearningObjective', {
              learning_objective_category_id: this.learning_objective_category.data.uuid,
              school_phase_id: this.filters.school_phase_id?.uuid,
              school_grade_id: this.filters.school_grade_id?.uuid,
              school_objective_id: this.filters.school_objective_id?.uuid,
            }),
          )
          .then((response) => {
            this.learning_objectives = response.data;
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    openModal(property) {
      this.showModal = true;
      this.propertyModal = property;
    },
    closeModal() {
      this.getLearningObjective();
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
            {{ learning_objective_category.data.title }}
          </h1>
          <hr />
          <div
            class="mt-3 flex flex-col items-stretch justify-between space-y-3 py-1 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
          >
            <div class="flex w-full space-x-3 md:w-1/3">
              <el-select
                v-if="learning_objective_category.data.options.scope_school_phase"
                v-model="filters.school_phase_id"
                placeholder="Pilih Fase"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="optionSchoolPhase"
                value-key="uuid"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
                @change="
                  filters.school_grade_id = null;
                  getLearningObjective;
                "
              >
                <el-option
                  v-for="option in filterOptions.school_phase_id"
                  :key="option.uuid"
                  :label="option.title"
                  :value="option"
                />
              </el-select>
              <el-select
                v-if="learning_objective_category.data.options.scope_school_grade"
                v-model="filters.school_grade_id"
                placeholder="Pilih Tingkat Kelas"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="optionSchoolGrade"
                value-key="uuid"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
                @change="getLearningObjective"
              >
                <el-option
                  v-for="option in filterOptions.school_grade_id"
                  :key="option.uuid"
                  :label="`Kelas ${option.title}`"
                  :value="option"
                />
              </el-select>
              <el-select
                v-if="learning_objective_category.data.options.scope_school_objective"
                v-model="filters.school_objective_id"
                :placeholder="`Pilih ${learning_objective_category.data.type_label}`"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="optionSchoolObjective"
                value-key="uuid"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
                @change="getLearningObjective"
              >
                <el-option
                  v-for="option in filterOptions.school_objective_id"
                  :key="option.uuid"
                  :label="option.title"
                  :value="option"
                />
              </el-select>
            </div>
          </div>
          <div>
            <div
              class="mt-3 flex flex-col items-stretch justify-between space-y-3 py-1 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
            >
              <div class="invisible w-full md:w-1/3">
                <Search :search_params="search_params" />
              </div>
              <div
                class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0"
              >
                <DefaultButton
                  type="default"
                  @click="
                    openModal({
                      title: 'Objektif Pembelajaran Baru',
                      mode: 'learning-objective-create-form',
                      maxWidth: 'xl',
                      data: {
                        learning_objective_category: learning_objective_category.data,
                        school_phase_id: filters.school_phase_id?.uuid,
                        school_grade_id: filters.school_grade_id?.uuid,
                        school_objective_id: filters.school_objective_id?.uuid,
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
                    <div>Objektif Pembelajaran Baru</div>
                  </div>
                </DefaultButton>
              </div>
            </div>
            <div class="relative mt-3 overflow-hidden bg-white shadow-md dark:bg-gray-800">
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
                      <th scope="col" class="p-4">Kode</th>
                      <th v-if="learning_objective_category.data.parent" scope="col" class="p-4">Grup</th>
                      <th scope="col" class="p-4"></th>
                    </tr>
                  </thead>
                  <tbody class="text-xs">
                    <tr
                      v-for="(learning_objective, index) in learning_objectives"
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
                          {{ learning_objective.code }}
                        </div>
                      </th>
                      <th
                        v-if="learning_objective_category.data.parent"
                        scope="row"
                        class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                      >
                        <div class="flex items-center">
                          {{ learning_objective.parent?.code }}
                        </div>
                      </th>
                      <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                        <div class="flex items-center justify-end space-x-3">
                          <OutlineButton
                            type="default"
                            @click="
                              openModal({
                                title: `Sunting ${learning_objective.code}`,
                                mode: 'learning-objective-edit-form',
                                maxWidth: 'xl',
                                data: {
                                  learning_objective: learning_objective,
                                  learning_objective_category: learning_objective_category.data,
                                  school_phase_id: filters.school_phase_id?.uuid,
                                  school_grade_id: filters.school_grade_id?.uuid,
                                  school_objective_id: filters.school_objective_id?.uuid,
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
                                title: `Hapus ${learning_objective.code}`,
                                mode: 'learning-objective-delete-confirm',
                                maxWidth: 'md',
                                data: {
                                  actionUrl: route('school.teachingProgram.learningObjective.delete', {
                                    learning_objective_id: learning_objective.uuid,
                                  }),
                                  redirectUrl: route('school.teachingProgram.learningObjective.detail', {
                                    learning_objective_category: learning_objective_category.data,
                                  }),
                                  message: `Ingin menghapus ${learning_objective.code}? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?`,
                                },
                              })
                            "
                          >
                            Hapus
                          </OutlineButton>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <LearningObjectiveForm
            v-if="
              propertyModal?.mode == 'learning-objective-create-form' ||
              propertyModal?.mode == 'learning-objective-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DeleteConfirm
            v-if="propertyModal?.mode == 'learning-objective-delete-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
