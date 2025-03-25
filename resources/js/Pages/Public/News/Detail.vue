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
import { Head, Link } from '@inertiajs/vue3';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  news: {
    type: Object,
  },
  more_news: {
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
            Berita
          </h1>
        </div>
      </section>
      <section data-aos="fade-down">
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-5xl">
            <main class="px-4 pb-16 pt-8 antialiased dark:bg-gray-900 lg:pb-24">
              <div class="mx-auto flex justify-between px-4">
                <article
                  class="format format-sm sm:format-base lg:format-lg format-blue dark:format-invert mx-auto w-full"
                >
                  <header class="not-format mb-4 lg:mb-6">
                    <address class="mb-6 flex items-center not-italic">
                      <div class="mr-3 inline-flex items-center text-sm text-gray-900 dark:text-white">
                        <img class="mr-4 h-12 w-12 rounded-full" :src="news.data.author.avatar_path" alt="" />
                        <div>
                          <a href="#" rel="author" class="text-lg font-bold text-gray-900 dark:text-white">{{
                            news.data.author.name
                          }}</a>
                          <p class="text-base text-gray-500 dark:text-gray-400">
                            <time>
                              {{
                                new Date(news.data.published_at).toLocaleDateString('en-US', {
                                  month: 'short',
                                  day: '2-digit',
                                  year: 'numeric',
                                })
                              }}
                            </time>
                          </p>
                        </div>
                      </div>
                    </address>
                    <h1
                      class="mb-4 text-xl font-semibold leading-tight text-gray-900 dark:text-white lg:mb-6 lg:text-2xl"
                    >
                      {{ news.data.title }}
                    </h1>
                    <div>
                      <img class="w-full rounded-lg" :src="news.data.thumbnail_path" alt="" />
                    </div>
                  </header>
                  <p>
                    <PreviewContent :content="news.data.content" />
                  </p>
                </article>
              </div>
            </main>
            <aside class="bg-gray-50 py-8 dark:bg-gray-800">
              <div class="mx-auto max-w-screen-xl px-4">
                <h2 class="mb-8 text-xl font-bold text-gray-900 dark:text-white">Berita Lainnya</h2>
                <div class="grid gap-12 sm:grid-cols-2 lg:grid-cols-4">
                  <article v-for="(more_news, index) in more_news.data" :key="index" class="max-w-xs">
                    <Link
                      :href="
                        route('news.detail', {
                          slug: more_news.slug,
                        })
                      "
                    >
                      <img :src="more_news.thumbnail_path" class="mb-5 h-32 w-full rounded-lg object-cover" />
                    </Link>
                    <h2 class="mb-2 text-lg font-semibold leading-tight text-gray-900 dark:text-white">
                      <Link
                        :href="
                          route('news.detail', {
                            slug: more_news.slug,
                          })
                        "
                      >
                        {{ more_news.title }}
                      </Link>
                    </h2>
                  </article>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
