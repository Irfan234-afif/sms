<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<script>
import { initFlowbite } from 'flowbite';
export default {
  mounted() {
    initFlowbite();
  },
};
</script>

<template>
  <div
    class="min-h-screen bg-gray-100 bg-[url('/assets/patterns/education-pattern.png')] bg-custom bg-repeat dark:bg-gray-900"
  >
    <!-- navbar -->
    <nav
      class="fixed left-0 right-0 top-0 z-50 border-b border-gray-200 bg-white px-4 py-2.5 dark:border-gray-700 dark:bg-gray-800"
    >
      <div class="flex flex-wrap items-center justify-between">
        <div class="flex items-center justify-start">
          <button
            data-drawer-target="drawer-navigation"
            data-drawer-toggle="drawer-navigation"
            aria-controls="drawer-navigation"
            class="mr-2 cursor-pointer rounded-lg p-2 text-gray-600 hover:bg-gray-100 hover:text-gray-900 focus:bg-gray-100 focus:ring-2 focus:ring-gray-100 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:bg-gray-700 dark:focus:ring-gray-700 md:hidden"
          >
            <svg
              aria-hidden="true"
              class="h-6 w-6"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                clip-rule="evenodd"
              ></path>
            </svg>
            <svg
              aria-hidden="true"
              class="hidden h-6 w-6"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
            <span class="sr-only">Toggle sidebar</span>
          </button>
          <Link :href="route('guardian')" class="mr-4 flex items-center justify-between">
            <img src="/assets/icons/main-school-logo.png" class="mr-3 h-10" alt="School Logo" />
          </Link>
        </div>
        <div class="flex items-center lg:order-2">
          <!-- Notifications in here -->
          <!-- Apps -->
          <button
            v-if="false"
            type="button"
            data-dropdown-toggle="apps-dropdown"
            class="rounded-lg p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 focus:ring-4 focus:ring-gray-300 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-600"
          >
            <span class="sr-only">View notifications</span>
            <!-- Icon -->
            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"
              ></path>
            </svg>
          </button>
          <!-- Dropdown menu -->
          <div
            class="z-50 my-4 hidden max-w-sm list-none divide-y divide-gray-100 overflow-hidden rounded-xl bg-white text-xs shadow-lg dark:divide-gray-600 dark:bg-gray-700"
            id="apps-dropdown"
            data-popper-placement="bottom"
            style="
              position: absolute;
              inset: 0px auto auto 0px;
              margin: 0px;
              transform: translate3d(1309.6px, 60.8px, 0px);
            "
          >
            <div
              class="block bg-gray-50 px-4 py-2 text-center text-xs font-medium text-gray-800 dark:bg-gray-600 dark:text-gray-300"
            >
              Apps
            </div>
            <div class="grid grid-cols-3 gap-4 p-4">
              <Link
                :href="route('guardian')"
                class="group block rounded-lg p-4 text-center hover:bg-gray-100 dark:hover:bg-gray-600"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400"
                >
                  <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                  <path d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18" />
                  <path d="M13 8l2 0" />
                  <path d="M13 12l2 0" />
                </svg>
                <div class="text-xs text-gray-900 dark:text-white">Staf</div>
              </Link>
              <Link
                :href="route('guardian')"
                class="group block rounded-lg p-4 text-center hover:bg-gray-100 dark:hover:bg-gray-600"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400"
                >
                  <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                  <path d="M22 9l-10 -4l-10 4l10 4l10 -4v6" />
                  <path d="M6 10.6v5.4a6 3 0 0 0 12 0v-5.4" />
                </svg>
                <div class="text-xs text-gray-900 dark:text-white">Guru</div>
              </Link>
            </div>
          </div>
          <button
            type="button"
            class="mx-3 flex rounded-full bg-gray-800 text-xs focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600 md:mr-0"
            id="user-menu-button"
            aria-expanded="false"
            data-dropdown-toggle="dropdown"
          >
            <span class="sr-only">Open user menu</span>
            <img class="h-7 w-7 rounded-full bg-white" src="/assets/icons/user-circle.png" alt="user photo" />
          </button>
          <!-- Dropdown menu -->
          <div
            class="z-50 my-4 hidden w-56 list-none divide-y divide-gray-100 rounded-xl bg-white text-xs shadow dark:divide-gray-600 dark:bg-gray-700"
            id="dropdown"
            data-popper-placement="bottom"
            style="
              position: absolute;
              inset: 0px auto auto 0px;
              margin: 0px;
              transform: translate3d(1357.6px, 56.8px, 0px);
            "
          >
            <div class="px-4 py-3">
              <span class="block text-xs font-medium text-gray-900 dark:text-white">{{
                $page.props.auth.user.name
              }}</span>
              <span class="block truncate text-xs text-gray-900 dark:text-white">{{
                $page.props.auth.user.email
              }}</span>
            </div>
            <ul class="py-1 text-gray-700 dark:text-gray-300" aria-labelledby="dropdown">
              <li>
                <Link
                  href="#"
                  class="block px-4 py-2 text-xs hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                  >Pengaturan Akun</Link
                >
              </li>
            </ul>
            <ul class="py-1 text-gray-700 dark:text-gray-300" aria-labelledby="dropdown">
              <li>
                <Link
                  :href="route('portal')"
                  class="block px-4 py-2 text-xs hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                  >Keluar Portal</Link
                >
              </li>
            </ul>
          </div>
        </div>
      </div>
    </nav>
    <!-- sidebar -->
    <aside
      class="fixed left-0 top-0 z-40 h-screen w-64 -translate-x-full border-r border-gray-200 bg-white pt-20 transition-transform dark:border-gray-700 dark:bg-gray-800 md:translate-x-0"
      aria-label="Sidenav"
      id="drawer-navigation"
      aria-hidden="true"
    >
      <slot name="sidebar" />
    </aside>
    <!-- main -->
    <main class="-mt-1 flex h-screen flex-col overflow-hidden pt-16 md:ml-64">
      <!-- main header -->
      <section class="border-gray-200 bg-white">
        <slot name="header" />
      </section>
      <!-- main content -->
      <section class="flex-1 overflow-y-auto">
        <slot name="content" />
      </section>
    </main>
  </div>
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
</template>
