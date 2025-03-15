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
      imagesPreview: [],
      imagesFile: [],
      thumbnailIndex: null,
      form: {
        gallery_id: null,
        title: null,
        description: null,
        images: [],
      },
      field: {
        title: {
          label: 'Judul',
          rules: [fieldValidation.isRequired('Judul')],
          error: null,
        },
        description: {
          label: 'Keterangan',
          rules: [fieldValidation.isRequired('Keterangan')],
          error: null,
        },
        images: {
          label: 'Gambar',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    if (this.propertyModal && this.propertyModal.mode === 'gallery-edit-form') {
      this.form.gallery_id = this.propertyModal.data.gallery?.uuid;
      this.form.title = this.propertyModal.data.gallery?.title;
      this.form.description = this.propertyModal.data.gallery?.description;
      let items = this.propertyModal.data.gallery.items;
      this.thumbnailIndex = items.findIndex((x) => x.is_thumbnail == true) ?? null;
      if (this.propertyModal.data.gallery.items) {
        this.imagesPreview = this.propertyModal.data.gallery.items.map((img) => ({
          uuid: img.uuid || null,
          url: img.image_path,
        }));
      }
    }
  },
  methods: {
    handleImageFileChange(file) {
      if (!file || !file.raw) return;

      const reader = new FileReader();
      reader.onload = (e) => {
        this.imagesPreview.push({
          uuid: null,
          url: e.target.result,
          file: file.raw,
        });
      };
      reader.readAsDataURL(file.raw);

      this.imagesFile.push(file.raw);
    },
    removeImage(index) {
      this.imagesPreview.splice(index, 1);
      this.imagesFile.splice(index, 1);

      if (this.thumbnailIndex === index) {
        this.thumbnailIndex = this.imagesPreview.length > 0 ? 0 : null;
      } else if (this.thumbnailIndex > index) {
        this.thumbnailIndex--;
      }
    },
    setThumbnail(index) {
      this.thumbnailIndex = index;
    },
    submit() {
      this.$refs['galleryForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          const formData = new FormData();

          formData.append('gallery_id', this.form.gallery_id);
          formData.append('title', this.form.title);
          formData.append('description', this.form.description);
          formData.append('thumbnail', this.thumbnailIndex);

          this.imagesPreview.forEach((image, index) => {
            if (image.file) {
              formData.append(`images[${index}][file]`, image.file);
            }
            if (image.uuid) {
              formData.append(`images[${index}][uuid]`, image.uuid);
            }
          });

          axios
            .post(route('office.icc.publication.gallery.save'), formData, {
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
              let message = error.response?.data?.message || 'Terjadi kesalahan';
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  if (this.field[field]) {
                    this.field[field].error = error.response.data.errors[field][0];
                    this.$refs['galleryForm'].validateField(field);
                    message = error.response.data.errors[field][0];
                  }
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
      <el-form v-if="loaded" ref="galleryForm" label-position="top" :model="form" :disabled="process">
        <el-form-item :label="field.title.label" :rules="field.title.rules" :error="field.title.error" prop="title">
          <el-input v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <el-input type="textarea" v-model="form.description" autocomplete="off" />
        </el-form-item>
        <el-form-item :label="field.images.label" :rules="field.images.rules" :error="field.images.error" prop="images">
          <el-upload
            action="#"
            multiple
            :auto-upload="false"
            :show-file-list="false"
            :on-change="handleImageFileChange"
          >
            <div class="mx-auto flex items-center justify-center rounded-lg bg-gray-100 px-3 py-1">
              <span class="text-gray-500">Klik untuk unggah gambar</span>
            </div>
          </el-upload>
        </el-form-item>
        <div class="grid grid-cols-3 gap-4">
          <div v-for="(image, index) in imagesPreview" :key="index" class="relative">
            <img :src="image.url" class="h-36 w-full rounded-lg object-cover" />
            <div class="absolute left-2 top-2 space-x-2">
              <button
                type="button"
                v-if="thumbnailIndex === index"
                class="rounded bg-green-500 px-2 py-1 text-xs text-white"
              >
                Thumbnail
              </button>
              <button
                type="button"
                v-else
                @click="setThumbnail(index)"
                class="rounded bg-gray-300 px-2 py-1 text-xs text-gray-700"
              >
                Set Thumbnail
              </button>
              <button type="button" @click="removeImage(index)" class="rounded bg-red-500 px-2 py-1 text-xs text-white">
                Hapus
              </button>
            </div>
          </div>
        </div>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process">Batal</DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process">Simpan</DefaultButton>
    </div>
  </div>
</template>
