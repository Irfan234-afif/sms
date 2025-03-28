<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import GASidebar from '@/Layouts/Sidebars/GASidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'GA', href: route('office.ga') },
];
</script>

<template>
  <Head title="GA" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <GASidebar />
    </template>
    <template #content>
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <h1 class="mb-4 text-base font-medium text-gray-900 dark:text-white md:mb-6">Overview</h1>
        </div>
      </section>
    </template>
  </OfficeLayout>
</template>
