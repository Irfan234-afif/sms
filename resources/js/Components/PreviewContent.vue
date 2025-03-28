<script>
export default {
  props: {
    content: String,
  },
  computed: {},
};
</script>

<template>
  <div class="ck-content" v-html="content" />
</template>
