<script setup>
import UploadSection from './Upload.vue';
import ListSection from './List.vue';
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
      jsonResult: [],
    };
  },
  created() {},
  methods: {
    getJsonResult(res) {
      this.jsonResult = res.jsonResult;
    },
    close() {
      this.$emit('close');
    },
  },
};
</script>
<template>
  <div>
    <UploadSection
      v-if="jsonResult.length == 0"
      :sectionTitle="propertyModal?.title"
      @success="getJsonResult"
      @close="close"
    />
    <ListSection
      v-else-if="jsonResult.length > 0"
      :sectionTitle="propertyModal?.title"
      :jsonResult="jsonResult"
      @close="close"
    />
  </div>
</template>
