<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import PreviewContent from '@/Components/PreviewContent.vue';

export default {
  components: { PreviewContent },
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
  admission_information: {
    type: Object,
  },
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <div class="min-h-screen bg-white">
      <section class="relative flex bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
        <div class="absolute inset-0 bg-gradient-to-b from-blue-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-white dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            {{ admission_information.data.title }}
          </h1>
        </div>
      </section>
      <section>
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-5xl">
            <main class="px-4 pb-16 pt-8 antialiased dark:bg-gray-900 lg:pb-24">
              <div class="mx-auto flex justify-between px-4">
                <article
                  class="format format-sm sm:format-base lg:format-lg format-blue dark:format-invert mx-auto w-full"
                >
                  <p>
                    <PreviewContent :content="admission_information.data.content" />
                  </p>
                </article>
              </div>
            </main>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
