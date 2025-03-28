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
      public_feedback: this.propertyModal.data.public_feedback,
    };
  },
  created() {},
  methods: {
    submit() {
      this.$refs['publicFeedbackForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.publicFeedback.save'), requestPayload, {
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
                  this.$refs['publicFeedbackForm'].validateField(field);
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
      <div class="space-y-4">
        <h2 class="text-base font-medium text-gray-900 dark:text-white">{{ public_feedback.name }}</h2>
        <div class="grid gap-4 sm:grid-cols-1 sm:gap-8 lg:gap-12">
          <div class="space-y-4">
            <dl>
              <dt class="text-sm font-medium text-gray-800 dark:text-white">Email</dt>
              <dd class="text-sm text-gray-500 dark:text-gray-400">
                {{ public_feedback.email ?? '-' }}
              </dd>
            </dl>

            <dl>
              <dt class="text-sm font-medium text-gray-800 dark:text-white">Nomor Telepon</dt>
              <dd class="text-sm text-gray-500 dark:text-gray-400">
                {{ public_feedback.phone ?? '-' }}
              </dd>
            </dl>

            <dl>
              <dt class="text-sm font-medium text-gray-800 dark:text-white">Subjek</dt>
              <dd class="text-sm text-gray-500 dark:text-gray-400">
                {{ public_feedback.subject ?? '-' }}
              </dd>
            </dl>

            <dl>
              <dt class="text-sm font-medium text-gray-800 dark:text-white">Pesan</dt>
              <dd class="text-sm text-gray-500 dark:text-gray-400">
                {{ public_feedback.message ?? '-' }}
              </dd>
            </dl>
          </div>
        </div>
      </div>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Tutup </DefaultButton>
    </div>
  </div>
</template>
