<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import FinanceSidebar from '@/Layouts/Sidebars/FinanceSidebar.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Finance" />

    <OfficeLayout>
        <template #sidebar>
            <FinanceSidebar />
        </template>
        <template #content>
            <section
                class="rounded-xl bg-white p-4 antialiased dark:bg-gray-900 md:p-6"
            >
                <div class="px-4 2xl:px-0">
                    <h1
                        class="mb-4 text-lg font-semibold text-gray-900 dark:text-white md:mb-6"
                    >
                        Overview
                    </h1>
                    <div
                        class="grid grid-cols-2 gap-6 border-t border-gray-200 pt-4 text-sm dark:border-gray-700 md:pt-8 lg:grid-cols-4 xl:gap-16"
                    >
                        <div>
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                class="mb-2 h-8 w-8 text-gray-400 dark:text-gray-500"
                            >
                                <path
                                    stroke="none"
                                    d="M0 0h24v24H0z"
                                    fill="none"
                                />
                                <path d="M12 16v.01" />
                                <path
                                    d="M12 13a2 2 0 0 0 .914 -3.782a1.98 1.98 0 0 0 -2.414 .483"
                                />
                                <path
                                    d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969"
                                />
                                <path
                                    d="M14 3.223a9.003 9.003 0 0 1 0 17.554"
                                />
                                <path
                                    d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592"
                                />
                                <path
                                    d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305"
                                />
                                <path
                                    d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356"
                                />
                            </svg>
                            <h6
                                class="mb-2 text-sm text-gray-500 dark:text-gray-400"
                            >
                                Permintaan diproses
                            </h6>
                            <span
                                class="flex items-center text-lg font-bold text-gray-900 dark:text-white"
                                >24
                            </span>
                            <p
                                class="mt-2 flex items-center text-sm text-gray-500 dark:text-gray-400 sm:text-sm"
                            >
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
                                        stroke-width="2"
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
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                class="mb-2 h-8 w-8 text-gray-400 dark:text-gray-500"
                            >
                                <path
                                    stroke="none"
                                    d="M0 0h24v24H0z"
                                    fill="none"
                                />
                                <path
                                    d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969"
                                />
                                <path
                                    d="M14 3.223a9.003 9.003 0 0 1 0 17.554"
                                />
                                <path
                                    d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592"
                                />
                                <path
                                    d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305"
                                />
                                <path
                                    d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356"
                                />
                                <path d="M9 12l2 2l4 -4" />
                            </svg>
                            <h6
                                class="mb-2 text-sm text-gray-500 dark:text-gray-400"
                            >
                                Permintaan disetujui
                            </h6>
                            <span
                                class="flex items-center text-lg font-bold text-gray-900 dark:text-white"
                                >16
                            </span>
                            <p
                                class="mt-2 flex items-center text-sm text-gray-500 dark:text-gray-400 sm:text-sm"
                            >
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
                                        stroke-width="2"
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
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                class="mb-2 h-8 w-8 text-gray-400 dark:text-gray-500"
                            >
                                <path
                                    stroke="none"
                                    d="M0 0h24v24H0z"
                                    fill="none"
                                />
                                <path
                                    d="M10 20.777a8.942 8.942 0 0 1 -2.48 -.969"
                                />
                                <path
                                    d="M14 3.223a9.003 9.003 0 0 1 0 17.554"
                                />
                                <path
                                    d="M4.579 17.093a8.961 8.961 0 0 1 -1.227 -2.592"
                                />
                                <path
                                    d="M3.124 10.5c.16 -.95 .468 -1.85 .9 -2.675l.169 -.305"
                                />
                                <path
                                    d="M6.907 4.579a8.954 8.954 0 0 1 3.093 -1.356"
                                />
                                <path d="M14 14l-4 -4" />
                                <path d="M10 14l4 -4" />
                            </svg>
                            <h6
                                class="mb-2 text-sm text-gray-500 dark:text-gray-400"
                            >
                                Permintaan ditolak
                            </h6>
                            <span
                                class="flex items-center text-lg font-bold text-gray-900 dark:text-white"
                                >8
                            </span>
                            <p
                                class="mt-2 flex items-center text-sm text-gray-500 dark:text-gray-400 sm:text-sm"
                            >
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
                                        stroke-width="2"
                                        d="M10 11h2v5m-2 0h4m-2.592-8.5h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                                -
                            </p>
                        </div>
                    </div>
                </div>
            </section>
        </template>
    </OfficeLayout>
</template>
