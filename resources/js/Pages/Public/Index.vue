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
import { Head, Link } from '@inertiajs/vue3';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  banners: {
    type: Object,
  },
  events: {
    type: Object,
  },
  news: {
    type: Object,
  },
  parent_testimonials: {
    type: Object,
  },
  student_testimonials: {
    type: Object,
  },
  teacher_testimonials: {
    type: Object,
  },
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <!-- jumbotron 1 -->
    <section class="relative flex h-screen bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
      <div class="absolute inset-0 bg-gradient-to-b from-white to-transparent"></div>
      <div class="z-10 mx-auto my-auto max-w-5xl py-24 text-center lg:py-56">
        <h1
          class="mb-4 space-y-4 text-2xl font-extrabold uppercase leading-none tracking-tight text-white md:text-3xl lg:text-4xl"
        >
          <div>Selamat Datang di</div>
          <div>Sekolah Harapan Bangsa</div>
        </h1>
        <p class="mb-8 text-base font-normal text-white sm:px-16 lg:px-48 lg:text-base">
          Menjadi sekolah terbaik dalam layanan, maksimal mencerdaskan generasi berkarakter yang menghasilkan karya
          unggul bagi Indonesia
        </p>
        <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
          <!-- direction page if need -->
        </div>
      </div>
    </section>
    <!-- carousel -->
    <section>
      <div id="default-carousel" class="relative w-full" data-carousel="slide">
        <!-- Carousel wrapper -->
        <div class="h-92 relative overflow-hidden bg-black md:h-[50rem]">
          <div
            v-for="(banner, index) in banners.data"
            :key="index"
            class="hidden duration-700 ease-in-out"
            data-carousel-item
          >
            <img
              :src="banner.image_path"
              class="absolute left-1/2 top-1/2 block w-full -translate-x-1/2 -translate-y-1/2"
              alt="..."
            />
          </div>
        </div>
        <!-- Slider indicators -->
        <div class="absolute bottom-5 left-1/2 z-30 flex -translate-x-1/2 space-x-3 rtl:space-x-reverse">
          <button
            v-for="(banner, index) in banners.data"
            :key="banner.uuid"
            type="button"
            class="h-3 w-3 rounded-full"
            aria-current="true"
            aria-label="Slide 1"
            :data-carousel-slide-to="index"
          ></button>
        </div>
        <!-- Slider controls -->
        <button
          type="button"
          class="group absolute start-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-4 focus:outline-none"
          data-carousel-prev
        >
          <span
            class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-white/30 group-hover:bg-white/50 group-focus:outline-none group-focus:ring-2 group-focus:ring-white dark:bg-gray-800/30 dark:group-hover:bg-gray-800/60 dark:group-focus:ring-gray-800/70"
          >
            <svg
              class="h-4 w-4 text-white dark:text-gray-800 rtl:rotate-180"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 6 10"
            >
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="M5 1 1 5l4 4"
              />
            </svg>
            <span class="sr-only">Previous</span>
          </span>
        </button>
        <button
          type="button"
          class="group absolute end-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-4 focus:outline-none"
          data-carousel-next
        >
          <span
            class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-white/30 group-hover:bg-white/50 group-focus:outline-none group-focus:ring-2 group-focus:ring-white dark:bg-gray-800/30 dark:group-hover:bg-gray-800/60 dark:group-focus:ring-gray-800/70"
          >
            <svg
              class="h-4 w-4 text-white dark:text-gray-800 rtl:rotate-180"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 6 10"
            >
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="m1 9 4-4-4-4"
              />
            </svg>
            <span class="sr-only">Next</span>
          </span>
        </button>
      </div>
    </section>
    <!-- sponsor -->
    <section id="sponsors" aria-label="Sponsors">
      <div class="mx-auto max-w-7xl py-8 lg:py-16">
        <div>
          <h1
            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
          >
            Rekan
          </h1>
          <div class="md:mt-18 mt-8">
            <ul
              role="list"
              class="mt-8 flex items-center justify-center gap-x-8 sm:flex-col sm:gap-x-0 sm:gap-y-10 xl:flex-row xl:gap-x-12 xl:gap-y-0"
            >
              <li>
                <ul role="list" class="flex flex-col items-center gap-y-8 sm:flex-row sm:gap-x-12 sm:gap-y-0">
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6C5ecQBg9qVpRwiHEaDP9tU3iYsIKrHqmWS5msf-kU7ApKzREqOo_WkiR-ryW_IB6tEMlzMPoUl2JpLGF71TxLbe8y6dzgXFamIUQEH7nM-e0VIaeTrVVd5fxECODfXONhyRfeT9ZJzg9/w1200-h630-p-k-no-nu/logo-flazz-gen-2.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://static.cdnlogo.com/logos/m/14/microsoft.svg"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://edge.sitecorecloud.io/zurichinsurf8c0-zwpshared-prod-d824/media/project/zurich-headless/shared/corporate/zurich-logo-blue.svg?iar=0"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Logo-ocbc.svg/1280px-Logo-ocbc.svg.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Yamaha_logo.svg/1280px-Yamaha_logo.svg.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-11 md:h-16"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjd5WP6MZLQ1009-HusSUVWTw5ndxOnlqsCLHknHgacedWFd8mTCJ9B1MhniNmpvzChRKRTxS3-ckEMv-XsS_lWYvLowSg48LpP-RcuqnVgeKDEgFlB__GeqOSMvsBv6ESQECrhfEcmLTc/s1600/Bank+Panin+Samarinda.png"
                    />
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
        <hr class="my-12" />
        <div>
          <h1
            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
          >
            Disahkan Oleh
          </h1>
          <div class="md:mt-18 mt-8">
            <ul
              role="list"
              class="mt-8 flex items-center justify-center gap-x-8 sm:flex-col sm:gap-x-0 sm:gap-y-10 xl:flex-row xl:gap-x-12 xl:gap-y-0"
            >
              <li>
                <ul role="list" class="flex flex-col items-center gap-y-8 sm:flex-row sm:gap-x-12 sm:gap-y-0">
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://seremonia.id/wp-content/uploads/2018/10/kemendikbud-logo.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://www.cem.org/hs-fs/hubfs/logos/logo-cambridge-assessment-international-education.png?width=430&name=logo-cambridge-assessment-international-education.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://fivaldicyberstudio.wordpress.com/wp-content/uploads/2022/01/logo-sekolah-penggerak-3072_945.png"
                    />
                  </li>
                  <li class="flex">
                    <img
                      loading="lazy"
                      class="h-8 md:h-11"
                      decoding="async"
                      data-nimg="1"
                      style="color: transparent"
                      src="https://png.pngtree.com/png-vector/20230615/ourmid/pngtree-a-accreditation-badge-with-gold-paddy-symbol-vector-png-image_7143730.png"
                    />
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
    <!-- news -->
    <section>
      <div class="mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-16">
        <h1
          class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
        >
          BERITA & ACARA
        </h1>
        <ol
          role="list"
          class="-mx-3 grid grid-cols-1 gap-y-10 lg:grid-cols-3 lg:text-center xl:-mx-12 xl:divide-x xl:divide-gray-400/20"
        >
          <li
            v-for="(event, index) in events.data"
            :key="index"
            class="grid auto-rows-min grid-cols-1 items-center gap-8 px-3 sm:grid-cols-2 sm:gap-y-10 lg:grid-cols-1 xl:px-12"
          >
            <div class="relative h-48 overflow-hidden rounded-2xl shadow-lg sm:h-60 lg:h-40">
              <div class="absolute inset-0 flex items-center justify-center">
                <img
                  alt=""
                  loading="lazy"
                  width="4096"
                  height="4096"
                  decoding="async"
                  data-nimg="1"
                  class="absolute inset-0 h-full w-full object-cover"
                  style="color: transparent"
                  sizes="(min-width: 1280px) 21rem, (min-width: 1024px) 33vw, (min-width: 768px) 19rem, (min-width: 640px) 50vw, 100vw"
                  :src="event.thumbnail_path"
                />
              </div>
            </div>
            <div>
              <h3 class="text-base font-medium tracking-tight text-gray-900">{{ event.title }}</h3>
            </div>
          </li>
        </ol>
        <hr class="my-12" />
        <ol
          role="list"
          class="-mx-3 grid grid-cols-1 gap-y-10 lg:grid-cols-3 lg:text-center xl:-mx-12 xl:divide-x xl:divide-gray-400/20"
        >
          <li
            v-for="(news, index) in news.data"
            :key="index"
            class="grid auto-rows-min grid-cols-1 items-center gap-8 px-3 sm:grid-cols-2 sm:gap-y-10 lg:grid-cols-1 xl:px-12"
          >
            <div class="relative h-48 overflow-hidden rounded-2xl shadow-lg sm:h-60 lg:h-40">
              <div class="absolute inset-0 flex items-center justify-center">
                <img
                  alt=""
                  loading="lazy"
                  width="4096"
                  height="4096"
                  decoding="async"
                  data-nimg="1"
                  class="absolute inset-0 h-full w-full object-cover"
                  style="color: transparent"
                  sizes="(min-width: 1280px) 21rem, (min-width: 1024px) 33vw, (min-width: 768px) 19rem, (min-width: 640px) 50vw, 100vw"
                  :src="news.thumbnail_path"
                />
              </div>
            </div>
            <div>
              <h3 class="text-base font-medium tracking-tight text-gray-900">{{ news.title }}</h3>
              <p class="mt-2 text-xs text-gray-600">
                {{ news.author.name }} • {{ new Date(news.published_at).toLocaleDateString() }}
              </p>
            </div>
          </li>
        </ol>
      </div>
    </section>
    <!-- join us -->
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
    <!-- testimonial -->
    <section id="testimonials" aria-label="Testimonials">
      <div class="mx-auto max-w-7xl py-8 lg:py-16">
        <div class="mx-auto max-w-2xl text-center">
          <h1
            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
          >
            Testimoni
          </h1>
          <p class="mt-4 text-base tracking-tight text-gray-700">
            Dipercaya oleh wali, siswa, dan pengajar. Sekolah kami mengutamakan kemudahan dan fokus pada kualitas
            pendidikan yang efektif.
          </p>
        </div>
        <h1
          class="mt-16 text-center text-lg font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-6 md:text-xl lg:mt-20 lg:text-2xl"
        >
          Orang Tua
        </h1>
        <ul role="list" class="mx-auto grid max-w-2xl grid-cols-1 gap-6 sm:gap-8 lg:max-w-none lg:grid-cols-3">
          <li v-for="(parent_testimonial, index) in parent_testimonials.data" :key="index">
            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
              <li
                :class="{
                  'mt-6': index == 1,
                }"
              >
                <figure class="relative flex h-64 flex-col rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                  <svg aria-hidden="true" width="105" height="78" class="absolute left-6 top-6 fill-gray-100">
                    <path
                      d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                    ></path>
                  </svg>
                  <blockquote class="relative">
                    <p class="text-xs tracking-tight text-gray-900">
                      {{ parent_testimonial.message }}
                    </p>
                  </blockquote>
                  <figcaption class="relative mt-auto flex items-center justify-between border-t border-gray-100 pt-6">
                    <div>
                      <div class="font-display text-xs text-gray-900">{{ parent_testimonial.name }}</div>
                      <div class="mt-1 text-xs text-gray-500">{{ parent_testimonial.relation }}</div>
                    </div>
                    <div class="overflow-hidden rounded-full bg-gray-50">
                      <img
                        alt=""
                        loading="lazy"
                        decoding="async"
                        data-nimg="1"
                        class="h-16 w-16 object-cover"
                        style="color: transparent"
                        :src="parent_testimonial.avatar_path"
                      />
                    </div>
                  </figcaption>
                </figure>
              </li>
            </ul>
          </li>
        </ul>
        <h1
          class="mt-16 text-center text-lg font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-6 md:text-xl lg:mt-20 lg:text-2xl"
        >
          Siswa
        </h1>
        <ul role="list" class="mx-auto grid max-w-2xl grid-cols-1 gap-6 sm:gap-8 lg:max-w-none lg:grid-cols-3">
          <li v-for="(student_testimonial, index) in student_testimonials.data" :key="index">
            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
              <li
                :class="{
                  'mt-6': index == 1,
                }"
              >
                <figure class="relative flex h-64 flex-col rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                  <svg aria-hidden="true" width="105" height="78" class="absolute left-6 top-6 fill-gray-100">
                    <path
                      d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                    ></path>
                  </svg>
                  <blockquote class="relative">
                    <p class="text-xs tracking-tight text-gray-900">
                      {{ student_testimonial.message }}
                    </p>
                  </blockquote>
                  <figcaption class="relative mt-auto flex items-center justify-between border-t border-gray-100 pt-6">
                    <div>
                      <div class="font-display text-xs text-gray-900">{{ student_testimonial.name }}</div>
                      <div class="mt-1 text-xs text-gray-500">{{ student_testimonial.relation }}</div>
                    </div>
                    <div class="overflow-hidden rounded-full bg-gray-50">
                      <img
                        alt=""
                        loading="lazy"
                        decoding="async"
                        data-nimg="1"
                        class="h-16 w-16 object-cover"
                        style="color: transparent"
                        :src="student_testimonial.avatar_path"
                      />
                    </div>
                  </figcaption>
                </figure>
              </li>
            </ul>
          </li>
        </ul>
        <h1
          class="mt-16 text-center text-lg font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-6 md:text-xl lg:mt-20 lg:text-2xl"
        >
          Guru
        </h1>
        <ul role="list" class="mx-auto grid max-w-2xl grid-cols-1 gap-6 sm:gap-8 lg:max-w-none lg:grid-cols-3">
          <li v-for="(teacher_testimonial, index) in teacher_testimonials.data" :key="index">
            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
              <li
                :class="{
                  'mt-6': index == 1,
                }"
              >
                <figure class="relative flex h-64 flex-col rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                  <svg aria-hidden="true" width="105" height="78" class="absolute left-6 top-6 fill-gray-100">
                    <path
                      d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                    ></path>
                  </svg>
                  <blockquote class="relative">
                    <p class="text-xs tracking-tight text-gray-900">
                      {{ teacher_testimonial.message }}
                    </p>
                  </blockquote>
                  <figcaption class="relative mt-auto flex items-center justify-between border-t border-gray-100 pt-6">
                    <div>
                      <div class="font-display text-xs text-gray-900">{{ teacher_testimonial.name }}</div>
                      <div class="mt-1 text-xs text-gray-500">{{ teacher_testimonial.relation }}</div>
                    </div>
                    <div class="overflow-hidden rounded-full bg-gray-50">
                      <img
                        alt=""
                        loading="lazy"
                        decoding="async"
                        data-nimg="1"
                        class="h-16 w-16 object-cover"
                        style="color: transparent"
                        :src="teacher_testimonial.avatar_path"
                      />
                    </div>
                  </figcaption>
                </figure>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </section>
    <!-- map -->
    <section>
      <div class="mx-auto text-center">
        <h1 class="mb-4 text-3xl font-extrabold uppercase leading-none text-blue-800 md:mb-20">Temui Kami</h1>
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d13938.371761121383!2d116.85199315044005!3d-1.2308570736880493!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2df1463c0c5dd131%3A0x67995806f12d0389!2sHarapan%20Bangsa%20Integrated%20Christian%20School!5e0!3m2!1sid!2sid!4v1598653306485!5m2!1sid!2sid"
          width="100%"
          frameborder="0"
          style="border: 0px; height: 500px"
          allowfullscreen="true"
          aria-hidden="false"
          tabindex="0"
        ></iframe>
      </div>
    </section>
  </PublicLayout>
</template>
