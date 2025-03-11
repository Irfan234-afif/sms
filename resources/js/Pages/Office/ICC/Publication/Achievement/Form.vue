<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { achievementTypes } from '@/Helpers/options';
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
        achievement_id: null,
        title: null,
        description: null,
        category: null,
        status: 'PUBLISHED',
      },
      field: {
        title: {
          label: 'Pencapaian',
          rules: [fieldValidation.isRequired('Pencapaian')],
          error: null,
        },
        description: {
          label: 'Keterangan',
          rules: [fieldValidation.isRequired('Keterangan')],
          error: null,
        },
        category: {
          label: 'Kategori',
          rules: [fieldValidation.isRequired('Keterkaitan')],
          error: null,
          options: achievementTypes,
        },
        status: {
          label: 'Status',
          rules: [fieldValidation.isRequired('Status')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'achievement-edit-form') {
      this.form.achievement_id = this.propertyModal.data.achievement?.uuid;
      this.form.title = this.propertyModal.data.achievement?.title;
      this.form.description = this.propertyModal.data.achievement?.description;
      this.form.category = this.propertyModal.data.achievement?.category;
      this.form.status = this.propertyModal.data.achievement?.status;
    }
  },
  methods: {
    submit() {
      this.$refs['achievementForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.achievement.save'), requestPayload, {
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
                  this.$refs['achievementForm'].validateField(field);
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
      <el-form v-if="loaded" ref="achievementForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.category.label"
          :rules="field.category.rules"
          :error="field.category.error"
          prop="category"
        >
          <el-radio-group v-model="form.category">
            <el-radio v-for="option in field.category.options" :key="option.value" :value="option.value">{{
              option.label
            }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.title.label"
          :rules="field.title.rules"
          :error="field.title.error"
          prop="title"
        >
          <el-input type="textarea" v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <el-input type="textarea" v-model="form.description" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
