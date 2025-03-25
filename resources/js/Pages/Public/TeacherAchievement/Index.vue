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
  achievements: {
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
            Pencapaian Guru
          </h1>
        </div>
      </section>
      <section data-aos="fade-down">
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-4xl">
            <div
              class="w-full rounded-lg border border-gray-200 bg-white px-6 py-4 shadow-sm dark:border-gray-700 dark:bg-gray-800"
            >
              <div class="flow-root">
                <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                  <li v-for="(achievement, index) in achievements.data" :key="index" class="py-3 sm:py-4">
                    <div class="flex items-center">
                      <div class="shrink-0 rounded-full bg-yellow-100 p-2 text-yellow-600">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          stroke-width="1.5"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          class="h-8 w-8 rounded-full"
                        >
                          <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                          <path
                            d="M6.436 8a8.6 8.6 0 0 0 -.436 2.727c0 4.017 2.686 7.273 6 7.273s6 -3.256 6 -7.273a8.6 8.6 0 0 0 -.436 -2.727"
                          />
                          <path d="M14.5 21s-.682 -3 -2.5 -3s-2.5 3 -2.5 3" />
                          <path
                            d="M18.52 5.23c.292 1.666 -1.02 2.77 -1.02 2.77s-1.603 -.563 -1.895 -2.23c-.292 -1.666 1.02 -2.77 1.02 -2.77s1.603 .563 1.895 2.23"
                          />
                          <path
                            d="M21.094 12.14c-1.281 1.266 -3.016 .76 -3.016 .76s-.454 -1.772 .828 -3.04c1.28 -1.266 3.016 -.76 3.016 -.76s.454 1.772 -.828 3.04"
                          />
                          <path
                            d="M17.734 18.826c-1.5 -.575 -1.734 -2.19 -1.734 -2.19s1.267 -1.038 2.767 -.462c1.5 .575 1.733 2.19 1.733 2.19s-1.267 1.038 -2.767 .462"
                          />
                          <path
                            d="M6.267 18.826c1.5 -.575 1.733 -2.19 1.733 -2.19s-1.267 -1.038 -2.767 -.462c-1.5 .575 -1.733 2.19 -1.733 2.19s1.267 1.038 2.767 .462"
                          />
                          <path
                            d="M2.906 12.14c1.281 1.266 3.016 .76 3.016 .76s.454 -1.772 -.828 -3.04c-1.281 -1.265 -3.016 -.76 -3.016 -.76s-.454 1.772 .828 3.04"
                          />
                          <path
                            d="M5.48 5.23c-.292 1.666 1.02 2.77 1.02 2.77s1.603 -.563 1.895 -2.23c.292 -1.666 -1.02 -2.77 -1.02 -2.77s-1.603 .563 -1.895 2.23"
                          />
                        </svg>
                      </div>
                      <div class="ms-4 min-w-0 flex-1">
                        <p class="truncate text-sm font-medium text-gray-900 dark:text-white">
                          {{ achievement.title }}
                        </p>
                        <p class="truncate text-sm text-gray-500 dark:text-gray-400">
                          {{ achievement.description }}
                        </p>
                      </div>
                      <div class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white"></div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
