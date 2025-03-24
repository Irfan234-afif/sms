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
        learning_objective_id: null,
        learning_objective_category_id: this.propertyModal.data.learning_objective_category.uuid,
        school_phase_id: this.propertyModal.data.school_phase_id,
        school_grade_id: this.propertyModal.data.school_grade_id,
        school_subject_id: this.propertyModal.data.school_subject_id,
        parent_id: null,
        title: null,
        code: null,
        narrative: null,
      },
      field: {
        parent_id: {
          label: 'Grup',
          rules: [fieldValidation.isRequired('Grup')],
          error: null,
          loading: [],
          options: [],
        },
        title: {
          label: 'Indikator',
          rules: [fieldValidation.isRequired('Indikator')],
          error: null,
        },
        code: {
          label: 'Kode',
          rules: [fieldValidation.isRequired('Kode')],
          error: null,
        },
        narrative: {
          label: 'Naratif',
          rules: [fieldValidation.isRequired('Naratif')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'learning-objective-edit-form') {
      this.form.learning_objective_id = this.propertyModal.data.learning_objective?.uuid;
      this.form.parent_id = this.propertyModal.data.learning_objective?.parent;
      if (this.propertyModal.data.learning_objective?.parent) {
        this.field.parent_id.options = [this.propertyModal.data.learning_objective?.parent];
      }
      this.form.title = this.propertyModal.data.learning_objective?.title;
      this.form.code = this.propertyModal.data.learning_objective?.code;
      this.form.narrative = this.propertyModal.data.learning_objective?.narrative;
    }
  },
  methods: {
    optionLearningObjective(search) {
      this.field.parent_id.loading = true;
      axios
        .get(
          route('school.teachingProgram.learningObjective.optionLearningObjective', {
            search: search,
            learning_objective_category_id: this.form.learning_objective_category_id,
            school_phase_id: this.form.school_phase_id,
            school_grade_id: this.form.school_grade_id,
            school_subject_id: this.form.school_subject_id,
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
      this.$refs['learningObjectiveForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.parent_id = requestPayload.parent_id?.uuid;

          axios
            .post(route('school.teachingProgram.learningObjective.save'), requestPayload, {
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
                  this.$refs['learningObjectiveForm'].validateField(field);
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
      <el-form v-if="loaded" ref="learningObjectiveForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          v-if="propertyModal.data.learning_objective_category.parent"
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
            :remote-method="optionLearningObjective"
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
              :label="option.code"
              :value="option"
            />
          </el-select>
        </el-form-item>
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
          :label="field.narrative.label"
          :rules="field.narrative.rules"
          :error="field.narrative.error"
          prop="narrative"
        >
          <el-input type="textarea" v-model="form.narrative" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
