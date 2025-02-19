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
    <section class="min-h-screen bg-gray-100 dark:bg-gray-900">
        <div
            class="mx-auto flex flex-col items-center justify-center px-6 py-8 md:h-screen lg:py-0"
        >
            <Link
                href="/"
                class="mb-6 flex items-center text-xl font-semibold text-gray-900 dark:text-white"
            >
                <ApplicationLogo class="h-20" />
            </Link>
            <div
                class="w-full rounded-lg bg-white shadow dark:border dark:border-gray-700 dark:bg-gray-800 sm:max-w-md md:mt-0 xl:p-0"
            >
                <slot />
            </div>
        </div>
    </section>
</template>
