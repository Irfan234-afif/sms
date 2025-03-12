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
        post_id: null,
        post_category_id: null,
        title: null,
        content: null,
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
          label: 'Informasi Pendaftaran',
          rules: [fieldValidation.isRequired('Informasi Pendaftaran')],
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
      this.form.post_category_id = this.propertyModal.data.post.category;
      this.field.post_category_id.options = [this.propertyModal.data.post.category];
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

          // requestPayload.post_category_id = requestPayload.post_category_id.uuid;

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
              ElNotification({
                title: 'Error',
                message: 'Terjadi kesalahan.',
                type: 'error',
              });
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field];
                  this.$refs['admissionInformationForm'].validateField(field);
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
        <!-- <el-form-item
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
        </el-form-item> -->
        <el-form-item
          class="font-medium"
          :label="field.content.label"
          :rules="field.content.rules"
          :error="field.content.error"
          prop="content"
        >
          <el-input type="textarea" :rows="25" v-model="form.content" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
