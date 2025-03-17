<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { initFlowbite } from 'flowbite';
import { computed, onMounted } from 'vue';
import { format, isSameDay, parseISO } from 'date-fns';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import PreviewContent from '@/Components/PreviewContent.vue';

const props = defineProps({
  canLogin: Boolean,
  canRegister: Boolean,
  event: Object,
  more_events: Object,
});

onMounted(() => {
  initFlowbite();
});

const formattedDate = computed(() => {
  if (!props.event || !props.event.data) return '';

  const start = parseISO(props.event.data.start_datetime);
  const end = parseISO(props.event.data.end_datetime);

  if (isSameDay(start, end)) {
    return `${format(start, 'EEEE')}, ${format(start, 'HH:mm')} - ${format(end, 'HH:mm')}`;
  } else {
    return `${format(start, 'MMM. dd yyyy HH:mm')} - ${format(end, 'MMM. dd yyyy HH:mm')}`;
  }
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <div class="min-h-screen bg-white">
      <section
        :style="{ backgroundImage: `url('${props.event?.data?.thumbnail_path || ''}')` }"
        class="relative bg-gray-400 bg-center bg-no-repeat bg-blend-multiply"
      >
        <!-- Overlay -->
        <div class="absolute inset-0 bg-black opacity-50"></div>

        <div class="relative mx-auto max-w-screen-xl px-4 py-24 text-center lg:py-56">
          <h1 class="mb-4 text-2xl font-bold leading-none tracking-tight text-white md:text-4xl lg:text-4xl">
            {{ props.event?.data?.title || 'Judul Tidak Tersedia' }}
          </h1>

          <!-- Location & Time -->
          <div class="grid grid-cols-2 justify-center gap-4 text-gray-200 sm:px-16 lg:px-48">
            <div class="flex items-center gap-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-8 w-8"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M9 11a3 3 0 1 0 6 0a3 3 0 0 0 -6 0" />
                <path d="M17.657 16.657l-4.243 4.243a2 2 0 0 1 -2.827 0l-4.244 -4.243a8 8 0 1 1 11.314 0z" />
              </svg>
              <span class="text-left text-lg">{{ props.event?.data?.location || 'Lokasi Tidak Tersedia' }}</span>
            </div>
            <div class="flex items-center gap-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-8 w-8"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M4 5m0 2a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2z" />
                <path d="M16 3l0 4" />
                <path d="M8 3l0 4" />
                <path d="M4 11l16 0" />
                <path d="M8 15h2v2h-2z" />
              </svg>
              <span class="text-left text-lg">{{ formattedDate }}</span>
            </div>
          </div>
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
                  <p>
                    <PreviewContent :content="props.event?.data?.content || ''" />
                  </p>
                </article>
              </div>
            </main>
            <aside class="bg-gray-50 py-8 dark:bg-gray-800">
              <div class="mx-auto max-w-screen-xl px-4">
                <h2 class="mb-8 text-xl font-bold text-gray-900 dark:text-white">Acara Lainnya</h2>
                <div class="grid gap-12 sm:grid-cols-2 lg:grid-cols-4">
                  <article v-for="(more_event, index) in props.more_events?.data" :key="index" class="max-w-xs">
                    <Link
                      :href="
                        route('event.detail', {
                          event_id: more_event.uuid,
                        })
                      "
                    >
                      <img :src="more_event.thumbnail_path" class="mb-5 h-32 w-full rounded-lg object-cover" />
                    </Link>
                    <h2 class="mb-2 text-lg font-semibold leading-tight text-gray-900 dark:text-white">
                      <Link
                        :href="
                          route('event.detail', {
                            event_id: more_event.uuid,
                          })
                        "
                      >
                        {{ more_event.title }}
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
