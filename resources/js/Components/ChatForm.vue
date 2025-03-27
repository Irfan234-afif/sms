<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import moment from 'moment';
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
      chats: [],
      user: this.propertyModal.data.user,
      form: {
        model_id: this.propertyModal.data.model_id,
        model_type: this.propertyModal.data.model_type,
        message: null,
        sent_at: null,
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
  created() {
    this.getChats();
  },
  methods: {
    getChats() {
      axios
        .get(
          route('ajax.chat.getChats', {
            model_id: this.form.model_id,
            model_type: this.form.model_type,
          }),
        )
        .then((response) => {
          this.chats = [];
          let chats = response.data;
          if (chats && chats.length > 0) {
            this.chats = chats;
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    submit() {
      if (this.form.message != null && this.form.message !== '') {
        this.process = true;
        let requestPayload = JSON.parse(JSON.stringify(this.form));

        requestPayload.sent_at = moment().format('YYYY-MM-DD HH:mm:ss');

        axios
          .post(route('ajax.chat.sendChat'), requestPayload, {
            headers: { 'Content-Type': 'application/json' },
          })
          .then((response) => {
            if (response.data.status === 'success') {
              this.form.message = null;
              this.getChats();
            } else {
              ElNotification({
                title: 'Error',
                message: response.data.message,
                type: 'error',
              });
            }
          })
          .catch(() => {
            ElNotification({
              title: 'Error',
              message: 'Terjadi kesalahan',
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
    <form>
      <div class="w-full rounded-lg border border-gray-200 bg-gray-50 dark:border-gray-600 dark:bg-gray-700">
        <div class="m-4 space-y-3">
          <template v-for="(chat, index) in chats" :key="index">
            <div v-if="chat.sender_id == user.id" class="flex items-start justify-end gap-2.5">
              <div
                class="leading-1.5 flex max-w-[420px] flex-col rounded-s-xl rounded-ee-xl border-gray-200 bg-blue-100 p-4 dark:bg-blue-700"
              >
                <div class="flex items-center space-x-2 rtl:space-x-reverse">
                  <span class="text-sm font-semibold text-gray-900 dark:text-white">Anda</span>
                  <span class="text-sm font-normal text-gray-500 dark:text-gray-400">{{ chat.sent_at ?? '-' }}</span>
                </div>
                <p class="py-2.5 text-xs font-normal text-gray-900 dark:text-white">
                  {{ chat.message }}
                </p>
              </div>
              <img class="h-10 w-10 rounded-full" src="/assets/icons/user-circle.png" alt="avatar" />
            </div>
            <div v-else class="flex items-start gap-2.5">
              <img class="h-10 w-10 rounded-full" src="/assets/icons/user-circle.png" alt="avatar" />
              <div
                class="leading-1.5 flex max-w-[420px] flex-col rounded-e-xl rounded-es-xl border-yellow-200 bg-yellow-100 p-4 dark:bg-yellow-700"
              >
                <div class="flex items-center space-x-2 rtl:space-x-reverse">
                  <span class="text-sm font-semibold text-gray-900 dark:text-white"> {{ chat.sender.name }} </span>
                  <span class="text-sm font-normal text-gray-500 dark:text-gray-400">{{ chat.sent_at ?? '-' }}</span>
                </div>
                <p class="py-2.5 text-xs font-normal text-gray-900 dark:text-white">
                  {{ chat.message }}
                </p>
              </div>
            </div>
          </template>
        </div>
        <div class="bg-white p-1 dark:bg-gray-800">
          <el-input
            v-on:keyup.enter="submit"
            :rows="5"
            placeholder="Tulis pesan disini..."
            type="textarea"
            v-model="form.message"
          ></el-input>
        </div>
        <div class="flex items-center justify-end space-x-3 border-t border-gray-200 px-3 py-2 dark:border-gray-600">
          <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
          <DefaultButton type="default" @click="submit" :disabled="process"> Kirim Pesan </DefaultButton>
        </div>
      </div>
    </form>
  </div>
</template>
