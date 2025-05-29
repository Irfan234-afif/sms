<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
</script>

<script>
export default {
  props: {
    school_curriculum: Object,
    learning_objective_categories: Object,
  },
  data() {
    return {
      breadcrumbs: [
        { label: 'Sekolah', href: route('school') },
        {
          label: `Objektif Pembelajaran (${this.school_curriculum.data.title})`,
          href: route('school.teachingProgram.learningObjective'),
        },
      ],
    };
  },
};
</script>

<template>
  <Head title="Sekolah" />

  <SchoolLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <section>
        <div class="relative overflow-hidden bg-white p-4 shadow-md dark:bg-gray-800">
          <div class="grid max-w-sm grid-cols-1 gap-2">
            <template v-for="(learning_objective_category, index) in learning_objective_categories.data" :key="index">
              <Link
                :href="
                  route('school.teachingProgram.learningObjective.detail', {
                    learning_objective_category_id: learning_objective_category.uuid,
                  })
                "
                class="group flex items-center space-x-2 rounded-xl bg-blue-800 px-4 py-3 text-xs font-medium text-white shadow hover:bg-blue-900 dark:bg-blue-800 dark:text-white"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="h-5 w-5 flex-shrink-0"
                >
                  <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                  <path d="M19 4v16h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12z" />
                  <path d="M19 16h-12a2 2 0 0 0 -2 2" />
                  <path d="M9 8h6" />
                </svg>
                <span class="flex-1 whitespace-nowrap">{{ learning_objective_category.title }} </span>
              </Link>
            </template>
          </div>
        </div>
      </section>
    </template>
  </SchoolLayout>
</template>
