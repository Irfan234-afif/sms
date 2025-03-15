<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import CKEditor from '@/Components/CKEditor.vue';
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
      thumbnailPreview: null,
      thumbnailFile: null,
      form: {
        post_id: null,
        post_category_id: null,
        title: null,
        thumbnail: null,
        content: '',
        status: 'PUBLISHED',
      },
      field: {
        post_category_id: {
          label: 'Kategori',
          rules: [fieldValidation.isRequired('Kategori')],
          error: null,
          disabled: false,
          options: [],
        },
        title: {
          label: 'Judul',
          rules: [fieldValidation.isRequired('Judul')],
          error: null,
        },
        thumbnail: {
          label: 'Thumbnail',
          rules: [],
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
    if (mode == 'post-edit-form') {
      this.form.post_id = this.propertyModal.data.post?.uuid;
      this.form.post_category_id = this.propertyModal.data.post.category;
      if (this.propertyModal.data.post.category) {
        this.field.post_category_id.options = [this.propertyModal.data.post.category];
      }
      this.form.title = this.propertyModal.data.post?.title;
      if (this.propertyModal.data.post.thumbnail) {
        this.thumbnailPreview = this.propertyModal.data.post.thumbnail_path;
      }
      this.form.content = this.propertyModal.data.post?.content;
    }
  },
  methods: {
    handleThumbnailFileChange(file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.thumbnailPreview = e.target.result;
      };
      reader.readAsDataURL(file.raw);

      this.form.thumbnail = null;
      this.thumbnailFile = file.raw;
    },
    optionPostCategory(search) {
      this.field.post_category_id.loading = true;
      axios
        .get(
          route('office.icc.publication.news.optionPostCategory', {
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
      this.$refs['newsForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.post_category_id = requestPayload.post_category_id.uuid;

          const formData = new FormData();
          formData.append('post_id', requestPayload.post_id);
          formData.append('post_category_id', requestPayload.post_category_id);
          formData.append('title', requestPayload.title);
          formData.append('thumbnail_file', this.thumbnailFile);
          formData.append('content', requestPayload.content);
          formData.append('status', requestPayload.status);

          axios
            .post(route('office.icc.publication.news.save'), formData, {
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
                  this.$refs['newsForm'].validateField(field);
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
      <el-form v-if="loaded" ref="newsForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.thumbnail.label"
          :rules="field.thumbnail.rules"
          :error="field.thumbnail.error"
          prop="thumbnail"
        >
          <el-upload action="#" :auto-upload="false" :show-file-list="false" :on-change="handleThumbnailFileChange">
            <img v-if="thumbnailPreview" :src="thumbnailPreview" class="flex h-36 rounded-lg object-cover" />
            <div v-else class="flex h-36 w-64 items-center justify-center rounded-lg bg-gray-100">
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
                <path d="M15 8h.01" />
                <path d="M3 6a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v12a3 3 0 0 1 -3 3h-12a3 3 0 0 1 -3 -3v-12z" />
                <path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l5 5" />
                <path d="M14 14l1 -1c.928 -.893 2.072 -.893 3 0l3 3" />
              </svg>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.post_category_id.label"
          :rules="field.post_category_id.rules"
          :error="field.post_category_id.error"
          prop="post_category_id"
        >
          <el-select
            v-model="form.post_category_id"
            :placeholder="`Pilih ${field.post_category_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.post_category_id.disabled"
            :remote-method="optionPostCategory"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.post_category_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.content.label"
          :rules="field.content.rules"
          :error="field.content.error"
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
