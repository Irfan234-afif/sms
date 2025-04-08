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
        career_id: null,
        job_title: null,
        job_description: null,
      },
      field: {
        job_title: {
          label: 'Karir',
          rules: [fieldValidation.isRequired('Karir')],
          error: null,
        },
        job_description: {
          label: 'Deskripsi',
          rules: [fieldValidation.isRequired('Deskripsi')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'career-edit-form') {
      this.form.career_id = this.propertyModal.data.career?.uuid;
      this.form.job_title = this.propertyModal.data.career?.job_title;
      this.form.job_description = this.propertyModal.data.career?.job_description;
    }
  },
  methods: {
    submit() {
      this.$refs['careerForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.career.save'), requestPayload, {
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
                  this.$refs['careerForm'].validateField(field);
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
      <el-form v-if="loaded" ref="careerForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.job_title.label"
          :rules="field.job_title.rules"
          :error="field.job_title.error"
          prop="job_title"
        >
          <el-input v-model="form.job_title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.job_description.label"
          :rules="field.job_description.rules"
          :error="field.job_description.error"
          prop="job_description"
        >
          <el-input type="textarea" v-model="form.job_description" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
