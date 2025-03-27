<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
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
      submission_approvals: this.propertyModal.data.approvals,
    };
  },
  created() {},
  methods: {
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
    <div class="mx-3 px-2">
      <ol class="relative border-s border-gray-200 text-gray-500 dark:border-gray-700 dark:text-gray-400">
        <li v-for="(submission_approval, index) in submission_approvals" :key="index" class="mb-10 ms-6">
          <span
            class="absolute -start-4 flex h-8 w-8 items-center justify-center rounded-full ring-4 ring-white dark:ring-gray-900"
            :class="{
              'bg-green-200 dark:bg-green-900': submission_approval.status === 'APPROVED',
              'bg-yellow-200 dark:bg-yellow-900': submission_approval.status === 'PENDING',
              'bg-red-200 dark:bg-red-900': submission_approval.status === 'REJECTED',
            }"
          >
            <svg
              class="h-3.5 w-3.5"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 16 12"
              :class="{
                'text-green-500 dark:text-green-400': submission_approval.status === 'APPROVED',
                'text-yellow-500 dark:text-yellow-400': submission_approval.status === 'PENDING',
                'text-red-500 dark:text-red-400': submission_approval.status === 'REJECTED',
              }"
            >
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M1 5.917 5.724 10.5 15 1.5"
              />
            </svg>
          </span>
          <figure>
            <figcaption class="m-2 flex items-center">
              <img class="mb-auto h-8 w-8 rounded-full" :src="submission_approval.approver.profile.avatar_path" />
              <div class="ms-3 space-y-0.5 text-left text-sm font-medium text-gray-800 dark:text-white rtl:text-right">
                <div>{{ submission_approval.approver.profile.name }}</div>
                <div class="text-xs text-gray-700 dark:text-gray-400">
                  {{ submission_approval.approver.identity_number }}
                </div>
                <div v-if="submission_approval.is_delegated" class="text-xs text-blue-500 dark:text-blue-400">
                  (Diwakilkan Oleh: {{ submission_approval.delegate.profile.name }})
                </div>
                <div class="text-xs text-gray-500 dark:text-gray-400">
                  {{ new Date(submission_approval.datetime).toLocaleString() }}
                </div>
                <div
                  class="text-xs font-medium"
                  :class="{
                    'text-green-600 dark:text-green-400': submission_approval.status === 'APPROVED',
                    'text-yellow-600 dark:text-yellow-400': submission_approval.status === 'PENDING',
                    'text-red-600 dark:text-red-400': submission_approval.status === 'REJECTED',
                  }"
                >
                  {{ submission_approval.status_label }}
                </div>
              </div>
            </figcaption>
          </figure>
        </li>
      </ol>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close"> Tutup </DefaultButton>
    </div>
  </div>
</template>
