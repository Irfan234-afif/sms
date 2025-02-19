<script setup>
import GuardianLayout from '@/Layouts/GuardianLayout.vue';
import GuardianSidebar from '@/Layouts/Sidebars/GuardianSidebar.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Wali" />

    <GuardianLayout>
        <template #sidebar>
            <GuardianSidebar />
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
    </GuardianLayout>
</template>
