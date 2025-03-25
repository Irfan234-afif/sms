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
        school_extracurricular_id: null,
        mentor_id: null,
        title: null,
        description: null,
      },
      field: {
        mentor_id: {
          label: 'Pembimbing',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        title: {
          label: 'Ekstrakurikuler',
          rules: [fieldValidation.isRequired('Ekstrakurikuler')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'school-extracurricular-edit-form') {
      this.form.school_extracurricular_id = this.propertyModal.data.school_extracurricular?.uuid;
      this.form.mentor_id = this.propertyModal.data.school_extracurricular.mentor;
      if (this.propertyModal.data.school_extracurricular.mentor) {
        this.field.mentor_id.options = [this.propertyModal.data.school_extracurricular.mentor];
      }
      this.form.title = this.propertyModal.data.school_extracurricular?.title;
    }
  },
  methods: {
    optionMentor(search) {
      this.field.mentor_id.loading = true;
      axios
        .get(
          route('school.management.schoolExtracurricular.optionMentor', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.mentor_id.options = response.data;
          this.field.mentor_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.mentor_id.loading = false;
        });
    },
    submit() {
      this.$refs['schoolExtracurricularForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.mentor_id = requestPayload.mentor_id.uuid;

          axios
            .post(route('school.management.schoolExtracurricular.save'), requestPayload, {
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
                  this.$refs['schoolExtracurricularForm'].validateField(field);
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
      <el-form v-if="loaded" ref="schoolExtracurricularForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.mentor_id.label"
          :rules="field.mentor_id.rules"
          :error="field.mentor_id.error"
          prop="mentor_id"
        >
          <el-select
            v-model="form.mentor_id"
            :placeholder="`Pilih ${field.mentor_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.mentor_id.disabled"
            :remote-method="optionMentor"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.mentor_id.options"
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
