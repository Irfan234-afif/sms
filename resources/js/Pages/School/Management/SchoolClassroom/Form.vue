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
        school_classroom_id: null,
        school_grade_id: null,
        school_major_id: null,
        homeroom_teacher_id: null,
        title: null,
        description: null,
      },
      field: {
        school_grade_id: {
          label: 'Tingkat Kelas',
          rules: [fieldValidation.isRequired('Tingkat Kelas')],
          error: null,
          disabled: false,
          options: [],
        },
        school_major_id: {
          label: 'Jurusan',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        homeroom_teacher_id: {
          label: 'Wali Kelas',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        title: {
          label: 'Kelas',
          rules: [fieldValidation.isRequired('Kelas')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'school-classroom-edit-form') {
      this.form.school_classroom_id = this.propertyModal.data.school_classroom?.uuid;
      this.form.school_grade_id = this.propertyModal.data.school_classroom.grade;
      this.field.school_grade_id.options = [this.propertyModal.data.school_classroom.grade];
      this.form.school_major_id = this.propertyModal.data.school_classroom.major;
      if (this.propertyModal.data.school_classroom.major) {
        this.field.school_major_id.options = [this.propertyModal.data.school_classroom.major];
      }
      this.form.homeroom_teacher_id = this.propertyModal.data.school_classroom.homeroom_teacher;
      if (this.propertyModal.data.school_classroom.homeroom_teacher) {
        this.field.homeroom_teacher_id.options = [this.propertyModal.data.school_classroom.homeroom_teacher];
      }
      this.form.title = this.propertyModal.data.school_classroom?.title;
    }
  },
  methods: {
    optionSchoolGrade(search) {
      this.field.school_grade_id.loading = true;
      axios
        .get(
          route('school.management.schoolClassroom.optionSchoolGrade', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school_grade_id.options = response.data;
          this.field.school_grade_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_grade_id.loading = false;
        });
    },
    optionSchoolMajor(search) {
      this.field.school_major_id.loading = true;
      axios
        .get(
          route('school.management.schoolClassroom.optionSchoolMajor', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school_major_id.options = response.data;
          this.field.school_major_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_major_id.loading = false;
        });
    },
    optionHomeroomTeacher(search) {
      this.field.homeroom_teacher_id.loading = true;
      axios
        .get(
          route('school.management.schoolClassroom.optionHomeroomTeacher', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.homeroom_teacher_id.options = response.data;
          this.field.homeroom_teacher_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.homeroom_teacher_id.loading = false;
        });
    },
    submit() {
      this.$refs['schoolClassroomForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.school_grade_id = requestPayload.school_grade_id.uuid;
          requestPayload.school_major_id = requestPayload.school_major_id.uuid;
          requestPayload.homeroom_teacher_id = requestPayload.homeroom_teacher_id.uuid;

          axios
            .post(route('school.management.schoolClassroom.save'), requestPayload, {
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
              ElNotification({
                title: 'Error',
                message: 'Terjadi kesalahan.',
                type: 'error',
              });
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field];
                  this.$refs['schoolClassroomForm'].validateField(field);
                }
              }
            })
            .finally(() => {
              this.process = false;
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
      <el-form v-if="loaded" ref="schoolClassroomForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.school_grade_id.label"
          :rules="field.school_grade_id.rules"
          :error="field.school_grade_id.error"
          prop="school_grade_id"
        >
          <el-select
            v-model="form.school_grade_id"
            :placeholder="`Pilih ${field.school_grade_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_grade_id.disabled"
            :remote-method="optionSchoolGrade"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.school_grade_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          v-if="propertyModal.data.school.use_major"
          class="font-medium"
          :label="field.school_major_id.label"
          :rules="field.school_major_id.rules"
          :error="field.school_major_id.error"
          prop="school_major_id"
        >
          <el-select
            v-model="form.school_major_id"
            :placeholder="`Pilih ${field.school_major_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_major_id.disabled"
            :remote-method="optionSchoolMajor"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.school_major_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.homeroom_teacher_id.label"
          :rules="field.homeroom_teacher_id.rules"
          :error="field.homeroom_teacher_id.error"
          prop="homeroom_teacher_id"
        >
          <el-select
            v-model="form.homeroom_teacher_id"
            :placeholder="`Pilih ${field.homeroom_teacher_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.homeroom_teacher_id.disabled"
            :remote-method="optionHomeroomTeacher"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.homeroom_teacher_id.options"
              :key="option.uuid"
              :label="option.profile.name"
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
