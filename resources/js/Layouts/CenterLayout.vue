<script>
import { initFlowbite } from 'flowbite';

export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
        <!-- navbar -->

        <nav
            class="fixed left-0 right-0 top-0 z-50 border-b border-gray-200 bg-white px-4 py-2.5 dark:border-gray-700 dark:bg-gray-800"
        >
            <div class="flex flex-wrap items-center justify-between">
                <div class="flex items-center justify-start">
                    <Link :href="route('guardian')" class="mr-4 flex items-center justify-between">
                        <img src="/assets/icons/main-school-logo.png" class="mr-3 h-14" alt="School Logo" />
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
                        class="z-50 my-4 hidden max-w-sm list-none divide-y divide-gray-100 overflow-hidden rounded-xl bg-white text-sm shadow-lg dark:divide-gray-600 dark:bg-gray-700"
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
                            class="block bg-gray-50 px-4 py-2 text-center text-sm font-medium text-gray-700 dark:bg-gray-600 dark:text-gray-300"
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
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path
                                        d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18"
                                    />
                                    <path d="M13 8l2 0" />
                                    <path d="M13 12l2 0" />
                                </svg>
                                <div class="text-sm text-gray-900 dark:text-white">Staf</div>
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
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="mx-auto mb-1 h-7 w-7 text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-400"
                                >
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M22 9l-10 -4l-10 4l10 4l10 -4v6" />
                                    <path d="M6 10.6v5.4a6 3 0 0 0 12 0v-5.4" />
                                </svg>
                                <div class="text-sm text-gray-900 dark:text-white">Guru</div>
                            </Link>
                        </div>
                    </div>
                    <button
                        type="button"
                        class="mx-3 flex rounded-full bg-gray-800 text-sm focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600 md:mr-0"
                        id="user-menu-button"
                        aria-expanded="false"
                        data-dropdown-toggle="dropdown"
                    >
                        <span class="sr-only">Open user menu</span>
                        <img class="h-8 w-8 rounded-full" src="/assets/icons/user-circle.png" alt="user photo" />
                    </button>
                    <!-- Dropdown menu -->
                    <div
                        class="z-50 my-4 hidden w-56 list-none divide-y divide-gray-100 rounded-xl bg-white text-sm shadow dark:divide-gray-600 dark:bg-gray-700"
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
                            <span class="block text-sm font-semibold text-gray-900 dark:text-white">{{
                                $page.props.auth.user.name
                            }}</span>
                            <span class="block truncate text-sm text-gray-900 dark:text-white">{{
                                $page.props.auth.user.email
                            }}</span>
                        </div>
                        <ul class="py-1 text-gray-700 dark:text-gray-300" aria-labelledby="dropdown">
                            <li>
                                <Link
                                    href="#"
                                    class="block px-4 py-2 text-sm hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                    >Pengaturan Akun</Link
                                >
                            </li>
                        </ul>
                        <ul class="py-1 text-gray-700 dark:text-gray-300" aria-labelledby="dropdown">
                            <li>
                                <Link
                                    :href="route('portal')"
                                    class="block px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                    >Keluar Portal</Link
                                >
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- main -->

        <main class="mx-auto h-auto max-w-3xl p-4 pt-28">
            <slot name="content" />
        </main>
    </div>
</template>
