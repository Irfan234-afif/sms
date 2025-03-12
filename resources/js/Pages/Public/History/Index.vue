<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import VueMarkdownIt from 'vue3-markdown-it';

export default {
  mounted() {
    initFlowbite();
  },
};
</script>
<script setup>
import { Head } from '@inertiajs/vue3';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  page: {
    type: Object,
  },
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <div class="h-screen">
      <section class="relative flex bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
        <div class="absolute inset-0 bg-gradient-to-b from-blue-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-white dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            Sejarah
          </h1>
        </div>
      </section>
      <section>
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-2xl">
            <VueMarkdownIt :source="page.data.content"></VueMarkdownIt>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
