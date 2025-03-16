<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';

export default {
  mounted() {
    initFlowbite();
  },
  methods: {
    getLabelDay(day) {
      switch (day) {
        case 'SUNDAY':
          return 'Minggu';
        case 'MONDAY':
          return 'Senin';
        case 'TUESDAY':
          return 'Selasa';
        case 'WEDNESDAY':
          return 'Rabu';
        case 'THURSDAY':
          return 'Kamis';
        case 'FRIDAY':
          return 'Jumat';
        case 'SATURDAY':
          return 'Sabtu';
        default:
          return '';
      }
    },
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
  operational_hours: {
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
            Jam Operational
          </h1>
        </div>
      </section>
      <section>
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-2xl">
            <ol class="relative border-s border-gray-200 dark:border-gray-700">
              <li class="mb-8 ms-4" v-for="(areas, day, index) in operational_hours" :key="index">
                <time class="mb-1 text-sm font-normal leading-none text-gray-400 dark:text-gray-500">{{
                  getLabelDay(day)
                }}</time>
                <div v-for="(area, subIndex) in areas" :key="`${index}-${subIndex}`" class="mb-3">
                  <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                    {{ area.area.name }}
                  </h3>
                  <p class="text-sm font-normal text-gray-500 dark:text-gray-400">
                    {{ area.open_time }} > {{ area.closed_time }}
                  </p>
                </div>
              </li>
            </ol>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
