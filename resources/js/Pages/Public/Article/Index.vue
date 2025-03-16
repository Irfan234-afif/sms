<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import Pagination from '@/Components/Pagination.vue';

export default {
  mounted() {
    initFlowbite();
  },
};
</script>
<script setup>
import { Head, Link } from '@inertiajs/vue3';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  articles: {
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
            Artikel
          </h1>
        </div>
      </section>
      <section>
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-7xl">
            <div class="grid grid-cols-3 gap-4">
              <div
                v-for="(article, index) in articles.data"
                :key="index"
                class="flex h-full flex-col rounded-lg border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800"
              >
                <img class="h-64 rounded-t-lg object-cover" :src="article.thumbnail_path" alt="" />
                <div class="flex flex-grow flex-col p-5">
                  <h5 class="mb-2 text-lg font-medium tracking-tight text-gray-900 dark:text-white">
                    {{ article.title }}
                  </h5>
                  <div class="mt-auto w-full pt-3">
                    <div class="pb-3">
                      <Link
                        :href="
                          route('article.detail', {
                            slug: article.slug,
                          })
                        "
                        class="inline-flex items-center rounded-lg bg-blue-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                      >
                        Lihat Selengkapnya
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
                            stroke-width="2"
                            d="M1 5h12m0 0L9 1m4 4L9 9"
                          />
                        </svg>
                      </Link>
                    </div>
                    <div class="inline-flex w-full items-center border-t pt-4 text-sm text-gray-900 dark:text-white">
                      <img class="mr-4 h-10 w-10 rounded-full" :src="article.author.avatar_path" alt="Jese Leos" />
                      <div>
                        <div class="text-base font-medium text-gray-900 dark:text-white">{{ article.author.name }}</div>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                          <time>{{
                            new Date(article.published_at).toLocaleDateString('en-US', {
                              month: 'short',
                              day: '2-digit',
                              year: 'numeric',
                            })
                          }}</time>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="mt-2">
              <Pagination class="bg-white" :meta="articles.meta" :links="articles.links" />
            </div>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
