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
        school_subject_id: null,
        assessment_module_id: null,
        school_classroom_id: this.propertyModal.data.school_classroom.uuid,
        name: null,
      },
      field: {
        school_subject_id: {
          label: 'Mata Pelajaran',
          rules: [fieldValidation.isRequired('Mata Pelajaran')],
          error: null,
          disabled: false,
          options: [],
        },
        assessment_module_id: {
          label: 'Modul Penilaian',
          rules: [fieldValidation.isRequired('Modul Penilaian')],
          error: null,
          disabled: false,
          options: [],
        },
        name: {
          label: 'Penilaian',
          rules: [fieldValidation.isRequired('Penilaian')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'assessment-record-edit-form') {
      this.form.school_subject_id = this.propertyModal.data.assessment_record.subject;
      this.field.school_subject_id.options = [this.propertyModal.data.assessment_record.subject];
      this.field.school_subject_id.disabled = true;
      this.form.assessment_module_id = this.propertyModal.data.assessment_record.module;
      this.field.assessment_module_id.options = [this.propertyModal.data.assessment_record.module];
      this.field.assessment_module_id.disabled = true;
      this.form.name = this.propertyModal.data.assessment_record?.name;
    }
  },
  methods: {
    optionSchoolSubject(search) {
      this.field.school_subject_id.loading = true;
      axios
        .get(
          route('school.learningActivity.schoolClassroom.assessmentSubject.optionSchoolSubject', {
            search: search,
            school_classroom_id: this.propertyModal.data.school_classroom.uuid,
          }),
        )
        .then((response) => {
          this.field.school_subject_id.options = response.data;
          this.field.school_subject_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_subject_id.loading = false;
        });
    },
    optionAssessmentModule(search) {
      this.field.assessment_module_id.loading = true;
      axios
        .get(
          route('school.learningActivity.schoolClassroom.assessmentSubject.optionAssessmentModule', {
            search: search,
            school_classroom_id: this.propertyModal.data.school_classroom.uuid,
          }),
        )
        .then((response) => {
          this.field.assessment_module_id.options = response.data;
          this.field.assessment_module_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.assessment_module_id.loading = false;
        });
    },
    submit() {
      this.$refs['assessmentRecordForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.school_subject_id = requestPayload.school_subject_id.uuid;
          requestPayload.assessment_module_id = requestPayload.assessment_module_id.uuid;

          axios
            .post(
              route('school.learningActivity.schoolClassroom.assessmentSubject.save', {
                school_classroom_id: this.propertyModal.data.school_classroom.uuid,
              }),
              requestPayload,
              {
                headers: { 'Content-Type': 'application/json' },
              },
            )
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
                  this.$refs['assessmentRecordForm'].validateField(field);
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
      <el-form v-if="loaded" ref="assessmentRecordForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.name.label"
          :rules="field.name.rules"
          :error="field.name.error"
          prop="name"
        >
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.school_subject_id.label"
          :rules="field.school_subject_id.rules"
          :error="field.school_subject_id.error"
          prop="school_subject_id"
        >
          <el-select
            v-model="form.school_subject_id"
            :placeholder="`Pilih ${field.school_subject_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_subject_id.disabled"
            :remote-method="optionSchoolSubject"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.school_subject_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.assessment_module_id.label"
          :rules="field.assessment_module_id.rules"
          :error="field.assessment_module_id.error"
          prop="assessment_module_id"
        >
          <el-select
            v-model="form.assessment_module_id"
            :placeholder="`Pilih ${field.assessment_module_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.assessment_module_id.disabled"
            :remote-method="optionAssessmentModule"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.assessment_module_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
