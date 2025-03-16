<script setup>
defineProps({
  propertyModal: {
    type: Object,
  },
});
</script>
<template>
  <div class="grid grid-cols-1 gap-4 md:grid-cols-1">
    <div v-for="(item, index) in propertyModal.data.items" :key="index">
      <img class="h-auto w-full max-w-full rounded-2xl object-cover" :src="item.image_path" alt="" />
    </div>
  </div>
</template>
