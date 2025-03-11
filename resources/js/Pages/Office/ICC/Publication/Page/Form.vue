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
        page_id: null,
        title: null,
        content: null,
      },
      field: {
        title: {
          label: 'Halaman',
          rules: [fieldValidation.isRequired('Halaman')],
          error: null,
          disabled: true,
        },
        content: {
          label: 'Konten',
          rules: [fieldValidation.isRequired('Konten')],
          error: null,
          disabled: false,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'page-edit-form') {
      this.form.page_id = this.propertyModal.data.page?.uuid;
      this.form.title = this.propertyModal.data.page?.title;
      this.form.type = this.propertyModal.data.page?.type;
      this.form.content = this.propertyModal.data.page?.content;
    }
  },
  methods: {
    submit() {
      this.$refs['pageForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.page.save'), requestPayload, {
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
                  this.$refs['pageForm'].validateField(field);
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
      <el-form v-if="loaded" ref="pageForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.title.label"
          :rules="field.title.rules"
          :error="field.title.error"
          prop="title"
        >
          <el-input :disabled="field.title.disabled" v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.content.label"
          :rules="field.content.rules"
          :error="field.content.error"
          prop="content"
        >
          <el-input :rows="20" type="textarea" :disabled="field.content.disabled" v-model="form.content" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
