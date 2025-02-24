<script setup>
defineProps({
  value: {
    type: String,
  },
});
</script>

<template>
  <label class="block text-xs font-medium text-gray-800 dark:text-gray-300">
    <span v-if="value">{{ value }}</span>
    <span v-else><slot /></span>
  </label>
</template>
