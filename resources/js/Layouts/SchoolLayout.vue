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
                    <Link
                        :href="route('school')"
                        class="mr-4 flex items-center justify-between"
                    >
                        <img
                            src="/assets/icons/main-school-logo.png"
                            class="mr-3 h-14"
                            alt="School Logo"
                        />
                    </Link>
                </div>
                <div class="flex items-center lg:order-2">
                    <!-- Notifications -->
                    <button
                        v-if="false"
                        type="button"
                        data-dropdown-toggle="notification-dropdown"
                        class="mr-1 rounded-lg p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 focus:ring-4 focus:ring-gray-300 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-600"
                    >
                        <span class="sr-only">View notifications</span>
                        <!-- Bell icon -->
                        <svg
                            aria-hidden="true"
                            class="h-6 w-6"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z"
                            ></path>
                        </svg>
                    </button>
                    <!-- Dropdown menu -->
                    <div
                        v-if="false"
                        class="z-50 my-4 hidden max-w-sm list-none divide-y divide-gray-100 overflow-hidden rounded-xl bg-white text-sm shadow-lg dark:divide-gray-600 dark:bg-gray-700"
                        id="notification-dropdown"
                        data-popper-placement="bottom"
                        style="
                            position: absolute;
                            inset: 0px auto auto 0px;
                            margin: 0px;
                            transform: translate3d(1265.6px, 60.8px, 0px);
                        "
                    >
                        <div
                            class="block bg-gray-50 px-4 py-2 text-center text-sm font-medium text-gray-700 dark:bg-gray-600 dark:text-gray-300"
                        >
                            Notifications
                        </div>
                        <div>
                            <Link
                                href="#"
                                class="flex border-b px-4 py-3 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600"
                            >
                                <div class="flex-shrink-0">
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/bonnie-green.png"
                                        alt="Bonnie Green avatar"
                                    />
                                    <div
                                        class="bg-primary-700 absolute -mt-5 ml-6 flex h-5 w-5 items-center justify-center rounded-full border border-white dark:border-gray-700"
                                    >
                                        <svg
                                            aria-hidden="true"
                                            class="h-3 w-3 text-white"
                                            fill="currentColor"
                                            viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                d="M8.707 7.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l2-2a1 1 0 00-1.414-1.414L11 7.586V3a1 1 0 10-2 0v4.586l-.293-.293z"
                                            ></path>
                                            <path
                                                d="M3 5a2 2 0 012-2h1a1 1 0 010 2H5v7h2l1 2h4l1-2h2V5h-1a1 1 0 110-2h1a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2V5z"
                                            ></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="w-full pl-3">
                                    <div
                                        class="mb-1.5 text-sm font-normal text-gray-500 dark:text-gray-400"
                                    >
                                        New message from
                                        <span
                                            class="font-semibold text-gray-900 dark:text-white"
                                            >Bonnie Green</span
                                        >: "Hey, what's up? All set for the
                                        presentation?"
                                    </div>
                                    <div
                                        class="text-primary-600 dark:text-primary-500 text-xs font-medium"
                                    >
                                        a few moments ago
                                    </div>
                                </div>
                            </Link>
                            <Link
                                href="#"
                                class="flex border-b px-4 py-3 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600"
                            >
                                <div class="flex-shrink-0">
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/jese-leos.png"
                                        alt="Jese Leos avatar"
                                    />
                                    <div
                                        class="absolute -mt-5 ml-6 flex h-5 w-5 items-center justify-center rounded-full border border-white bg-gray-900 dark:border-gray-700"
                                    >
                                        <svg
                                            aria-hidden="true"
                                            class="h-3 w-3 text-white"
                                            fill="currentColor"
                                            viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z"
                                            ></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="w-full pl-3">
                                    <div
                                        class="mb-1.5 text-sm font-normal text-gray-500 dark:text-gray-400"
                                    >
                                        <span
                                            class="font-semibold text-gray-900 dark:text-white"
                                            >Jese leos</span
                                        >
                                        and
                                        <span
                                            class="font-medium text-gray-900 dark:text-white"
                                            >5 others</span
                                        >
                                        started following you.
                                    </div>
                                    <div
                                        class="text-primary-600 dark:text-primary-500 text-xs font-medium"
                                    >
                                        10 minutes ago
                                    </div>
                                </div>
                            </Link>
                            <Link
                                href="#"
                                class="flex border-b px-4 py-3 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600"
                            >
                                <div class="flex-shrink-0">
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/joseph-mcfall.png"
                                        alt="Joseph McFall avatar"
                                    />
                                    <div
                                        class="absolute -mt-5 ml-6 flex h-5 w-5 items-center justify-center rounded-full border border-white bg-red-600 dark:border-gray-700"
                                    >
                                        <svg
                                            aria-hidden="true"
                                            class="h-3 w-3 text-white"
                                            fill="currentColor"
                                            viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                fill-rule="evenodd"
                                                d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z"
                                                clip-rule="evenodd"
                                            ></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="w-full pl-3">
                                    <div
                                        class="mb-1.5 text-sm font-normal text-gray-500 dark:text-gray-400"
                                    >
                                        <span
                                            class="font-semibold text-gray-900 dark:text-white"
                                            >Joseph Mcfall</span
                                        >
                                        and
                                        <span
                                            class="font-medium text-gray-900 dark:text-white"
                                            >141 others</span
                                        >
                                        love your story. See it and view more
                                        stories.
                                    </div>
                                    <div
                                        class="text-primary-600 dark:text-primary-500 text-xs font-medium"
                                    >
                                        44 minutes ago
                                    </div>
                                </div>
                            </Link>
                            <Link
                                href="#"
                                class="flex border-b px-4 py-3 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600"
                            >
                                <div class="flex-shrink-0">
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/roberta-casas.png"
                                        alt="Roberta Casas image"
                                    />
                                    <div
                                        class="absolute -mt-5 ml-6 flex h-5 w-5 items-center justify-center rounded-full border border-white bg-green-400 dark:border-gray-700"
                                    >
                                        <svg
                                            aria-hidden="true"
                                            class="h-3 w-3 text-white"
                                            fill="currentColor"
                                            viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                fill-rule="evenodd"
                                                d="M18 13V5a2 2 0 00-2-2H4a2 2 0 00-2 2v8a2 2 0 002 2h3l3 3 3-3h3a2 2 0 002-2zM5 7a1 1 0 011-1h8a1 1 0 110 2H6a1 1 0 01-1-1zm1 3a1 1 0 100 2h3a1 1 0 100-2H6z"
                                                clip-rule="evenodd"
                                            ></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="w-full pl-3">
                                    <div
                                        class="mb-1.5 text-sm font-normal text-gray-500 dark:text-gray-400"
                                    >
                                        <span
                                            class="font-semibold text-gray-900 dark:text-white"
                                            >Leslie Livingston</span
                                        >
                                        mentioned you in a comment:
                                        <span
                                            class="text-primary-600 dark:text-primary-500 font-medium"
                                            >@bonnie.green</span
                                        >
                                        what do you say?
                                    </div>
                                    <div
                                        class="text-primary-600 dark:text-primary-500 text-xs font-medium"
                                    >
                                        1 hour ago
                                    </div>
                                </div>
                            </Link>
                            <Link
                                href="#"
                                class="flex px-4 py-3 hover:bg-gray-100 dark:hover:bg-gray-600"
                            >
                                <div class="flex-shrink-0">
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/robert-brown.png"
                                        alt="Robert image"
                                    />
                                    <div
                                        class="absolute -mt-5 ml-6 flex h-5 w-5 items-center justify-center rounded-full border border-white bg-purple-500 dark:border-gray-700"
                                    >
                                        <svg
                                            aria-hidden="true"
                                            class="h-3 w-3 text-white"
                                            fill="currentColor"
                                            viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                d="M2 6a2 2 0 012-2h6a2 2 0 012 2v8a2 2 0 01-2 2H4a2 2 0 01-2-2V6zM14.553 7.106A1 1 0 0014 8v4a1 1 0 00.553.894l2 1A1 1 0 0018 13V7a1 1 0 00-1.447-.894l-2 1z"
                                            ></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="w-full pl-3">
                                    <div
                                        class="mb-1.5 text-sm font-normal text-gray-500 dark:text-gray-400"
                                    >
                                        <span
                                            class="font-semibold text-gray-900 dark:text-white"
                                            >Robert Brown</span
                                        >
                                        posted a new video: Glassmorphism -
                                        learn how to implement the new design
                                        trend.
                                    </div>
                                    <div
                                        class="text-primary-600 dark:text-primary-500 text-xs font-medium"
                                    >
                                        3 hours ago
                                    </div>
                                </div>
                            </Link>
                        </div>
                        <Link
                            href="#"
                            class="text-md block bg-gray-50 py-2 text-center font-medium text-gray-900 hover:bg-gray-100 dark:bg-gray-600 dark:text-white dark:hover:underline"
                        >
                            <div class="inline-flex items-center">
                                <svg
                                    aria-hidden="true"
                                    class="mr-2 h-4 w-4 text-gray-500 dark:text-gray-400"
                                    fill="currentColor"
                                    viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg"
                                >
                                    <path
                                        d="M10 12a2 2 0 100-4 2 2 0 000 4z"
                                    ></path>
                                    <path
                                        fill-rule="evenodd"
                                        d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                                        clip-rule="evenodd"
                                    ></path>
                                </svg>
                                View all
                            </div>
                        </Link>
                    </div>
                    <!-- Apps -->
                    <button
                        type="button"
                        data-dropdown-toggle="apps-dropdown"
                        class="rounded-lg p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 focus:ring-4 focus:ring-gray-300 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-600"
                    >
                        <span class="sr-only">View notifications</span>
                        <!-- Icon -->
                        <svg
                            class="h-6 w-6"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                        >
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
                                :href="route('school')"
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
                                    <path
                                        stroke="none"
                                        d="M0 0h24v24H0z"
                                        fill="none"
                                    />
                                    <path
                                        d="M6 4h11a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-11a1 1 0 0 1 -1 -1v-14a1 1 0 0 1 1 -1m3 0v18"
                                    />
                                    <path d="M13 8l2 0" />
                                    <path d="M13 12l2 0" />
                                </svg>
                                <div
                                    class="text-sm text-gray-900 dark:text-white"
                                >
                                    Staf
                                </div>
                            </Link>
                            <Link
                                :href="route('school')"
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
                                    <path
                                        stroke="none"
                                        d="M0 0h24v24H0z"
                                        fill="none"
                                    />
                                    <path d="M22 9l-10 -4l-10 4l10 4l10 -4v6" />
                                    <path d="M6 10.6v5.4a6 3 0 0 0 12 0v-5.4" />
                                </svg>
                                <div
                                    class="text-sm text-gray-900 dark:text-white"
                                >
                                    Guru
                                </div>
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
                        <img
                            class="h-8 w-8 rounded-full"
                            src="/assets/icons/user-circle.png"
                            alt="user photo"
                        />
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
                            <span
                                class="block text-sm font-semibold text-gray-900 dark:text-white"
                                >{{ $page.props.auth.user.name }}</span
                            >
                            <span
                                class="block truncate text-sm text-gray-900 dark:text-white"
                                >{{ $page.props.auth.user.email }}</span
                            >
                        </div>
                        <ul
                            class="py-1 text-gray-700 dark:text-gray-300"
                            aria-labelledby="dropdown"
                        >
                            <li>
                                <Link
                                    href="#"
                                    class="block px-4 py-2 text-sm hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                    >Pengaturan Akun</Link
                                >
                            </li>
                        </ul>
                        <ul
                            class="py-1 text-gray-700 dark:text-gray-300"
                            aria-labelledby="dropdown"
                        >
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

        <main class="h-auto p-4 pt-24 md:ml-64">
            <slot name="content" />
        </main>
    </div>
</template>
