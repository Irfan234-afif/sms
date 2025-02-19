<script setup>
import { Link } from '@inertiajs/vue3';

// Props
defineProps({
    links: {
        type: Object,
        default: () => ({}),
    },
    meta: {
        type: Object,
        default: () => ({}),
    },
    search_params: {
        type: Object,
        default: () => ({}),
    },
});

const generateURL = (url) => {
    if (!url) return '#';

    try {
        let newURL = new URL(url, window.location.origin);
        let search_params = newURL.search_params;

        Object.keys(search_params).forEach((key) => {
            if (search_params[key] !== null) {
                search_params.set(key, search_params[key]);
            }
        });

        return newURL.toString();
    } catch {
        return url;
    }
};
</script>

<template>
    <nav
        v-if="meta"
        class="flex flex-col items-start justify-between space-y-3 p-4 md:flex-row md:items-center md:space-y-0"
        aria-label="Table navigation"
    >
        <span class="text-sm font-normal text-gray-500 dark:text-gray-400">
            Menampilkan
            <span class="font-semibold text-gray-900 dark:text-white">
                {{ meta.from }}-{{ meta.to }}
            </span>
            dari
            <span class="font-semibold text-gray-900 dark:text-white">
                {{ meta.total }}
            </span>
        </span>

        <ul class="inline-flex items-stretch -space-x-px">
            <!-- Previous -->
            <li>
                <Link
                    :href="links.prev ?? '#'"
                    :preserve-scroll="true"
                    class="ml-0 flex h-full items-center justify-center rounded-l-lg border border-gray-300 bg-white px-3 py-1.5 text-gray-500 hover:bg-gray-100 hover:text-gray-700 disabled:opacity-50 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                    :class="{ 'pointer-events-none opacity-50': !links.prev }"
                >
                    <span class="sr-only">Previous</span>
                    <svg
                        class="h-5 w-5"
                        aria-hidden="true"
                        fill="currentColor"
                        viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <path
                            fill-rule="evenodd"
                            d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                            clip-rule="evenodd"
                        />
                    </svg>
                </Link>
            </li>

            <!-- Page Number -->
            <li v-for="(link, index) in meta.links" :key="index">
                <Link
                    v-if="
                        link.url && index != 0 && index != meta.links.length - 1
                    "
                    :href="generateURL(link.url)"
                    :preserve-scroll="true"
                    class="flex items-center justify-center border px-3 py-2 text-sm leading-tight"
                    :class="{
                        'text-gray-500 hover:bg-gray-100 hover:text-gray-700 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white':
                            !link.active,
                        'z-10 border-blue-300 bg-blue-50 text-blue-600 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white':
                            link.active,
                    }"
                >
                    <div v-html="link.label" />
                </Link>
            </li>

            <!-- Next -->
            <li>
                <Link
                    :href="links.next ?? '#'"
                    :preserve-scroll="true"
                    class="flex h-full items-center justify-center rounded-r-lg border border-gray-300 bg-white px-3 py-1.5 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700 disabled:opacity-50 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                    :class="{ 'pointer-events-none opacity-50': !links.next }"
                >
                    <span class="sr-only">Next</span>
                    <svg
                        class="h-5 w-5"
                        aria-hidden="true"
                        fill="currentColor"
                        viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <path
                            fill-rule="evenodd"
                            d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                            clip-rule="evenodd"
                        />
                    </svg>
                </Link>
            </li>
        </ul>
    </nav>
</template>
