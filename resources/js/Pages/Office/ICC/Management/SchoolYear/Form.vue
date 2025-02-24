<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import midtrans from '@/Configs/midtrans';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';

midtrans.init();
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
        school_year: null,
        name: null,
        year_range: null,
        is_active: false,
      },
      field: {
        name: {
          label: 'Tahun Ajaran',
          rules: [fieldValidation.isRequired('Tahun Ajaran')],
          error: null,
        },
        year_range: {
          label: 'Rentang Tahun',
          rules: [fieldValidation.isRequired('Rentang Tahun')],
          error: null,
        },
        is_active: {
          label: 'Status',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'school-year-edit-form') {
      this.form.school_year = this.propertyModal.data.school_year?.uuid;
      this.form.name = this.propertyModal.data.school_year?.name;
      this.form.year_range =
        this.propertyModal.data.school_year?.start_year && this.propertyModal.data.school_year?.end_year
          ? [
              new Date(this.propertyModal.data.school_year.start_year, 0, 1),
              new Date(this.propertyModal.data.school_year.end_year, 0, 1),
            ]
          : null;
      this.form.is_active = this.propertyModal.data.school_year?.is_active;
    }
  },
  methods: {
    submit() {
      this.$refs['schoolYearForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = {
            ...this.form,
            start_year: this.form.year_range ? this.form.year_range[0].getFullYear() : null,
            end_year: this.form.year_range ? this.form.year_range[1].getFullYear() : null,
          };

          delete requestPayload.year_range;

          axios
            .post(route('office.icc.management.schoolYear.save'), requestPayload, {
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
                  this.$refs['schoolYearForm'].validateField(field);
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
      <el-form v-if="loaded" ref="schoolYearForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.year_range.label"
          :rules="field.year_range.rules"
          :error="field.year_range.error"
          prop="year_range"
        >
          <el-date-picker
            v-model="form.year_range"
            type="yearrange"
            range-separator="Sampai"
            start-placeholder="Tahun Mulai"
            end-placeholder="Tahun Akhir"
          />
        </el-form-item>

        <el-form-item
          class="font-medium"
          :label="field.is_active.label"
          :rules="field.is_active.rules"
          :error="field.is_active.error"
          prop="is_active"
        >
          <el-checkbox border v-model="form.is_active" :label="form.is_active ? 'Aktif' : 'Tidak Aktif'" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
