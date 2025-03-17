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
      <section
        class="relative flex bg-[url('https://hbics.sch.id/wp-content/uploads/2021/10/Hnet.com-image-4-scaled.jpg')] bg-cover bg-fixed bg-no-repeat"
      >
        <div class="absolute inset-0 bg-gradient-to-b from-yellow-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            Mari Bergabung!
          </h1>
          <p class="mb-8 text-base font-normal text-gray-900 dark:text-gray-400 sm:px-16 lg:px-48">
            Dengan lebih dari 750 siswa dan didukung oleh lebih dari 50 guru terbaik, Sekolah Harapan Bangsa telah
            melahirkan lebih dari 500 lulusan terbaik.
          </p>
          <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
            <Link
              :href="route('register')"
              class="inline-flex items-center justify-center rounded-lg bg-blue-700 px-4 py-3 text-center text-xs font-medium text-white hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900"
            >
              Daftar Sekarang
              <svg
                class="ms-2 h-3.5 w-3.5 rtl:rotate-180"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 14 10"
              >
                <path
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                  d="M1 5h12m0 0L9 1m4 4L9 9"
                />
              </svg>
            </Link>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
