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
      actionRoute: route('office.hcm.employee.resetPassword'),
      modeForm: this.propertyModal.mode,
      form: {
        user_id: null,
        password: null,
        password_confirmation: null,
      },
      field: {
        password: {
          label: 'Kata Sandi',
          rules: [fieldValidation.isRequired('Kata Sandi')],
          error: null,
        },
        password_confirmation: {
          label: 'Konfirmasi Kata Sandi',
          rules: [fieldValidation.isRequired('Konfirmasi Kata Sandi')],
          error: null,
        },
      },
    };
  },
  created() {
    let user = this.propertyModal.data.user;
    this.form.user_id = user.uuid;
  },
  methods: {
    submit() {
      this.$refs['resetPasswordForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(this.actionRoute, requestPayload, {
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
                  this.$refs['resetPasswordForm'].validateField(field);
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
    <h2 class="borde pb-2r-b mb-2 text-base font-medium text-gray-900">
      {{ propertyModal?.title }}
    </h2>
    <div class="px-2">
      <el-form v-if="loaded" ref="resetPasswordForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.password.label"
          :rules="field.password.rules"
          :error="field.password.error"
          prop="password"
        >
          <el-input v-model="form.password" type="password" autocomplete="off" />
        </el-form-item>

        <el-form-item
          class="font-medium"
          :label="field.password_confirmation.label"
          :rules="field.password_confirmation.rules"
          :error="field.password_confirmation.error"
          prop="password_confirmation"
        >
          <el-input v-model="form.password_confirmation" type="password" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Ubah Kata Sandi </DefaultButton>
    </div>
  </div>
</template>
