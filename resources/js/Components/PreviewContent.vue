<script>
export default {
  props: {
    content: String,
  },
};
</script>

<template>
  <div v-html="content" />
</template>
