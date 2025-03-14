<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
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
      chats: this.propertyModal.data.chats,
      user: this.propertyModal.data.user,
      form: {
        model_id: this.propertyModal.data.model_id,
        model_type: this.propertyModal.data.model_type,
        message: null,
      },
      field: {
        message: {
          label: 'Pesan',
          rules: [],
          error: null,
        },
      },
    };
  },
  methods: {
    submit() {
      this.$refs['chatForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('office.myProfile.submission.material.save'), requestPayload, {
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
                  this.$refs['chatForm'].validateField(field);
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
      <form>
        <div class="mb-2 w-full rounded-lg border border-gray-200 bg-gray-50 dark:border-gray-600 dark:bg-gray-700">
          <div class="m-4 space-y-3">
            <template v-for="(chat, index) in chats" :key="index">
              <div v-if="chat.sender_id == user.id" class="flex items-start justify-end gap-2.5">
                <div
                  class="leading-1.5 flex max-w-[320px] flex-col rounded-s-xl rounded-ee-xl border-gray-200 bg-blue-100 p-4 dark:bg-blue-700"
                >
                  <div class="flex items-center space-x-2 rtl:space-x-reverse">
                    <span class="text-sm font-semibold text-gray-900 dark:text-white">Anda</span>
                    <span class="text-sm font-normal text-gray-500 dark:text-gray-400">{{ chat.created_at }}</span>
                  </div>
                  <p class="py-2.5 text-xs font-normal text-gray-900 dark:text-white">
                    {{ chat.message }}
                  </p>
                </div>
                <img
                  class="h-12 w-12 rounded-full"
                  src="https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png"
                  alt="You image"
                />
              </div>
              <div v-else class="flex items-start gap-2.5">
                <img
                  class="h-12 w-12 rounded-full"
                  src="https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png"
                  alt="Jese image"
                />
                <div
                  class="leading-1.5 flex max-w-[320px] flex-col rounded-e-xl rounded-es-xl border-gray-200 bg-gray-100 p-4 dark:bg-gray-700"
                >
                  <div class="flex items-center space-x-2 rtl:space-x-reverse">
                    <span class="text-sm font-semibold text-gray-900 dark:text-white"> {{ chat.sender.name }} </span>
                    <span class="text-sm font-normal text-gray-500 dark:text-gray-400">{{ chat.created_at }}</span>
                  </div>
                  <p class="py-2.5 text-xs font-normal text-gray-900 dark:text-white">
                    {{ chat.message }}
                  </p>
                </div>
              </div>
            </template>
          </div>
          <div class="bg-white px-4 py-2 dark:bg-gray-800">
            <label for="message" class="sr-only">Pesanmu</label>
            <textarea
              id="message"
              rows="3"
              class="w-full border-0 bg-white px-0 text-sm text-gray-900 focus:ring-0 dark:bg-gray-800 dark:text-white dark:placeholder-gray-400"
              placeholder="Tulis pesan..."
              required
            ></textarea>
          </div>
          <div class="flex items-center justify-between border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Kirim Pesan </DefaultButton>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>
