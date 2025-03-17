<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';

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
  faqs: {
    type: Object,
  },
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <div class="min-h-screen">
      <section class="relative flex bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
        <div class="absolute inset-0 bg-gradient-to-b from-blue-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-white dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            FAQ
          </h1>
        </div>
      </section>
      <section>
        <div class="mx-auto max-w-7xl">
          <div class="mx-auto max-w-5xl">
            <section class="">
              <div class="mx-auto px-4 py-8 sm:py-16 lg:px-6">
                <h2 class="mb-8 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white">
                  Frequently asked questions
                </h2>
                <div class="border-t border-gray-200 pt-8 text-left dark:border-gray-700">
                  <div class="grid grid-cols-1 gap-16 md:grid-cols-2">
                    <div v-for="(faq, index) in faqs.data" :key="index" class="mb-10 w-full">
                      <h3 class="mb-4 flex items-center text-lg font-medium text-gray-900 dark:text-white">
                        <svg
                          class="mr-2 h-5 w-5 flex-shrink-0 text-gray-500 dark:text-gray-400"
                          fill="currentColor"
                          viewBox="0 0 20 20"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            fill-rule="evenodd"
                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z"
                            clip-rule="evenodd"
                          ></path>
                        </svg>
                        {{ faq.question }}
                      </h3>
                      <p class="text-gray-500 dark:text-gray-400">
                        {{ faq.answer }}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
