<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import ProfileInformation from '@/Components/ProfileInformation.vue';
const breadcrumbs = [{ label: 'Yayasan', href: route('office') }];
</script>

<script>
export default {
  props: [
    'profile',
  ]
}
</script>

<template>
  <Head title="My Profile" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <h1 class="mb-4 text-base font-medium text-gray-900 dark:text-white md:mb-6">Selamat datang</h1>
          <div
            class="grid grid-cols-2 gap-6 border-b border-t border-gray-200 py-4 text-xs dark:border-gray-700 md:py-8 lg:grid-cols-4 xl:gap-16"
          >
            <div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="mb-2 h-7 w-7 text-gray-400 dark:text-gray-500"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M12 16v.01" />
                <path d="M12 13a2 2 0 0 0 .914 -3.782a1.98 1.98 0 0 0 -2.414 .483" />
                <path d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969" />
                <path d="M14 3.223a9.003 9.003 0 0 1 0 17.554" />
                <path d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592" />
                <path d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305" />
                <path d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356" />
              </svg>
              <h6 class="mb-2 text-xs text-gray-500 dark:text-gray-400">Permintaan diproses</h6>
              <span class="flex items-center text-base font-medium text-gray-900 dark:text-white">24 </span>
              <p class="mt-2 flex items-center text-xs text-gray-500 dark:text-gray-400 sm:text-xs">
                <svg
                  class="me-1.5 h-4 w-4 text-gray-500 dark:text-gray-400"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="M10 11h2v5m-2 0h4m-2.592-8.5h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                  />
                </svg>
                -
              </p>
            </div>
            <div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="mb-2 h-7 w-7 text-gray-400 dark:text-gray-500"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969" />
                <path d="M14 3.223a9.003 9.003 0 0 1 0 17.554" />
                <path d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592" />
                <path d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305" />
                <path d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356" />
                <path d="M9 12l2 2l4 -4" />
              </svg>
              <h6 class="mb-2 text-xs text-gray-500 dark:text-gray-400">Permintaan disetujui</h6>
              <span class="flex items-center text-base font-medium text-gray-900 dark:text-white">16 </span>
              <p class="mt-2 flex items-center text-xs text-gray-500 dark:text-gray-400 sm:text-xs">
                <svg
                  class="me-1.5 h-4 w-4 text-gray-500 dark:text-gray-400"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="M10 11h2v5m-2 0h4m-2.592-8.5h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                  />
                </svg>
                -
              </p>
            </div>
            <div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="mb-2 h-7 w-7 text-gray-400 dark:text-gray-500"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969" />
                <path d="M14 3.223a9.003 9.003 0 0 1 0 17.554" />
                <path d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592" />
                <path d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305" />
                <path d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356" />
                <path d="M14 14l-4 -4" />
                <path d="M10 14l4 -4" />
              </svg>
              <h6 class="mb-2 text-xs text-gray-500 dark:text-gray-400">Permintaan ditolak</h6>
              <span class="flex items-center text-base font-medium text-gray-900 dark:text-white">8 </span>
              <p class="mt-2 flex items-center text-xs text-gray-500 dark:text-gray-400 sm:text-xs">
                <svg
                  class="me-1.5 h-4 w-4 text-gray-500 dark:text-gray-400"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="M10 11h2v5m-2 0h4m-2.592-8.5h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                  />
                </svg>
                -
              </p>
            </div>
          </div>
          <div class="pt-4 md:pt-8">
            <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <div class="flex items-center space-x-4">
                    <img
                      v-if="$page.props.auth.user.profile.avatar_path"
                      :src="$page.props.auth.user.profile.avatar_path"
                      class="h-20 w-20 rounded-lg object-cover"
                    />
                    <div v-else class="flex h-20 w-20 items-center justify-center rounded-lg bg-gray-100">
                      <svg
                        class="h-14 w-14 text-gray-500"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        viewBox="0 0 24 24"
                      >
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                        <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                      </svg>
                    </div>
                    <div>
                      <h2 class="text-base font-medium text-gray-900 dark:text-white">
                        {{ $page.props.auth.user.profile.name ?? '-' }}
                      </h2>
                      <p class="text-xs text-gray-500 dark:text-gray-400">
                        {{ $page.props.auth.user.email ?? '-' }}
                      </p>
                    </div>
                  </div>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.birth_place ?? '-' }},
                      {{ $page.props.auth.user.profile.birth_date ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Jenis Kelamin</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.gender ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.religion ?? '-' }}
                    </dd>
                  </dl>
                </div>
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.phone ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.address ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Kode Pos</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ $page.props.auth.user.profile.postal_code ?? '-' }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <hr>
      <ProfileInformation :profile="profile"/>
    </template>
  </OfficeLayout>
</template>
