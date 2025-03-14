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
        product_id: null,
        name: null,
        price: null,
      },
      field: {
        name: {
          label: 'Formulir',
          rules: [fieldValidation.isRequired('Formulir')],
          error: null,
          disabled: true,
        },
        price: {
          label: 'Harga',
          rules: [fieldValidation.isRequired('Harga')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'admission-student-price-edit-form') {
      this.form.product_id = this.propertyModal.data.product?.uuid;
      this.form.name = this.propertyModal.data.product?.name;
      this.form.price = Math.round(this.propertyModal.data.product?.price);
    }
  },
  methods: {
    submit() {
      this.$refs['admissionStudentForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.management.admissionStudentPrice.save'), requestPayload, {
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
                  this.$refs['admissionStudentForm'].validateField(field);
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
      <el-form v-if="loaded" ref="admissionStudentForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.name.label"
          :rules="field.name.rules"
          :error="field.name.error"
          prop="name"
        >
          <el-input :disabled="field.name.disabled" v-model="form.name" autocomplete="off" />
        </el-form-item>

        <el-form-item
          class="font-medium"
          :label="field.price.label"
          :rules="field.price.rules"
          :error="field.price.error"
          prop="price"
        >
          <el-input type="number" v-model.number="form.price" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
