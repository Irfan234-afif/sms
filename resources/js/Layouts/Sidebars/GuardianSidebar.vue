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
    <div>
        <div class="h-full overflow-y-auto bg-white px-3 py-5 dark:bg-gray-800">
            <ul class="space-y-2">
                <li>
                    <Link
                        :href="route('school')"
                        class="group -mt-1 flex items-center rounded-lg bg-blue-800 px-4 py-3 text-sm font-medium text-white"
                    >
                        <span>Wali</span>
                    </Link>
                </li>
                <li>
                    <Link
                        href="#"
                        class="group flex items-center rounded-lg p-2 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-6 w-6 flex-shrink-0 text-gray-500 transition duration-75 group-hover:text-gray-900 dark:text-gray-400 dark:group-hover:text-white"
                        >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M10 13a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                            <path d="M8 21v-1a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v1" />
                            <path d="M15 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                            <path d="M17 10h2a2 2 0 0 1 2 2v1" />
                            <path d="M5 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                            <path d="M3 13v-1a2 2 0 0 1 2 -2h2" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap">Siswa</span>
                    </Link>
                </li>
                <li>
                    <Link
                        :href="route('guardian.admissionStudent')"
                        class="group flex items-center rounded-lg p-2 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-6 w-6 flex-shrink-0 text-gray-500 transition duration-75 group-hover:text-gray-900 dark:text-gray-400 dark:group-hover:text-white"
                        >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                            <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
                            <path d="M9 17h6" />
                            <path d="M9 13h6" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap">Pendaftaran Siswa Baru</span>
                    </Link>
                </li>
                <li>
                    <Link
                        :href="route('guardian.transactionPayment')"
                        class="group flex items-center rounded-lg p-2 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-6 w-6 flex-shrink-0 text-gray-500 transition duration-75 group-hover:text-gray-900 dark:text-gray-400 dark:group-hover:text-white"
                        >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path
                                d="M21 15h-2.5c-.398 0 -.779 .158 -1.061 .439c-.281 .281 -.439 .663 -.439 1.061c0 .398 .158 .779 .439 1.061c.281 .281 .663 .439 1.061 .439h1c.398 0 .779 .158 1.061 .439c.281 .281 .439 .663 .439 1.061c0 .398 -.158 .779 -.439 1.061c-.281 .281 -.663 .439 -1.061 .439h-2.5"
                            />
                            <path d="M19 21v1m0 -8v1" />
                            <path
                                d="M13 21h-7c-.53 0 -1.039 -.211 -1.414 -.586c-.375 -.375 -.586 -.884 -.586 -1.414v-10c0 -.53 .211 -1.039 .586 -1.414c.375 -.375 .884 -.586 1.414 -.586h2m12 3.12v-1.12c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586h-2"
                            />
                            <path
                                d="M16 10v-6c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586h-4c-.53 0 -1.039 .211 -1.414 .586c-.375 .375 -.586 .884 -.586 1.414v6m8 0h-8m8 0h1m-9 0h-1"
                            />
                            <path d="M8 14v.01" />
                            <path d="M8 17v.01" />
                            <path d="M12 13.99v.01" />
                            <path d="M12 17v.01" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap">Tagihan & Pembayaran</span>
                    </Link>
                </li>
            </ul>
        </div>
    </div>
</template>
