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
      process: false,
      fileSrc: this.propertyModal.data.fileSrc,
    };
  },
  watch: {
    //
  },
  methods: {
    close() {
      this.$emit('close');
    },
  },
};
</script>
<template>
  <div class="space-y-6 p-5 text-center">
    <iframe :src="fileSrc" width="100%" height="1000px"></iframe>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process">Tutup </DefaultButton>
    </div>
  </div>
</template>
