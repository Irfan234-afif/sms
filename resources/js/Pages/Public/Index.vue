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
    <div class="bg-white">
        <!-- header -->
        <nav class="z-50 border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-900">
            <div class="mx-auto flex max-w-screen-2xl flex-wrap items-center justify-between p-4">
                <Link href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
                    <ApplicationLogo class="h-12" />
                </Link>
                <div class="flex items-center space-x-1 md:order-2 md:space-x-2 rtl:space-x-reverse">
                    <Link
                        v-if="$page.props.auth.user"
                        :href="route('portal')"
                        class="rounded-lg bg-yellow-300 px-4 py-2 text-sm font-medium text-white hover:bg-yellow-400 focus:outline-none focus:ring-4 focus:ring-yellow-300 dark:bg-yellow-600 dark:hover:bg-yellow-700 dark:focus:ring-yellow-800 md:px-5 md:py-2.5"
                    >
                        Portal Anggota
                    </Link>
                    <template v-else>
                        <Link
                            :href="route('login')"
                            class="rounded-lg px-4 py-2 text-sm font-medium text-gray-800 hover:bg-gray-50 focus:outline-none focus:ring-4 focus:ring-gray-300 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-800 md:px-5 md:py-2.5"
                        >
                            Masuk</Link
                        >
                        <Link
                            :href="route('register')"
                            class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 md:px-5 md:py-2.5"
                        >
                            Daftar</Link
                        >
                    </template>
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
                <div class="hidden w-full md:block md:w-auto" id="navbar-multi-level">
                    <ul
                        class="mt-4 flex flex-col rounded-lg border border-gray-100 bg-gray-50 p-4 font-medium dark:border-gray-700 dark:bg-gray-800 md:mt-0 md:flex-row md:space-x-8 md:border-0 md:bg-white md:p-0 md:dark:bg-gray-900 rtl:space-x-reverse"
                    >
                        <li>
                            <a
                                href="#"
                                class="block border-b border-gray-100 px-3 py-2 text-sm text-gray-900 hover:bg-gray-100 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 dark:hover:text-blue-500 md:border-0 md:p-0 md:hover:bg-transparent md:hover:text-blue-600 md:dark:hover:bg-transparent md:dark:hover:text-blue-500"
                                >Home</a
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
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Visi & Misi</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Sejarah</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Jam Operasional</a
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
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Informasi Pendaftaran</a
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
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Berita</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Artikel</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Acara</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Galeri</a
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
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Pencapain Guru</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Pencapaian Siswa</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Testimoni</a
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
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Masukan Saran</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Kesempatan Karir</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >FAQ</a
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
            <!-- jumbotron 1 -->
            <section
                class="relative flex h-screen bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat"
            >
                <div class="absolute inset-0 bg-gradient-to-b from-white to-transparent"></div>
                <div class="z-10 mx-auto my-auto max-w-5xl py-24 text-center lg:py-56">
                    <h1
                        class="mb-4 space-y-4 text-2xl font-extrabold uppercase leading-none tracking-tight text-white md:text-3xl lg:text-4xl"
                    >
                        <div>Selamat Datang di</div>
                        <div>Sekolah Harapan Bangsa</div>
                    </h1>
                    <p class="mb-8 text-base font-normal text-white sm:px-16 lg:px-48 lg:text-lg">
                        Menjadi sekolah terbaik dalam layanan, maksimal mencerdaskan generasi berkarakter yang
                        menghasilkan karya unggul bagi Indonesia
                    </p>
                    <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
                        <!-- direction page if need -->
                    </div>
                </div>
            </section>
            <!-- carousel -->
            <section>
                <div id="default-carousel" class="relative w-full" data-carousel="slide">
                    <!-- Carousel wrapper -->
                    <div class="relative h-48 overflow-hidden bg-black md:h-[50rem]">
                        <!-- Item 1 -->
                        <div class="hidden duration-700 ease-in-out" data-carousel-item>
                            <img
                                src="/assets/pages/slider1.jpg"
                                class="absolute left-1/2 top-1/2 block w-full -translate-x-1/2 -translate-y-1/2"
                                alt="..."
                            />
                        </div>
                        <!-- Item 2 -->
                        <div class="hidden duration-700 ease-in-out" data-carousel-item>
                            <img
                                src="/assets/pages/slider2.jpg"
                                class="absolute left-1/2 top-1/2 block w-full -translate-x-1/2 -translate-y-1/2"
                                alt="..."
                            />
                        </div>
                        <!-- Item 3 -->
                        <div class="hidden duration-700 ease-in-out" data-carousel-item>
                            <img
                                src="/assets/pages/slider3.jpg"
                                class="absolute left-1/2 top-1/2 block w-full -translate-x-1/2 -translate-y-1/2"
                                alt="..."
                            />
                        </div>
                    </div>
                    <!-- Slider indicators -->
                    <div class="absolute bottom-5 left-1/2 z-30 flex -translate-x-1/2 space-x-3 rtl:space-x-reverse">
                        <button
                            type="button"
                            class="h-3 w-3 rounded-full"
                            aria-current="true"
                            aria-label="Slide 1"
                            data-carousel-slide-to="0"
                        ></button>
                        <button
                            type="button"
                            class="h-3 w-3 rounded-full"
                            aria-current="false"
                            aria-label="Slide 2"
                            data-carousel-slide-to="1"
                        ></button>
                        <button
                            type="button"
                            class="h-3 w-3 rounded-full"
                            aria-current="false"
                            aria-label="Slide 3"
                            data-carousel-slide-to="2"
                        ></button>
                    </div>
                    <!-- Slider controls -->
                    <button
                        type="button"
                        class="group absolute start-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-4 focus:outline-none"
                        data-carousel-prev
                    >
                        <span
                            class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-white/30 group-hover:bg-white/50 group-focus:outline-none group-focus:ring-2 group-focus:ring-white dark:bg-gray-800/30 dark:group-hover:bg-gray-800/60 dark:group-focus:ring-gray-800/70"
                        >
                            <svg
                                class="h-4 w-4 text-white dark:text-gray-800 rtl:rotate-180"
                                aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 6 10"
                            >
                                <path
                                    stroke="currentColor"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M5 1 1 5l4 4"
                                />
                            </svg>
                            <span class="sr-only">Previous</span>
                        </span>
                    </button>
                    <button
                        type="button"
                        class="group absolute end-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-4 focus:outline-none"
                        data-carousel-next
                    >
                        <span
                            class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-white/30 group-hover:bg-white/50 group-focus:outline-none group-focus:ring-2 group-focus:ring-white dark:bg-gray-800/30 dark:group-hover:bg-gray-800/60 dark:group-focus:ring-gray-800/70"
                        >
                            <svg
                                class="h-4 w-4 text-white dark:text-gray-800 rtl:rotate-180"
                                aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 6 10"
                            >
                                <path
                                    stroke="currentColor"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="m1 9 4-4-4-4"
                                />
                            </svg>
                            <span class="sr-only">Next</span>
                        </span>
                    </button>
                </div>
            </section>
            <!-- sponsor -->
            <section id="sponsors" aria-label="Sponsors">
                <div class="mx-auto max-w-7xl py-8 lg:py-16">
                    <div>
                        <h1
                            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
                        >
                            Rekan
                        </h1>
                        <div class="md:mt-18 mt-8">
                            <ul
                                role="list"
                                class="mt-8 flex items-center justify-center gap-x-8 sm:flex-col sm:gap-x-0 sm:gap-y-10 xl:flex-row xl:gap-x-12 xl:gap-y-0"
                            >
                                <li>
                                    <ul
                                        role="list"
                                        class="flex flex-col items-center gap-y-8 sm:flex-row sm:gap-x-12 sm:gap-y-0"
                                    >
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6C5ecQBg9qVpRwiHEaDP9tU3iYsIKrHqmWS5msf-kU7ApKzREqOo_WkiR-ryW_IB6tEMlzMPoUl2JpLGF71TxLbe8y6dzgXFamIUQEH7nM-e0VIaeTrVVd5fxECODfXONhyRfeT9ZJzg9/w1200-h630-p-k-no-nu/logo-flazz-gen-2.png"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://static.cdnlogo.com/logos/m/14/microsoft.svg"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://edge.sitecorecloud.io/zurichinsurf8c0-zwpshared-prod-d824/media/project/zurich-headless/shared/corporate/zurich-logo-blue.svg?iar=0"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Logo-ocbc.svg/1280px-Logo-ocbc.svg.png"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Yamaha_logo.svg/1280px-Yamaha_logo.svg.png"
                                            />
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <hr class="my-12" />
                    <div>
                        <h1
                            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
                        >
                            Disahkan Oleh
                        </h1>
                        <div class="md:mt-18 mt-8">
                            <ul
                                role="list"
                                class="mt-8 flex items-center justify-center gap-x-8 sm:flex-col sm:gap-x-0 sm:gap-y-10 xl:flex-row xl:gap-x-12 xl:gap-y-0"
                            >
                                <li>
                                    <ul
                                        role="list"
                                        class="flex flex-col items-center gap-y-8 sm:flex-row sm:gap-x-12 sm:gap-y-0"
                                    >
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://seremonia.id/wp-content/uploads/2018/10/kemendikbud-logo.png"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://www.cem.org/hs-fs/hubfs/logos/logo-cambridge-assessment-international-education.png?width=430&name=logo-cambridge-assessment-international-education.png"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://fivaldicyberstudio.wordpress.com/wp-content/uploads/2022/01/logo-sekolah-penggerak-3072_945.png"
                                            />
                                        </li>
                                        <li class="flex">
                                            <img
                                                loading="lazy"
                                                class="h-8 md:h-11"
                                                decoding="async"
                                                data-nimg="1"
                                                style="color: transparent"
                                                src="https://png.pngtree.com/png-vector/20230615/ourmid/pngtree-a-accreditation-badge-with-gold-paddy-symbol-vector-png-image_7143730.png"
                                            />
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>
            <!-- news -->
            <section>
                <div class="mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-16">
                    <h1
                        class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
                    >
                        BERITA & ACARA
                    </h1>
                    <ol
                        role="list"
                        class="-mx-3 grid grid-cols-1 gap-y-10 lg:grid-cols-2 lg:text-center xl:-mx-12 xl:divide-x xl:divide-gray-400/20"
                    >
                        <li
                            v-for="index in 2"
                            :key="index"
                            class="grid auto-rows-min grid-cols-1 items-center gap-8 px-3 sm:grid-cols-2 sm:gap-y-10 lg:grid-cols-1 xl:px-12"
                        >
                            <div class="relative h-48 overflow-hidden rounded-2xl shadow-lg sm:h-60 lg:h-72">
                                <div class="absolute inset-0 flex items-center justify-center">
                                    <img
                                        alt=""
                                        loading="lazy"
                                        width="4096"
                                        height="4096"
                                        decoding="async"
                                        data-nimg="1"
                                        class="absolute inset-0 h-full w-full object-cover"
                                        style="color: transparent"
                                        sizes="(min-width: 1280px) 21rem, (min-width: 1024px) 33vw, (min-width: 768px) 19rem, (min-width: 640px) 50vw, 100vw"
                                        src="https://flowbite.com/docs/images/blog/image-1.jpg"
                                    />
                                </div>
                            </div>
                            <div>
                                <h3 class="text-base font-medium tracking-tight text-gray-900">Event</h3>
                                <p class="mt-2 text-sm text-gray-600">
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolor qui ea fuga aliquam
                                    eaque odio quidem sint voluptas impedit rem amet, expedita fugit, tempora, inventore
                                    dolore praesentium quos quis in.
                                </p>
                            </div>
                        </li>
                    </ol>
                    <hr class="my-12" />
                    <ol
                        role="list"
                        class="-mx-3 grid grid-cols-1 gap-y-10 lg:grid-cols-3 lg:text-center xl:-mx-12 xl:divide-x xl:divide-gray-400/20"
                    >
                        <li
                            v-for="index in 3"
                            :key="index"
                            class="grid auto-rows-min grid-cols-1 items-center gap-8 px-3 sm:grid-cols-2 sm:gap-y-10 lg:grid-cols-1 xl:px-12"
                        >
                            <div class="relative h-48 overflow-hidden rounded-2xl shadow-lg sm:h-60 lg:h-40">
                                <div class="absolute inset-0 flex items-center justify-center">
                                    <img
                                        alt=""
                                        loading="lazy"
                                        width="4096"
                                        height="4096"
                                        decoding="async"
                                        data-nimg="1"
                                        class="absolute inset-0 h-full w-full object-cover"
                                        style="color: transparent"
                                        sizes="(min-width: 1280px) 21rem, (min-width: 1024px) 33vw, (min-width: 768px) 19rem, (min-width: 640px) 50vw, 100vw"
                                        src="https://flowbite.com/docs/images/blog/image-1.jpg"
                                    />
                                </div>
                            </div>
                            <div>
                                <h3 class="text-base font-medium tracking-tight text-gray-900">News</h3>
                                <p class="mt-2 text-sm text-gray-600">
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolor qui ea fuga aliquam
                                    eaque odio quidem sint voluptas impedit rem amet, expedita fugit, tempora, inventore
                                    dolore praesentium quos quis in.
                                </p>
                            </div>
                        </li>
                    </ol>
                </div>
            </section>
            <!-- join us -->
            <section
                class="relative flex bg-[url('https://hbics.sch.id/wp-content/uploads/2021/10/Hnet.com-image-4-scaled.jpg')] bg-cover bg-fixed bg-no-repeat"
            >
                <div class="absolute inset-0 bg-gradient-to-b from-yellow-300 to-white opacity-70"></div>
                <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
                    <h1
                        class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
                    >
                        Mari Bergabung!
                    </h1>
                    <p class="mb-8 text-base font-normal text-gray-900 dark:text-gray-400 sm:px-16 lg:px-48">
                        Dengan lebih dari 750 siswa dan didukung oleh lebih dari 50 guru terbaik, Sekolah Harapan Bangsa
                        telah melahirkan lebih dari 500 lulusan terbaik.
                    </p>
                    <div class="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0">
                        <a
                            href="#"
                            class="inline-flex items-center justify-center rounded-lg bg-blue-700 px-4 py-3 text-center text-sm font-medium text-white hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900"
                        >
                            Daftar Sekarang
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
                        </a>
                    </div>
                </div>
            </section>
            <!-- testimonial -->
            <section id="testimonials" aria-label="Testimonials">
                <div class="mx-auto max-w-7xl py-8 lg:py-16">
                    <div class="mx-auto max-w-2xl text-center">
                        <h1
                            class="mb-4 text-center text-xl font-extrabold uppercase leading-none tracking-tight text-blue-700 dark:text-white md:mb-12 md:text-2xl lg:text-3xl"
                        >
                            Testimoni
                        </h1>
                        <p class="mt-4 text-base tracking-tight text-gray-700">
                            Dipercaya oleh wali, siswa, dan pengajar. Sekolah kami mengutamakan kemudahan dan fokus pada
                            kualitas pendidikan yang efektif.
                        </p>
                    </div>
                    <ul
                        role="list"
                        class="mx-auto mt-16 grid max-w-2xl grid-cols-1 gap-6 sm:gap-8 lg:mt-20 lg:max-w-none lg:grid-cols-3"
                    >
                        <li>
                            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                TaxPal is so easy to use I can’t help but wonder if it’s really doing
                                                the things the government expects me to do.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Sheryl Berge</div>
                                                <div class="mt-1 text-sm text-gray-500">CEO at Lynch LLC</div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                I’m trying to get a hold of someone in support, I’m in a lot of trouble
                                                right now and they are saying it has something to do with my books.
                                                Please get back to me right away.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Amy Hahn</div>
                                                <div class="mt-1 text-sm text-gray-500">
                                                    Director at Velocity Industries
                                                </div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                The best part about TaxPal is every time I pay my employees, my bank
                                                balance doesn’t go down like it used to. Looking forward to spending
                                                this extra cash when I figure out why my card is being declined.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Leland Kiehn</div>
                                                <div class="mt-1 text-sm text-gray-500">Founder of Kiehn and Sons</div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                There are so many things I had to do with my old software that I just
                                                don’t do at all with TaxPal. Suspicious but I can’t say I don’t love it.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Erin Powlowski</div>
                                                <div class="mt-1 text-sm text-gray-500">COO at Armstrong Inc</div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <ul role="list" class="flex flex-col gap-y-6 sm:gap-y-8">
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                I used to have to remit tax to the EU and with TaxPal I somehow don’t
                                                have to do that anymore. Nervous to travel there now though.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Peter Renolds</div>
                                                <div class="mt-1 text-sm text-gray-500">Founder of West Inc</div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                                <li>
                                    <figure class="relative rounded-2xl bg-white p-6 shadow-xl shadow-gray-900/10">
                                        <svg
                                            aria-hidden="true"
                                            width="105"
                                            height="78"
                                            class="absolute left-6 top-6 fill-gray-100"
                                        >
                                            <path
                                                d="M25.086 77.292c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622C1.054 58.534 0 53.411 0 47.686c0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C28.325 3.917 33.599 1.507 39.324 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Zm54.24 0c-4.821 0-9.115-1.205-12.882-3.616-3.767-2.561-6.78-6.102-9.04-10.622-2.11-4.52-3.164-9.643-3.164-15.368 0-5.273.904-10.396 2.712-15.368 1.959-4.972 4.746-9.567 8.362-13.786a59.042 59.042 0 0 1 12.43-11.3C82.565 3.917 87.839 1.507 93.564 0l11.074 13.786c-6.479 2.561-11.677 5.951-15.594 10.17-3.767 4.219-5.65 7.835-5.65 10.848 0 1.356.377 2.863 1.13 4.52.904 1.507 2.637 3.089 5.198 4.746 3.767 2.41 6.328 4.972 7.684 7.684 1.507 2.561 2.26 5.5 2.26 8.814 0 5.123-1.959 9.19-5.876 12.204-3.767 3.013-8.588 4.52-14.464 4.52Z"
                                            ></path>
                                        </svg>
                                        <blockquote class="relative">
                                            <p class="text-sm tracking-tight text-gray-900">
                                                This is the fourth email I’ve sent to your support team. I am literally
                                                being held in jail for tax fraud. Please answer your damn emails, this
                                                is important.
                                            </p>
                                        </blockquote>
                                        <figcaption
                                            class="relative mt-6 flex items-center justify-between border-t border-gray-100 pt-6"
                                        >
                                            <div>
                                                <div class="font-display text-sm text-gray-900">Amy Hahn</div>
                                                <div class="mt-1 text-sm text-gray-500">
                                                    Director at Velocity Industries
                                                </div>
                                            </div>
                                            <div class="overflow-hidden rounded-full bg-gray-50">
                                                <img
                                                    alt=""
                                                    loading="lazy"
                                                    decoding="async"
                                                    data-nimg="1"
                                                    class="h-20 w-20 object-cover"
                                                    style="color: transparent"
                                                    src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/karen-nelson.png"
                                                />
                                            </div>
                                        </figcaption>
                                    </figure>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </section>
            <!-- map -->
            <section>
                <div class="mx-auto py-8 text-center lg:py-16">
                    <h1 class="mb-4 text-3xl font-extrabold uppercase leading-none text-blue-800 md:mb-20">
                        Temui Kami
                    </h1>
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d13938.371761121383!2d116.85199315044005!3d-1.2308570736880493!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2df1463c0c5dd131%3A0x67995806f12d0389!2sHarapan%20Bangsa%20Integrated%20Christian%20School!5e0!3m2!1sid!2sid!4v1598653306485!5m2!1sid!2sid"
                        width="100%"
                        frameborder="0"
                        style="border: 0px; height: 500px"
                        allowfullscreen="true"
                        aria-hidden="false"
                        tabindex="0"
                    ></iframe>
                </div>
            </section>
        </main>
        <!-- footer -->
        <footer class="bg-white dark:bg-gray-900">
            <div class="mx-auto w-full max-w-screen-2xl p-4 py-6 lg:py-8">
                <div class="gap-2 md:flex md:justify-between">
                    <div class="mb-6 md:mb-0">
                        <a href="#" class="flex items-center">
                            <img src="/assets/icons/main-school-logo.png" class="me-3 h-12" alt="Logo" />
                        </a>
                    </div>
                    <div class="mb-6 mr-auto md:mb-0">
                        <a href="#" class="flex items-center">
                            <img src="/assets/icons/main-foundation-logo.png" class="me-3 h-12" alt="Logo" />
                        </a>
                    </div>
                    <div class="grid grid-cols-2 gap-8 sm:grid-cols-3 sm:gap-6">
                        <div>
                            <h2 class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white">
                                Pendaftaran
                            </h2>
                            <ul class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                <li class="mb-4">
                                    <a href="#" class="hover:underline">Info Pendaftaran</a>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <h2 class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white">
                                Ikuti Kami
                            </h2>
                            <ul class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                <li class="mb-4">
                                    <a target="_blank" href="https://www.facebook.com/HBICS/" class="hover:underline"
                                        >Facebook</a
                                    >
                                </li>
                                <li class="mb-4">
                                    <a
                                        target="_blank"
                                        href="https://www.instagram.com/harapanbangsa_balikpapan/"
                                        class="hover:underline"
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
                            <h2 class="mb-6 text-sm font-semibold uppercase text-gray-900 dark:text-white">
                                Hubungi Kami
                            </h2>
                            <ul class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                <li class="mb-4">
                                    <a href="#" class="hover:underline">Masukan Saran</a>
                                </li>
                                <li class="mb-4">
                                    <a href="#" class="hover:underline">Karir</a>
                                </li>
                                <li>
                                    <a href="#" class="hover:underline">FAQ</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr class="my-6 border-gray-200 dark:border-gray-700 sm:mx-auto lg:my-8" />
                <div class="sm:flex sm:items-center sm:justify-between">
                    <span class="text-sm text-gray-500 dark:text-gray-400 sm:text-center"
                        >© {{ new Date().getFullYear() }}
                        <a href="https://saffix.id/" target="_blank" class="hover:underline">saffix.id</a>. All Rights
                        Reserved.
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
    </div>
</template>
