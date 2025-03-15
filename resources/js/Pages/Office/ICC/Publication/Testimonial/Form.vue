<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { testimonialTypes } from '@/Helpers/options';
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
      avatarPreview: null,
      avatarFile: null,
      form: {
        testimonial_id: null,
        type: null,
        name: null,
        relation: null,
        message: null,
        avatar: null,
      },
      field: {
        type: {
          label: 'Kategori',
          rules: [fieldValidation.isRequired('Kategori')],
          error: null,
          options: testimonialTypes,
        },
        name: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
        },
        relation: {
          label: 'Keterkaitan',
          rules: [fieldValidation.isRequired('Keterkaitan')],
          error: null,
        },
        message: {
          label: 'Testimoni',
          rules: [fieldValidation.isRequired('Testimoni')],
          error: null,
        },
        avatar: {
          label: 'Avatar',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'testimonial-edit-form') {
      this.form.testimonial_id = this.propertyModal.data.testimonial?.uuid;
      this.form.type = this.propertyModal.data.testimonial?.type;
      this.form.name = this.propertyModal.data.testimonial?.name;
      this.form.relation = this.propertyModal.data.testimonial?.relation;
      this.form.message = this.propertyModal.data.testimonial?.message;
      if (this.propertyModal.data.testimonial.avatar) {
        this.avatarPreview = this.propertyModal.data.testimonial.avatar_path;
      }
    }
  },
  methods: {
    handleAvatarFileChange(file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.avatarPreview = e.target.result;
      };
      reader.readAsDataURL(file.raw);

      this.form.avatar = null;
      this.avatarFile = file.raw;
    },
    submit() {
      this.$refs['testimonialForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          const formData = new FormData();
          formData.append('testimonial_id', requestPayload.testimonial_id);
          formData.append('type', requestPayload.type);
          formData.append('name', requestPayload.name);
          formData.append('relation', requestPayload.relation);
          formData.append('message', requestPayload.message);
          formData.append('avatar_file', this.avatarFile);

          axios
            .post(route('office.icc.publication.testimonial.save'), formData, {
              headers: { 'Content-Type': 'multipart/form-data' },
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
                  this.$refs['testimonialForm'].validateField(field);
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
      <el-form v-if="loaded" ref="testimonialForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.type.label"
          :rules="field.type.rules"
          :error="field.type.error"
          prop="type"
        >
          <el-radio-group v-model="form.type">
            <el-radio v-for="option in field.type.options" :key="option.value" :value="option.value">{{
              option.label
            }}</el-radio>
          </el-radio-group>
        </el-form-item>
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
          :label="field.avatar.label"
          :rules="field.avatar.rules"
          :error="field.avatar.error"
          prop="avatar"
          style="width: 100%"
        >
          <el-upload action="#" :auto-upload="false" :show-file-list="false" :on-change="handleAvatarFileChange">
            <img v-if="avatarPreview" :src="avatarPreview" class="flex h-28 w-28 rounded-lg object-cover" />
            <div v-else class="flex h-28 w-28 items-center justify-center rounded-lg bg-gray-100">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-14 w-14 text-gray-500"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
              </svg>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.relation.label"
          :rules="field.relation.rules"
          :error="field.relation.error"
          prop="relation"
        >
          <el-input v-model="form.relation" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.message.label"
          :rules="field.message.rules"
          :error="field.message.error"
          prop="message"
        >
          <el-input type="textarea" v-model="form.message" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
