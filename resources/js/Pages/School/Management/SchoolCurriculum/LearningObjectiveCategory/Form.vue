<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
</script>

<script>
export default {
  props: {
    propertyModal: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      process: false,
      loaded: true,
      isValid: false,
      form: {
        learning_objective_category_id: this.propertyModal.data?.learning_objective_category?.uuid,
        school_curriculum_id: this.propertyModal.data.school_curriculum.uuid,
        parent_id: null,
        title: null,
        code: null,
        options: {
          scope_school_year: false,
          scope_school_phase: false,
          scope_school_grade: false,
          scope_school_subject: false,
        },
      },
      field: {
        parent_id: {
          label: 'Grup',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        title: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
          disabled: false,
          options: [],
        },
        code: {
          label: 'Kode',
          rules: [fieldValidation.isRequired('Kode')],
          error: null,
          disabled: false,
          options: [],
        },
        options: {
          label: 'Cakupan',
          rules: [fieldValidation.isRequired('Cakupan')],
          error: null,
          disabled: false,
          options: [],
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'learning-objective-category-edit-form') {
      this.form.title = this.propertyModal.data.learning_objective_category?.title;
      this.form.code = this.propertyModal.data.learning_objective_category?.code;
      this.form.parent_id = this.propertyModal.data.learning_objective_category?.parent;
      if (this.propertyModal.data.learning_objective_category.parent) {
        this.field.parent_id.options = [this.propertyModal.data.learning_objective_category.parent];
      }
      this.form.options = this.propertyModal.data.learning_objective_category?.options;
    }
  },
  methods: {
    optionLearningObjectiveCategory(search) {
      this.field.parent_id.loading = true;
      axios
        .get(
          route('school.management.schoolCurriculum.learningObjectiveCategory.optionParent', {
            school_curriculum_id: this.form.school_curriculum_id,
            learning_objective_category_id: this.form.learning_objective_category_id,
            search: search,
          }),
        )
        .then((response) => {
          this.field.parent_id.options = response.data;
          this.field.parent_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.parent_id.loading = false;
        });
    },
    submit() {
      this.$refs['learningObjectiveCategoryForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.parent_id = requestPayload.parent_id?.uuid;

          axios
            .post(route('school.management.schoolCurriculum.learningObjectiveCategory.save'), requestPayload, {
              headers: { 'Content-Type': 'application/json' },
            })
            .then((response) => {
              if (response.data.status === 'success') {
                ElNotification({
                  title: 'Berhasil',
                  message: response.data.message,
                  type: 'success',
                });
                setTimeout(() => {
                  this.close();
                  this.$inertia.reload();
                }, 2000);
              } else {
                ElNotification({
                  title: 'Error',
                  message: response.data.message,
                  type: 'error',
                });
              }
            })
            .catch((error) => {
              let message = 'Terjadi kesalahan';
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field][0];
                  this.$refs['learningObjectiveCategoryForm'].validateField(field);
                  message = error.response.data.errors[field][0];
                }
              }

              ElNotification({
                title: 'Error',
                message: message,
                type: 'error',
              });
            })
            .finally(() => {
              this.process = false;
              this.loaded = false;
              this.$nextTick(() => {
                this.loaded = true;
              });
            });
        }
      });
    },
    close() {
      this.$emit('close');
    },
  },
};
</script>

<template>
  <div class="space-y-6 p-5">
    <h2 class="border-b pb-4 text-base font-medium text-gray-900">
      {{ propertyModal?.title }}
    </h2>
    <div class="px-2">
      <el-form v-if="loaded" ref="learningObjectiveCategoryForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.title.label"
          :rules="field.title.rules"
          :error="field.title.error"
          prop="title"
        >
          <el-input v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.code.label"
          :rules="field.code.rules"
          :error="field.code.error"
          prop="code"
        >
          <el-input v-model="form.code" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.parent_id.label"
          :rules="field.parent_id.rules"
          :error="field.parent_id.error"
          prop="parent_id"
        >
          <el-select
            v-model="form.parent_id"
            :placeholder="`Pilih ${field.parent_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.parent_id.disabled"
            :remote-method="optionLearningObjectiveCategory"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.parent_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.options.label"
          :rules="field.options.rules"
          :error="field.options.error"
          prop="options"
        >
          <el-row :gutter="10">
            <el-col :span="12">
              <el-checkbox border class="w-full" v-model="form.options.scope_school_phase">Fase</el-checkbox>
            </el-col>
            <el-col :span="12">
              <el-checkbox
                border
                class="w-full"
                :disabled="form.options.scope_school_phase == false"
                v-model="form.options.scope_school_grade"
                >Tingkat Kelas</el-checkbox
              >
            </el-col>
            <el-col :span="12">
              <el-checkbox
                border
                class="w-full"
                :disabled="form.options.scope_school_grade == false"
                v-model="form.options.scope_school_subject"
                >Mata Pelajaran</el-checkbox
              >
            </el-col>
            <el-col :span="12">
              <el-checkbox
                border
                class="w-full"
                :disabled="form.options.scope_school_subject == false"
                v-model="form.options.scope_school_year"
                >Tahun Ajaran</el-checkbox
              >
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
