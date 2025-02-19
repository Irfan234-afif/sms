<script>
import { initFlowbite } from 'flowbite';

export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div>
        <div class="flex min-h-screen flex-col bg-gray-100 dark:bg-gray-900">
            <!-- header -->
            <nav class="border-gray-200 bg-white dark:bg-gray-900">
                <div
                    class="mx-auto flex max-w-screen-2xl flex-wrap items-center justify-between p-4"
                >
                    <Link
                        href="/"
                        class="flex items-center space-x-3 rtl:space-x-reverse"
                    >
                        <ApplicationLogo class="h-12" />
                    </Link>
                    <div
                        class="flex items-center space-x-1 md:order-2 md:space-x-2 rtl:space-x-reverse"
                    >
                        <button
                            type="button"
                            class="flex rounded-full bg-gray-800 text-sm focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600 md:me-0"
                            id="user-menu-button"
                            aria-expanded="false"
                            data-dropdown-toggle="user-dropdown"
                            data-dropdown-placement="bottom"
                        >
                            <span class="sr-only">Open user menu</span>
                            <img
                                class="h-8 w-8 rounded-full"
                                src="/assets/icons/user-circle.png"
                                alt="user photo"
                            />
                        </button>
                        <!-- Dropdown menu -->
                        <div
                            class="z-50 my-4 hidden list-none divide-y divide-gray-100 rounded-lg bg-white text-sm shadow-sm dark:divide-gray-600 dark:bg-gray-700"
                            id="user-dropdown"
                        >
                            <div class="px-4 py-3">
                                <span
                                    class="block text-sm font-semibold text-gray-900 dark:text-white"
                                    >{{ $page.props.auth.user.name }}</span
                                >
                                <span
                                    class="block truncate text-sm text-gray-500 dark:text-gray-400"
                                    >{{ $page.props.auth.user.email }}</span
                                >
                            </div>
                            <ul class="py-2" aria-labelledby="user-menu-button">
                                <li>
                                    <Link
                                        :href="route('logout')"
                                        method="post"
                                        as="button"
                                        class="block w-full px-4 py-2 text-start text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-600 dark:hover:text-white"
                                        >Keluar</Link
                                    >
                                </li>
                            </ul>
                        </div>
                        <button
                            data-collapse-toggle="navbar-multi-level"
                            type="button"
                            class="inline-flex h-10 w-10 items-center justify-center rounded-lg p-2 text-sm text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600 md:hidden"
                            aria-controls="navbar-multi-level"
                            aria-expanded="false"
                        >
                            <span class="sr-only">Open main menu</span>
                            <svg
                                class="h-5 w-5"
                                aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 17 14"
                            >
                                <path
                                    stroke="currentColor"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M1 1h15M1 7h15M1 13h15"
                                />
                            </svg>
                        </button>
                    </div>
                    <div
                        class="hidden w-full md:block md:w-auto"
                        id="navbar-multi-level"
                    >
                        <ul
                            class="mt-4 flex flex-col rounded-lg border border-gray-100 bg-gray-50 p-4 font-medium dark:border-gray-700 dark:bg-gray-800 md:mt-0 md:flex-row md:space-x-8 md:border-0 md:bg-white md:p-0 md:dark:bg-gray-900 rtl:space-x-reverse"
                        >
                            <li>
                                <Link
                                    href="#"
                                    class="block border-b border-gray-100 px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 dark:hover:text-blue-500 md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-600 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
                                    >Home</Link
                                >
                            </li>
                            <li>
                                <button
                                    id="dropdownNavbarLinkSchool"
                                    data-dropdown-toggle="dropdownNavbarSchool"
                                    class="flex w-full items-center justify-between px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
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
                                            stroke-width="2"
                                            d="m1 1 4 4 4-4"
                                        />
                                    </svg>
                                </button>
                                <!-- Dropdown menu -->
                                <div
                                    id="dropdownNavbarSchool"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-2 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="dropdownLargeButton"
                                    >
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Visi & Misi</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Sejarah</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
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
                                    class="flex w-full items-center justify-between px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
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
                                            stroke-width="2"
                                            d="m1 1 4 4 4-4"
                                        />
                                    </svg>
                                </button>
                                <!-- Dropdown menu -->
                                <div
                                    id="dropdownNavbarAdmission"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-2 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="dropdownLargeButton"
                                    >
                                        <li>
                                            <Link
                                                href="#"
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
                                    class="flex w-full items-center justify-between px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
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
                                            stroke-width="2"
                                            d="m1 1 4 4 4-4"
                                        />
                                    </svg>
                                </button>
                                <!-- Dropdown menu -->
                                <div
                                    id="dropdownNavbarPublication"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-2 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="dropdownLargeButton"
                                    >
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Berita</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Artikel</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Acara</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Galeri</Link
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <button
                                    id="dropdownNavbarLinkAchievementTestimonial"
                                    data-dropdown-toggle="dropdownNavbarAchievementTestimonial"
                                    class="flex w-full items-center justify-between px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
                                >
                                    Pencapaian & Testimoni
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
                                            stroke-width="2"
                                            d="m1 1 4 4 4-4"
                                        />
                                    </svg>
                                </button>
                                <!-- Dropdown menu -->
                                <div
                                    id="dropdownNavbarAchievementTestimonial"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-2 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="dropdownLargeButton"
                                    >
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Pencapain Guru</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Pencapaian Siswa</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Testimoni</Link
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <button
                                    id="dropdownNavbarLinkContact"
                                    data-dropdown-toggle="dropdownNavbarContact"
                                    class="flex w-full items-center justify-between px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700 dark:focus:text-white md:w-auto md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-700 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
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
                                            stroke-width="2"
                                            d="m1 1 4 4 4-4"
                                        />
                                    </svg>
                                </button>
                                <!-- Dropdown menu -->
                                <div
                                    id="dropdownNavbarContact"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded-lg bg-white font-normal shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-2 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="dropdownLargeButton"
                                    >
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Masukan Saran</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Kesempatan Karir</Link
                                            >
                                        </li>
                                        <li>
                                            <Link
                                                href="#"
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
            <!--content -->
            <main class="my-auto">
                <slot />
            </main>
            <!-- footer -->
            <footer class="mt-auto bg-white dark:bg-gray-900">
                <div class="mx-auto w-full max-w-screen-2xl p-4 py-6 lg:py-8">
                    <div class="gap-2 md:flex md:justify-between">
                        <div class="mb-6 md:mb-0">
                            <Link href="#" class="flex items-center">
                                <img
                                    src="/assets/icons/main-school-logo.png"
                                    class="me-3 h-12"
                                    alt="Logo"
                                />
                            </Link>
                        </div>
                        <div class="mb-6 mr-auto md:mb-0">
                            <Link href="#" class="flex items-center">
                                <img
                                    src="/assets/icons/main-foundation-logo.png"
                                    class="me-3 h-12"
                                    alt="Logo"
                                />
                            </Link>
                        </div>
                        <div
                            class="grid grid-cols-2 gap-8 sm:grid-cols-3 sm:gap-6"
                        >
                            <div>
                                <h2
                                    class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white"
                                >
                                    Pendaftaran
                                </h2>
                                <ul
                                    class="text-sm font-medium text-gray-500 dark:text-gray-400"
                                >
                                    <li class="mb-4">
                                        <Link href="#" class="hover:underline"
                                            >Info Pendaftaran</Link
                                        >
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h2
                                    class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white"
                                >
                                    Ikuti Kami
                                </h2>
                                <ul
                                    class="text-sm font-medium text-gray-500 dark:text-gray-400"
                                >
                                    <li class="mb-4">
                                        <Link
                                            target="_blank"
                                            href="https://www.facebook.com/HBICS/"
                                            class="hover:underline"
                                            >Facebook</Link
                                        >
                                    </li>
                                    <li class="mb-4">
                                        <Link
                                            target="_blank"
                                            href="https://www.instagram.com/harapanbangsa_balikpapan/"
                                            class="hover:underline"
                                            >Instagram</Link
                                        >
                                    </li>
                                    <li>
                                        <Link
                                            target="_blank"
                                            href="https://www.youtube.com/c/HappyHolyKidsHBICSBalikpapan/"
                                            class="hover:underline"
                                            >Youtube</Link
                                        >
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h2
                                    class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white"
                                >
                                    Hubungi Kami
                                </h2>
                                <ul
                                    class="text-sm font-medium text-gray-500 dark:text-gray-400"
                                >
                                    <li class="mb-4">
                                        <Link href="#" class="hover:underline"
                                            >Masukan Saran</Link
                                        >
                                    </li>
                                    <li class="mb-4">
                                        <Link href="#" class="hover:underline"
                                            >Karir</Link
                                        >
                                    </li>
                                    <li>
                                        <Link href="#" class="hover:underline"
                                            >FAQ</Link
                                        >
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <hr
                        class="my-6 border-gray-200 dark:border-gray-700 sm:mx-auto lg:my-8"
                    />
                    <div class="sm:flex sm:items-center sm:justify-between">
                        <span
                            class="text-sm text-gray-500 dark:text-gray-400 sm:text-center"
                            >© {{ new Date().getFullYear() }}
                            <Link
                                href="https://saffix.id/"
                                target="_blank"
                                class="hover:underline"
                                >saffix.id</Link
                            >. All Rights Reserved.
                        </span>
                        <div class="mt-4 flex sm:mt-0 sm:justify-center">
                            <Link
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
                                    <path
                                        stroke="none"
                                        d="M0 0h24v24H0z"
                                        fill="none"
                                    />
                                    <path
                                        d="M18 2a1 1 0 0 1 .993 .883l.007 .117v4a1 1 0 0 1 -.883 .993l-.117 .007h-3v1h3a1 1 0 0 1 .991 1.131l-.02 .112l-1 4a1 1 0 0 1 -.858 .75l-.113 .007h-2v6a1 1 0 0 1 -.883 .993l-.117 .007h-4a1 1 0 0 1 -.993 -.883l-.007 -.117v-6h-2a1 1 0 0 1 -.993 -.883l-.007 -.117v-4a1 1 0 0 1 .883 -.993l.117 -.007h2v-1a6 6 0 0 1 5.775 -5.996l.225 -.004h3z"
                                    />
                                </svg>
                                <span class="sr-only">Facebook page</span>
                            </Link>
                            <Link
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
                                    <path
                                        stroke="none"
                                        d="M0 0h24v24H0z"
                                        fill="none"
                                    />
                                    <path
                                        d="M16 3a5 5 0 0 1 5 5v8a5 5 0 0 1 -5 5h-8a5 5 0 0 1 -5 -5v-8a5 5 0 0 1 5 -5zm-4 5a4 4 0 0 0 -3.995 3.8l-.005 .2a4 4 0 1 0 4 -4m4.5 -1.5a1 1 0 0 0 -.993 .883l-.007 .127a1 1 0 0 0 1.993 .117l.007 -.127a1 1 0 0 0 -1 -1"
                                    />
                                </svg>
                                <span class="sr-only">Instagram page</span>
                            </Link>
                            <Link
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
                                    <path
                                        stroke="none"
                                        d="M0 0h24v24H0z"
                                        fill="none"
                                    />
                                    <path
                                        d="M18 3a5 5 0 0 1 5 5v8a5 5 0 0 1 -5 5h-12a5 5 0 0 1 -5 -5v-8a5 5 0 0 1 5 -5zm-9 6v6a1 1 0 0 0 1.514 .857l5 -3a1 1 0 0 0 0 -1.714l-5 -3a1 1 0 0 0 -1.514 .857z"
                                    />
                                </svg>
                                <span class="sr-only">Youtube community</span>
                            </Link>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
</template>
