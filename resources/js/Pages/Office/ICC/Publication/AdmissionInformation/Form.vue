<script setup>
import CKEditor from '@/Components/CKEditor.vue';
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
        post_id: null,
        title: null,
        content: null,
        status: 'PUBLISHED',
      },
      field: {
        title: {
          label: 'Judul',
          rules: [fieldValidation.isRequired('Judul')],
          error: null,
        },
        content: {
          label: 'Konten',
          rules: [fieldValidation.isRequired('Konten')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'admission-information-edit-form') {
      this.form.post_id = this.propertyModal.data.post?.uuid;
      this.form.title = this.propertyModal.data.post?.title;
      this.form.content = this.propertyModal.data.post?.content;
    }
  },
  methods: {
    optionPostCategory(search) {
      this.field.post_category_id.loading = true;
      axios
        .get(
          route('office.icc.publication.admissionInformation.optionPostCategory', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.post_category_id.options = response.data;
          this.field.post_category_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.post_category_id.loading = false;
        });
    },
    submit() {
      this.$refs['admissionInformationForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('office.icc.publication.admissionInformation.save'), requestPayload, {
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
                  this.$refs['admissionInformationForm'].validateField(field);
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
      <el-form v-if="loaded" ref="admissionInformationForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.content.label"
          :rules="field.content.rules"
          :error="field.content.error"
          prop="content"
        >
          <div style="width: 100%">
            <CKEditor v-model="form.content" />
          </div>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
