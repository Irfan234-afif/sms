<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<script>
export default {
  props: {
    breadcrumbs: {
      type: Array,
      required: true,
    },
  },
};
</script>
<template>
  <nav class="flex border-b px-5 py-5 text-gray-700 dark:border-gray-700 dark:bg-gray-800" aria-label="Breadcrumb">
    <ol class="inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse">
      <li v-for="(crumb, index) in breadcrumbs" :key="index" class="inline-flex items-center">
        <div class="flex items-center">
          <svg
            v-if="index !== 0"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="mx-1 h-4 w-4"
          >
            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
            <path d="M17 5l-10 14" />
          </svg>
          <Link
            v-if="index !== breadcrumbs.length - 1"
            :href="crumb.href"
            class="text-xs font-medium text-gray-700 hover:text-blue-700 dark:text-gray-400 dark:hover:text-white"
          >
            {{ crumb.label }}
          </Link>
          <span v-else class="text-xs font-medium text-gray-500 dark:text-gray-400">
            {{ crumb.label }}
          </span>
        </div>
      </li>
    </ol>
  </nav>
</template>
