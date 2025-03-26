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
        school_academic_program_id: null,
        school_year_id: null,
        school_curriculum_id: null,
        name: null,
        description: null,
      },
      field: {
        school_year_id: {
          label: 'Tahun Ajaran',
          rules: [fieldValidation.isRequired('Tahun Ajaran')],
          error: null,
          disabled: false,
          options: [],
        },
        school_curriculum_id: {
          label: 'Kurikulum',
          rules: [fieldValidation.isRequired('Kurikulum')],
          error: null,
          disabled: false,
          options: [],
        },
        name: {
          label: 'Program Ajaran',
          rules: [fieldValidation.isRequired('Program Ajaran')],
          error: null,
        },
        is_active: {
          label: 'Status',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'academic-program-edit-form') {
      this.form.school_academic_program_id = this.propertyModal.data.school_academic_program?.uuid;
      this.form.school_year_id = this.propertyModal.data.school_academic_program.year;
      this.field.school_year_id.options = [this.propertyModal.data.school_academic_program.year];
      this.field.school_year_id.disabled = true;
      this.form.school_curriculum_id = this.propertyModal.data.school_academic_program.curriculum;
      this.field.school_curriculum_id.options = [this.propertyModal.data.school_academic_program.curriculum];
      this.form.name = this.propertyModal.data.school_academic_program?.name;
      this.form.is_active = !!this.propertyModal.data.school_academic_program?.is_active;
    }
  },
  methods: {
    optionSchoolYear(search) {
      this.field.school_year_id.loading = true;
      axios
        .get(
          route('school.setting.profile.academicProgram.optionSchoolYear', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school_year_id.options = response.data;
          this.field.school_year_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_year_id.loading = false;
        });
    },
    optionSchoolCurriculum(search) {
      this.field.school_curriculum_id.loading = true;
      axios
        .get(
          route('school.setting.profile.academicProgram.optionSchoolCurriculum', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school_curriculum_id.options = response.data;
          this.field.school_curriculum_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_curriculum_id.loading = false;
        });
    },
    submit() {
      this.$refs['schoolAcademicProgramForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.school_year_id = requestPayload.school_year_id.uuid;
          requestPayload.school_curriculum_id = requestPayload.school_curriculum_id.uuid;

          axios
            .post(route('school.setting.profile.academicProgram.save'), requestPayload, {
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
                  this.$refs['schoolAcademicProgramForm'].validateField(field);
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
      <el-form v-if="loaded" ref="schoolAcademicProgramForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.school_year_id.label"
          :rules="field.school_year_id.rules"
          :error="field.school_year_id.error"
          prop="school_year_id"
        >
          <el-select
            v-model="form.school_year_id"
            :placeholder="`Pilih ${field.school_year_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_year_id.disabled"
            :remote-method="optionSchoolYear"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.school_year_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.school_curriculum_id.label"
          :rules="field.school_curriculum_id.rules"
          :error="field.school_curriculum_id.error"
          prop="school_curriculum_id"
        >
          <el-select
            v-model="form.school_curriculum_id"
            :placeholder="`Pilih ${field.school_curriculum_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_curriculum_id.disabled"
            :remote-method="optionSchoolCurriculum"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.school_curriculum_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.is_active.label"
          :rules="field.is_active.rules"
          :error="field.is_active.error"
          prop="is_active"
        >
          <el-checkbox border v-model="form.is_active" :label="form.is_active ? 'Aktif' : 'Tidak Aktif'" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
