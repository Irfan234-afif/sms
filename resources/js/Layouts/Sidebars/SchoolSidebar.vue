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
                        <span>Sekolah</span>
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
                            <path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" />
                            <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                            <path d="M21 21v-2a4 4 0 0 0 -3 -3.85" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap">Staf & Guru</span>
                    </Link>
                </li>
                <li>
                    <Link
                        :href="route('school.student')"
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
                    <button
                        type="button"
                        class="group flex w-full items-center rounded-lg p-2 text-sm font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                        aria-controls="dropdown-activity"
                        data-collapse-toggle="dropdown-activity"
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
                                d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18"
                            />
                            <path d="M13 8l2 0" />
                            <path d="M13 12l2 0" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left">Aktifitas</span>
                        <svg
                            aria-hidden="true"
                            class="h-5 w-5"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                    </button>
                    <ul id="dropdown-activity" class="hidden space-y-2 py-2">
                        <li>
                            <Link
                                :href="route('school.activity.admissionStudent')"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Pendaftaran Siswa Baru</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Kegiatan Belajar Mengajar</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Rapor Siswa Sekolah</Link
                            >
                        </li>
                    </ul>
                </li>
                <li>
                    <button
                        type="button"
                        class="group flex w-full items-center rounded-lg p-2 text-sm font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                        aria-controls="dropdown-management"
                        data-collapse-toggle="dropdown-management"
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
                            <path d="M3 4m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v0a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z" />
                            <path d="M5 8v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-10" />
                            <path d="M10 12l4 0" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left">Pengelolaan</span>
                        <svg
                            aria-hidden="true"
                            class="h-5 w-5"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                    </button>
                    <ul id="dropdown-management" class="hidden space-y-2 py-2">
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Tahun Ajaran</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Kurikulum</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Grup Mata Pelajaran</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Mata Pelajaran</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Ruang Kelas</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Ekstrakurikuler</Link
                            >
                        </li>
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Klub</Link
                            >
                        </li>
                    </ul>
                </li>
                <li>
                    <button
                        type="button"
                        class="group flex w-full items-center rounded-lg p-2 text-sm font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                        aria-controls="dropdown-setting"
                        data-collapse-toggle="dropdown-setting"
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
                                d="M12.003 21c-.732 .001 -1.465 -.438 -1.678 -1.317a1.724 1.724 0 0 0 -2.573 -1.066c-1.543 .94 -3.31 -.826 -2.37 -2.37a1.724 1.724 0 0 0 -1.065 -2.572c-1.756 -.426 -1.756 -2.924 0 -3.35a1.724 1.724 0 0 0 1.066 -2.573c-.94 -1.543 .826 -3.31 2.37 -2.37c1 .608 2.296 .07 2.572 -1.065c.426 -1.756 2.924 -1.756 3.35 0a1.724 1.724 0 0 0 2.573 1.066c1.543 -.94 3.31 .826 2.37 2.37a1.724 1.724 0 0 0 1.065 2.572c.886 .215 1.325 .957 1.318 1.694"
                            />
                            <path d="M9 12a3 3 0 1 0 6 0a3 3 0 0 0 -6 0" />
                            <path d="M19.001 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" />
                            <path d="M19.001 15.5v1.5" />
                            <path d="M19.001 21v1.5" />
                            <path d="M22.032 17.25l-1.299 .75" />
                            <path d="M17.27 20l-1.3 .75" />
                            <path d="M15.97 17.25l1.3 .75" />
                            <path d="M20.733 20l1.3 .75" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left">Pengaturan</span>
                        <svg
                            aria-hidden="true"
                            class="h-5 w-5"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                    </button>
                    <ul id="dropdown-setting" class="hidden space-y-2 py-2">
                        <li>
                            <Link
                                href="#"
                                class="group flex w-full items-center rounded-lg p-2 pl-11 text-sm font-medium text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
                                >Sekolah</Link
                            >
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="mt-5 space-y-2 border-t border-gray-200 pt-5 dark:border-gray-700">
                <li>
                    <Link
                        :href="route('school')"
                        class="group flex items-center rounded-lg p-2 text-sm font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
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
                                d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18"
                            />
                            <path d="M13 8l2 0" />
                            <path d="M13 12l2 0" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left">Staf</span>
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-5 w-5"
                        >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M17 7l-10 10" />
                            <path d="M8 7l9 0l0 9" />
                        </svg>
                    </Link>
                </li>
                <li>
                    <Link
                        :href="route('school')"
                        class="group flex items-center rounded-lg p-2 text-sm font-medium text-gray-900 transition duration-75 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700"
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
                            <path d="M22 9l-10 -4l-10 4l10 4l10 -4v6" />
                            <path d="M6 10.6v5.4a6 3 0 0 0 12 0v-5.4" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left">Guru</span>
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-5 w-5"
                        >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M17 7l-10 10" />
                            <path d="M8 7l9 0l0 9" />
                        </svg>
                    </Link>
                </li>
            </ul>
        </div>
    </div>
</template>
