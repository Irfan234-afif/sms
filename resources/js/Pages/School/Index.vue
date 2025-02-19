<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Sekolah" />

    <SchoolLayout>
        <template #sidebar>
            <SchoolSidebar />
        </template>
        <template #content>
            <section
                class="rounded-xl bg-white p-4 antialiased dark:bg-gray-900 md:p-6"
            >
                <div class="px-4 2xl:px-0">
                    <h1
                        class="text-lg font-semibold text-gray-900 dark:text-white"
                    >
                        Selamat datang
                    </h1>
                </div>
            </section>
        </template>
    </SchoolLayout>
</template>
