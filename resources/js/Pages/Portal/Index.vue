<script setup>
import PortalLayout from '@/Layouts/PortalLayout.vue';
import { Head, Link } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Portal" />

    <PortalLayout>
        <div class="flex">
            <div class="mx-auto my-auto w-full max-w-7xl sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 gap-6 overflow-hidden md:grid-cols-2">
                    <div
                        class="rounded-lg border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-800"
                    >
                        <Link :href="route('school')">
                            <h5 class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">Sekolah</h5>
                        </Link>
                        <p class="mb-3 text-base font-normal text-gray-700 dark:text-gray-400">
                            Akses untuk pengelolaan sekolah
                        </p>
                        <Link
                            :href="route('school')"
                            class="inline-flex items-center rounded-lg bg-blue-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                        >
                            Masuk
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
                    <div
                        class="rounded-lg border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-800"
                    >
                        <Link :href="route('office')">
                            <h5 class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">Yayasan</h5>
                        </Link>
                        <p class="mb-3 text-base font-normal text-gray-700 dark:text-gray-400">
                            Akses untuk pengelolaan yayasan
                        </p>
                        <Link
                            :href="route('office')"
                            class="inline-flex items-center rounded-lg bg-blue-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                        >
                            Masuk
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
                    <div
                        class="rounded-lg border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-800"
                    >
                        <Link href="#">
                            <h5 class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">Siswa</h5>
                        </Link>
                        <p class="mb-3 text-base font-normal text-gray-700 dark:text-gray-400">Akses untuk siswa</p>
                        <Link
                            href="#"
                            class="inline-flex items-center rounded-lg bg-blue-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                        >
                            Masuk
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
                    <div
                        class="rounded-lg border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-800"
                    >
                        <Link :href="route('guardian')">
                            <h5 class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">Wali</h5>
                        </Link>
                        <p class="mb-3 text-base font-normal text-gray-700 dark:text-gray-400">Akses untuk wali</p>
                        <Link
                            :href="route('guardian')"
                            class="inline-flex items-center rounded-lg bg-blue-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                        >
                            Masuk
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
                </div>
            </div>
        </div>
    </PortalLayout>
</template>
