<script>
import { initFlowbite } from 'flowbite';

export default {
  mounted() {
    initFlowbite();
  },
};
</script>
<script setup>
import { Head, Link } from '@inertiajs/vue3';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
});
</script>

<template>
  <Head title="Home" />
  <div class="bg-gray-100 bg-[url('/assets/patterns/education-pattern.png')] bg-custom bg-repeat">
    <!-- header -->
    <nav class="z-50 border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-900">
      <div class="mx-auto flex max-w-screen-2xl flex-wrap items-center justify-between p-4">
        <Link href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
          <ApplicationLogo class="h-10" />
        </Link>
        <div class="flex items-center space-x-1 md:order-2 md:space-x-2 rtl:space-x-reverse">
          <Link
            v-if="$page.props.auth.user"
            :href="route('portal')"
            class="rounded-lg bg-yellow-300 px-4 py-2 text-xs font-medium text-white hover:bg-yellow-400 focus:outline-none focus:ring-4 focus:ring-yellow-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-800 md:px-5 md:py-2.5"
          >
            Portal Anggota
          </Link>
          <template v-else>
            <Link
              :href="route('login')"
              class="rounded-lg px-4 py-2 text-xs font-medium text-gray-800 hover:bg-gray-50 focus:outline-none focus:ring-4 focus:ring-gray-300 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-800 md:px-5 md:py-2.5"
            >
              Masuk</Link
            >
            <Link
              :href="route('register')"
              class="rounded-lg bg-blue-700 px-4 py-2 text-xs font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 md:px-5 md:py-2.5"
            >
              Daftar</Link
            >
          </template>
          <button
            data-collapse-toggle="navbar-multi-level"
            type="button"
            class="inline-flex h-10 w-10 items-center justify-center rounded-lg p-2 text-xs text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600 md:hidden"
            aria-controls="navbar-multi-level"
            aria-expanded="false"
          >
            <span class="sr-only">Open main menu</span>
            <svg class="h-5 w-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="M1 1h15M1 7h15M1 13h15"
              />
            </svg>
          </button>
        </div>
        <div class="hidden w-full md:block md:w-auto" id="navbar-multi-level">
          <ul
            class="mt-4 flex flex-col rounded-lg border border-gray-100 bg-gray-50 p-4 font-medium dark:border-gray-700 dark:bg-gray-800 md:mt-0 md:flex-row md:space-x-8 md:border-0 md:bg-white md:p-0 md:dark:bg-gray-900 rtl:space-x-reverse"
          >
            <li>
              <a
                href="#"
                class="block border-b border-gray-100 px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 dark:hover:text-blue-500 md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-600 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
                >Home</a
              >
            </li>
            <li>
              <button
                id="dropdownNavbarLinkSchool"
                data-dropdown-toggle="dropdownNavbarSchool"
                class="flex w-full items-center justify-between px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
              >
                Informasi Sekolah
                <svg
                  class="ms-2.5 h-2.5 w-2.5"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 10 6"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="m1 1 4 4 4-4"
                  />
                </svg>
              </button>
              <!-- Dropdown menu -->
              <div
                id="dropdownNavbarSchool"
                class="z-50 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
              >
                <ul class="py-2 text-xs text-gray-700 dark:text-gray-200" aria-labelledby="dropdownLargeButton">
                  <li>
                    <Link
                      :href="route('visionMission')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Visi & Misi</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('history')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Sejarah</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('operationalHour')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Jam Operasional</Link
                    >
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <button
                id="dropdownNavbarLinkAdmission"
                data-dropdown-toggle="dropdownNavbarAdmission"
                class="flex w-full items-center justify-between px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
              >
                Pendaftaran
                <svg
                  class="ms-2.5 h-2.5 w-2.5"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 10 6"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="m1 1 4 4 4-4"
                  />
                </svg>
              </button>
              <!-- Dropdown menu -->
              <div
                id="dropdownNavbarAdmission"
                class="z-50 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
              >
                <ul class="py-2 text-xs text-gray-700 dark:text-gray-200" aria-labelledby="dropdownLargeButton">
                  <li>
                    <Link
                      :href="route('admissionInformation')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Informasi Pendaftaran</Link
                    >
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <button
                id="dropdownNavbarLinkPublication"
                data-dropdown-toggle="dropdownNavbarPublication"
                class="flex w-full items-center justify-between px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
              >
                Publikasi
                <svg
                  class="ms-2.5 h-2.5 w-2.5"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 10 6"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="m1 1 4 4 4-4"
                  />
                </svg>
              </button>
              <!-- Dropdown menu -->
              <div
                id="dropdownNavbarPublication"
                class="z-50 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
              >
                <ul class="py-2 text-xs text-gray-700 dark:text-gray-200" aria-labelledby="dropdownLargeButton">
                  <li>
                    <Link
                      :href="route('news')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Berita</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('article')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Artikel</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('event')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Acara</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('gallery')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Galeri</Link
                    >
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <button
                id="dropdownNavbarLinkAchievement"
                data-dropdown-toggle="dropdownNavbarAchievement"
                class="flex w-full items-center justify-between px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
              >
                Pencapaian
                <svg
                  class="ms-2.5 h-2.5 w-2.5"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 10 6"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="m1 1 4 4 4-4"
                  />
                </svg>
              </button>
              <!-- Dropdown menu -->
              <div
                id="dropdownNavbarAchievement"
                class="z-50 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
              >
                <ul class="py-2 text-xs text-gray-700 dark:text-gray-200" aria-labelledby="dropdownLargeButton">
                  <li>
                    <Link
                      :href="route('teacherAchievement')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Pencapaian Guru</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('studentAchievement')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Pencapaian Siswa</Link
                    >
                  </li>
                </ul>
              </div>
            </li>
            <li>
              <button
                id="dropdownNavbarLinkContact"
                data-dropdown-toggle="dropdownNavbarContact"
                class="flex w-full items-center justify-between px-3 py-2 text-xs text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
              >
                Hubungi Kami
                <svg
                  class="ms-2.5 h-2.5 w-2.5"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 10 6"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="m1 1 4 4 4-4"
                  />
                </svg>
              </button>
              <!-- Dropdown menu -->
              <div
                id="dropdownNavbarContact"
                class="z-50 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
              >
                <ul class="py-2 text-xs text-gray-700 dark:text-gray-200" aria-labelledby="dropdownLargeButton">
                  <li>
                    <Link
                      :href="route('publicFeedback')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Masukan Saran</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('career')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >Kesempatan Karir</Link
                    >
                  </li>
                  <li>
                    <Link
                      :href="route('faq')"
                      class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                      >FAQ</Link
                    >
                  </li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- main -->
    <main class="flex-row">
      <slot />
    </main>
    <!-- footer -->
    <footer class="bg-white dark:bg-gray-900">
      <div class="mx-auto w-full max-w-screen-2xl p-4 py-6 lg:py-8">
        <div class="gap-2 md:flex md:justify-between">
          <div class="mb-6 md:mb-0">
            <Link href="#" class="flex items-center">
              <img src="/assets/icons/main-school-logo.png" class="me-3 h-12" alt="Logo" />
            </Link>
          </div>
          <div class="mb-6 mr-auto md:mb-0">
            <Link href="#" class="flex items-center">
              <img src="/assets/icons/main-foundation-logo.png" class="me-3 h-12" alt="Logo" />
            </Link>
          </div>
          <div class="grid grid-cols-2 gap-8 sm:grid-cols-3 sm:gap-6">
            <div>
              <h2 class="mb-6 text-xs font-medium uppercase text-gray-900 dark:text-white">Pendaftaran</h2>
              <ul class="text-xs font-medium text-gray-500 dark:text-gray-400">
                <li class="mb-4">
                  <Link href="#" class="hover:underline">Info Pendaftaran</Link>
                </li>
              </ul>
            </div>
            <div>
              <h2 class="mb-6 text-xs font-medium uppercase text-gray-900 dark:text-white">Ikuti Kami</h2>
              <ul class="text-xs font-medium text-gray-500 dark:text-gray-400">
                <li class="mb-4">
                  <a target="_blank" href="https://www.facebook.com/HBICS/" class="hover:underline">Facebook</a>
                </li>
                <li class="mb-4">
                  <a target="_blank" href="https://www.instagram.com/harapanbangsa_balikpapan/" class="hover:underline"
                    >Instagram</a
                  >
                </li>
                <li>
                  <a
                    target="_blank"
                    href="https://www.youtube.com/c/HappyHolyKidsHBICSBalikpapan/"
                    class="hover:underline"
                    >Youtube</a
                  >
                </li>
              </ul>
            </div>
            <div>
              <h2 class="mb-6 text-xs font-medium uppercase text-gray-900 dark:text-white">Hubungi Kami</h2>
              <ul class="text-xs font-medium text-gray-500 dark:text-gray-400">
                <li class="mb-4">
                  <Link href="#" class="hover:underline">Masukan Saran</Link>
                </li>
                <li class="mb-4">
                  <Link href="#" class="hover:underline">Karir</Link>
                </li>
                <li>
                  <Link href="#" class="hover:underline">FAQ</Link>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <hr class="my-6 border-gray-200 dark:border-gray-700 sm:mx-auto lg:my-8" />
        <div class="sm:flex sm:items-center sm:justify-between">
          <span class="text-xs text-gray-500 dark:text-gray-400 sm:text-center"
            >© {{ new Date().getFullYear() }}
            <a href="https://saffix.id/" target="_blank" class="hover:underline">saffix.id</a>. All Rights Reserved.
          </span>
          <div class="mt-4 flex sm:mt-0 sm:justify-center">
            <a
              href="https://www.facebook.com/HBICS/"
              target="_blank"
              class="text-gray-500 hover:text-gray-900 dark:hover:text-white"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
                class="h-5 w-5"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path
                  d="M18 2a1 1 0 0 1 .993 .883l.007 .117v4a1 1 0 0 1 -.883 .993l-.117 .007h-3v1h3a1 1 0 0 1 .991 1.131l-.02 .112l-1 4a1 1 0 0 1 -.858 .75l-.113 .007h-2v6a1 1 0 0 1 -.883 .993l-.117 .007h-4a1 1 0 0 1 -.993 -.883l-.007 -.117v-6h-2a1 1 0 0 1 -.993 -.883l-.007 -.117v-4a1 1 0 0 1 .883 -.993l.117 -.007h2v-1a6 6 0 0 1 5.775 -5.996l.225 -.004h3z"
                />
              </svg>
              <span class="sr-only">Facebook page</span>
            </a>
            <a
              href="https://www.instagram.com/harapanbangsa_balikpapan/"
              target="_blank"
              class="ms-5 text-gray-500 hover:text-gray-900 dark:hover:text-white"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
                class="h-5 w-5"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path
                  d="M16 3a5 5 0 0 1 5 5v8a5 5 0 0 1 -5 5h-8a5 5 0 0 1 -5 -5v-8a5 5 0 0 1 5 -5zm-4 5a4 4 0 0 0 -3.995 3.8l-.005 .2a4 4 0 1 0 4 -4m4.5 -1.5a1 1 0 0 0 -.993 .883l-.007 .127a1 1 0 0 0 1.993 .117l.007 -.127a1 1 0 0 0 -1 -1"
                />
              </svg>
              <span class="sr-only">Instagram page</span>
            </a>
            <a
              href="https://www.youtube.com/c/HappyHolyKidsHBICSBalikpapan/"
              class="ms-5 text-gray-500 hover:text-gray-900 dark:hover:text-white"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
                class="h-5 w-5"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path
                  d="M18 3a5 5 0 0 1 5 5v8a5 5 0 0 1 -5 5h-12a5 5 0 0 1 -5 -5v-8a5 5 0 0 1 5 -5zm-9 6v6a1 1 0 0 0 1.514 .857l5 -3a1 1 0 0 0 0 -1.714l-5 -3a1 1 0 0 0 -1.514 .857z"
                />
              </svg>
              <span class="sr-only">Youtube community</span>
            </a>
          </div>
        </div>
      </div>
    </footer>
    <!-- speed dial -->
    <div data-dial-init class="group fixed bottom-6 end-6 z-30">
      <div id="speed-dial-menu-default" class="mb-4 hidden flex-col items-center space-y-2">
        <a
          href="https://api.whatsapp.com/send?phone=081140001557"
          target="_blank"
          class="shadow-xs flex h-14 w-14 items-center justify-center rounded-full bg-green-600 text-white hover:bg-green-700 focus:outline-none focus:ring-4 focus:ring-green-300 dark:bg-green-600 dark:hover:bg-green-600 dark:focus:ring-green-700"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="h-7 w-7"
          >
            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
            <path d="M3 21l1.65 -3.8a9 9 0 1 1 3.4 2.9l-5.05 .9" />
            <path d="M9 10a.5 .5 0 0 0 1 0v-1a.5 .5 0 0 0 -1 0v1a5 5 0 0 0 5 5h1a.5 .5 0 0 0 0 -1h-1a.5 .5 0 0 0 0 1" />
          </svg>
          <span class="sr-only">Whatsapp</span>
        </a>
      </div>
      <button
        type="button"
        data-dial-toggle="speed-dial-menu-default"
        aria-controls="speed-dial-menu-default"
        aria-expanded="false"
        class="flex h-14 w-14 items-center justify-center rounded-full bg-blue-700 text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="1.5"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="h-7 w-7"
        >
          <path stroke="none" d="M0 0h24v24H0z" fill="none" />
          <path
            d="M21 10.663c0 -4.224 -4.041 -7.663 -9 -7.663s-9 3.439 -9 7.663c0 3.783 3.201 6.958 7.527 7.56c1.053 .239 .932 .644 .696 2.133c-.039 .238 -.184 .932 .777 .512c.96 -.42 5.18 -3.201 7.073 -5.48c1.304 -1.504 1.927 -3.029 1.927 -4.715v-.01z"
          />
        </svg>
        <span class="sr-only">Open actions menu</span>
      </button>
    </div>
  </div>
</template>
