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
                        :href="route('office')"
                        class="group -mt-1 flex items-center rounded-lg bg-blue-800 px-4 py-3 text-sm font-medium text-white"
                    >
                        <span>My Profile</span>
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
                            <path
                                d="M12 21h-6a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v4.5"
                            />
                            <path d="M16 3v4" />
                            <path d="M8 3v4" />
                            <path d="M4 11h16" />
                            <path
                                d="M19 17m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0"
                            />
                            <path
                                d="M22 22a2 2 0 0 0 -2 -2h-2a2 2 0 0 0 -2 2"
                            />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap"
                            >Kehadiran</span
                        >
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
                            <path d="M8 9h8" />
                            <path d="M8 13h6" />
                            <path
                                d="M14 18h-1l-5 3v-3h-2a3 3 0 0 1 -3 -3v-8a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v4.5"
                            />
                            <path d="M19 22v.01" />
                            <path
                                d="M19 19a2.003 2.003 0 0 0 .914 -3.782a1.98 1.98 0 0 0 -2.414 .483"
                            />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap"
                            >Permintaan</span
                        >
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
                            <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                            <path
                                d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"
                            />
                            <path d="M9 17h6" />
                            <path d="M9 13h6" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap"
                            >Persetujuan</span
                        >
                        <span
                            class="text-primary-800 bg-primary-100 dark:bg-primary-200 dark:text-primary-800 inline-flex h-5 w-5 items-center justify-center rounded-full text-xs font-semibold"
                        >
                            4
                        </span>
                    </Link>
                </li>
            </ul>
            <ul
                class="mt-5 space-y-2 border-t border-gray-200 pt-5 dark:border-gray-700"
            >
                <li>
                    <Link
                        :href="route('office')"
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
                            <path d="M12 13a3 3 0 1 0 0 -6a3 3 0 0 0 0 6z" />
                            <path
                                d="M12 3c7.2 0 9 1.8 9 9s-1.8 9 -9 9s-9 -1.8 -9 -9s1.8 -9 9 -9z"
                            />
                            <path
                                d="M6 20.05v-.05a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v.05"
                            />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >My Profile</span
                        >
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
                        :href="route('office.icc')"
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
                            <path d="M21 12a9 9 0 1 0 -9 9" />
                            <path d="M3.6 9h16.8" />
                            <path d="M3.6 15h8.4" />
                            <path d="M11.578 3a17 17 0 0 0 0 18" />
                            <path d="M12.5 3c1.719 2.755 2.5 5.876 2.5 9" />
                            <path d="M18 21v-7m3 3l-3 -3l-3 3" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >ICC</span
                        >
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
                        :href="route('office.hcm')"
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
                                d="M21 11v-3c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586h-6m0 0l3 3m-3 -3l3 -3"
                            />
                            <path
                                d="M3 13.013v3c0 .53 .211 1.039 .586 1.414c.375 .375 .884 .586 1.414 .586h6m0 0l-3 -3m3 3l-3 3"
                            />
                            <path
                                d="M16 16.502c0 .53 .211 1.039 .586 1.414c.375 .375 .884 .586 1.414 .586c.53 0 1.039 -.211 1.414 -.586c.375 -.375 .586 -.884 .586 -1.414c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586c-.53 0 -1.039 .211 -1.414 .586c-.375 .375 -.586 .884 -.586 1.414z"
                            />
                            <path
                                d="M4 4.502c0 .53 .211 1.039 .586 1.414c.375 .375 .884 .586 1.414 .586c.53 0 1.039 -.211 1.414 -.586c.375 -.375 .586 -.884 .586 -1.414c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586c-.53 0 -1.039 .211 -1.414 .586c-.375 .375 -.586 .884 -.586 1.414z"
                            />
                            <path
                                d="M21 21.499c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586h-2c-.53 0 -1.039 .211 -1.414 .586c-.375 .375 -.586 .884 -.586 1.414"
                            />
                            <path
                                d="M9 9.499c0 -.53 -.211 -1.039 -.586 -1.414c-.375 -.375 -.884 -.586 -1.414 -.586h-2c-.53 0 -1.039 .211 -1.414 .586c-.375 .375 -.586 .884 -.586 1.414"
                            />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >HCM</span
                        >
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
                        :href="route('office.ga')"
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
                                d="M3 7m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v9a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z"
                            />
                            <path
                                d="M8 7v-2a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v2"
                            />
                            <path d="M12 12l0 .01" />
                            <path d="M3 13a20 20 0 0 0 18 0" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >GA</span
                        >
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
                        :href="route('office.qrd')"
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
                            <path stroke="none" d="M0 0h24v24H0z" />
                            <path
                                d="M7 9.667a2.667 2.667 0 0 1 2.667 -2.667h8.666a2.667 2.667 0 0 1 2.667 2.667v8.666a2.667 2.667 0 0 1 -2.667 2.667h-8.666a2.667 2.667 0 0 1 -2.667 -2.667z"
                            />
                            <path
                                d="M4.012 16.737a2 2 0 0 1 -1.012 -1.737v-10c0 -1.1 .9 -2 2 -2h10c.75 0 1.158 .385 1.5 1"
                            />
                            <path d="M11 14l2 2l4 -4" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >QRD</span
                        >
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
                        :href="route('office.finance')"
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
                                d="M9 14c0 1.657 2.686 3 6 3s6 -1.343 6 -3s-2.686 -3 -6 -3s-6 1.343 -6 3z"
                            />
                            <path
                                d="M9 14v4c0 1.656 2.686 3 6 3s6 -1.344 6 -3v-4"
                            />
                            <path
                                d="M3 6c0 1.072 1.144 2.062 3 2.598s4.144 .536 6 0c1.856 -.536 3 -1.526 3 -2.598c0 -1.072 -1.144 -2.062 -3 -2.598s-4.144 -.536 -6 0c-1.856 .536 -3 1.526 -3 2.598z"
                            />
                            <path d="M3 6v10c0 .888 .772 1.45 2 2" />
                            <path d="M3 11c0 .888 .772 1.45 2 2" />
                        </svg>
                        <span class="ml-3 flex-1 whitespace-nowrap text-left"
                            >Finance</span
                        >
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
        <div
            v-if="false"
            class="absolute bottom-0 left-0 z-20 hidden w-full justify-center space-x-4 bg-white p-4 dark:bg-gray-800 lg:flex"
        >
            <Link
                href="#"
                class="inline-flex cursor-pointer justify-center rounded p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
            >
                <svg
                    aria-hidden="true"
                    class="h-5 w-5"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                >
                    <path
                        d="M5 4a1 1 0 00-2 0v7.268a2 2 0 000 3.464V16a1 1 0 102 0v-1.268a2 2 0 000-3.464V4zM11 4a1 1 0 10-2 0v1.268a2 2 0 000 3.464V16a1 1 0 102 0V8.732a2 2 0 000-3.464V4zM16 3a1 1 0 011 1v7.268a2 2 0 010 3.464V16a1 1 0 11-2 0v-1.268a2 2 0 010-3.464V4a1 1 0 011-1z"
                    ></path>
                </svg>
            </Link>
            <Link
                href="#"
                data-tooltip-target="tooltip-settings"
                class="inline-flex cursor-pointer justify-center rounded p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
            >
                <svg
                    aria-hidden="true"
                    class="h-5 w-5"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                >
                    <path
                        fill-rule="evenodd"
                        d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                        clip-rule="evenodd"
                    ></path>
                </svg>
            </Link>
            <div
                id="tooltip-settings"
                role="tooltip"
                class="tooltip invisible absolute z-10 inline-block rounded-lg bg-gray-900 px-3 py-2 text-sm font-medium text-white opacity-0 shadow-sm transition-opacity duration-300"
                data-popper-placement="top"
                data-popper-reference-hidden=""
                style="
                    position: absolute;
                    inset: auto auto 0px 0px;
                    margin: 0px;
                    transform: translate3d(149.6px, -64px, 0px);
                "
            >
                Pengaturan
                <div
                    class="tooltip-arrow"
                    data-popper-arrow=""
                    style="
                        position: absolute;
                        left: 0px;
                        transform: translate3d(0px, 0px, 0px);
                    "
                ></div>
            </div>
            <button
                type="button"
                data-dropdown-toggle="language-dropdown"
                class="inline-flex cursor-pointer justify-center rounded p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
            >
                <svg
                    aria-hidden="true"
                    class="mt-0.5 h-5 w-5 rounded-full"
                    xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                    viewBox="0 0 3900 3900"
                >
                    <path fill="#b22234" d="M0 0h7410v3900H0z"></path>
                    <path
                        d="M0 450h7410m0 600H0m0 600h7410m0 600H0m0 600h7410m0 600H0"
                        stroke="#fff"
                        stroke-width="300"
                    ></path>
                    <path fill="#3c3b6e" d="M0 0h2964v2100H0z"></path>
                    <g fill="#fff">
                        <g id="d">
                            <g id="c">
                                <g id="e">
                                    <g id="b">
                                        <path
                                            id="a"
                                            d="M247 90l70.534 217.082-184.66-134.164h228.253L176.466 307.082z"
                                        ></path>
                                        <use xlink:href="#a" y="420"></use>
                                        <use xlink:href="#a" y="840"></use>
                                        <use xlink:href="#a" y="1260"></use>
                                    </g>
                                    <use xlink:href="#a" y="1680"></use>
                                </g>
                                <use xlink:href="#b" x="247" y="210"></use>
                            </g>
                            <use xlink:href="#c" x="494"></use>
                        </g>
                        <use xlink:href="#d" x="988"></use>
                        <use xlink:href="#c" x="1976"></use>
                        <use xlink:href="#e" x="2470"></use>
                    </g>
                </svg>
            </button>
            <!-- Dropdown -->
            <div
                class="z-50 my-4 hidden list-none divide-y divide-gray-100 rounded bg-white text-sm shadow dark:bg-gray-700"
                id="language-dropdown"
                data-popper-placement="bottom"
                data-popper-reference-hidden=""
                data-popper-escaped=""
                style="
                    position: absolute;
                    inset: 0px auto auto 0px;
                    margin: 0px;
                    transform: translate3d(201.6px, 890.4px, 0px);
                "
            >
                <ul class="py-1" role="none">
                    <li>
                        <Link
                            href="#"
                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                            role="menuitem"
                        >
                            <div class="inline-flex items-center">
                                <svg
                                    aria-hidden="true"
                                    class="mr-2 h-3.5 w-3.5 rounded-full"
                                    xmlns="http://www.w3.org/2000/svg"
                                    id="flag-icon-css-us"
                                    viewBox="0 0 512 512"
                                >
                                    <g fill-rule="evenodd">
                                        <g stroke-width="1pt">
                                            <path
                                                fill="#bd3d44"
                                                d="M0 0h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0z"
                                                transform="scale(3.9385)"
                                            ></path>
                                            <path
                                                fill="#fff"
                                                d="M0 10h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0zm0 20h247v10H0z"
                                                transform="scale(3.9385)"
                                            ></path>
                                        </g>
                                        <path
                                            fill="#192f5d"
                                            d="M0 0h98.8v70H0z"
                                            transform="scale(3.9385)"
                                        ></path>
                                        <path
                                            fill="#fff"
                                            d="M8.2 3l1 2.8H12L9.7 7.5l.9 2.7-2.4-1.7L6 10.2l.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8H45l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7L74 8.5l-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9L92 7.5l1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm-74.1 7l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7H65zm16.4 0l1 2.8H86l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm-74 7l.8 2.8h3l-2.4 1.7.9 2.7-2.4-1.7L6 24.2l.9-2.7-2.4-1.7h3zm16.4 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8H45l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9L92 21.5l1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm-74.1 7l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7H65zm16.4 0l1 2.8H86l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm-74 7l.8 2.8h3l-2.4 1.7.9 2.7-2.4-1.7L6 38.2l.9-2.7-2.4-1.7h3zm16.4 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8H45l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9L92 35.5l1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm-74.1 7l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7H65zm16.4 0l1 2.8H86l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm-74 7l.8 2.8h3l-2.4 1.7.9 2.7-2.4-1.7L6 52.2l.9-2.7-2.4-1.7h3zm16.4 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8H45l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9L92 49.5l1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm-74.1 7l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7H65zm16.4 0l1 2.8H86l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm-74 7l.8 2.8h3l-2.4 1.7.9 2.7-2.4-1.7L6 66.2l.9-2.7-2.4-1.7h3zm16.4 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8H45l-2.4 1.7 1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9zm16.4 0l1 2.8h2.8l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h3zm16.5 0l.9 2.8h2.9l-2.3 1.7.9 2.7-2.4-1.7-2.3 1.7.9-2.7-2.4-1.7h2.9zm16.5 0l.9 2.8h2.9L92 63.5l1 2.7-2.4-1.7-2.4 1.7 1-2.7-2.4-1.7h2.9z"
                                            transform="scale(3.9385)"
                                        ></path>
                                    </g>
                                </svg>
                                English (US)
                            </div>
                        </Link>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
