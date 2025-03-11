<script setup>
import OutlineButton from '@/Components/OutlineButton.vue';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import ICCSidebar from '@/Layouts/Sidebars/ICCSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import PageForm from './Form.vue';
const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'ICC', href: route('office.icc') },
  { label: 'Halaman', href: route('office.icc.publication.page') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    pages: Object,
  },
  data() {
    return {
      showModal: false,
      propertyModal: {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      },
    };
  },
  methods: {
    openModal(property) {
      this.showModal = true;
      this.propertyModal = property;
    },
    closeModal() {
      this.showModal = false;
      this.propertyModal = {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      };
    },
  },
};
</script>

<template>
  <Head title="Yayasan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <ICCSidebar />
    </template>
    <template #content>
      <!-- Data -->
      <section>
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800">
          <!-- Table List -->
          <div class="overflow-x-auto">
            <table class="w-full text-left text-xs text-gray-500 dark:text-gray-400">
              <thead class="bg-gray-50 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                  <th scope="col" class="p-4" v-if="false">
                    <div class="flex items-center">
                      <input
                        id="checkbox-all"
                        type="checkbox"
                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                      />
                      <label for="checkbox-all" class="sr-only">checkbox</label>
                    </div>
                  </th>
                  <th scope="col" class="p-4">Halaman</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(page, index) in pages.data"
                  :key="index"
                  class="border-b hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-700"
                >
                  <td class="w-4 p-4" v-if="false">
                    <div class="flex items-center">
                      <input
                        id="checkbox-table-search"
                        type="checkbox"
                        onclick="event.stopPropagation()"
                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                      />
                      <label for="checkbox-table-search" class="sr-only">checkbox</label>
                    </div>
                  </td>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ page.title }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: 'Sunting Halaman',
                            mode: 'page-edit-form',
                            maxWidth: '5xl',
                            data: {
                              page: page,
                            },
                          })
                        "
                      >
                        <div class="flex items-center space-x-1">
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.5"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="h-4"
                          >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1" />
                            <path d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z" />
                            <path d="M16 5l3 3" />
                          </svg>
                          <div>Sunting</div>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </section>
      <!-- Modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <PageForm
            v-if="propertyModal?.mode == 'page-edit-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </OfficeLayout>
</template>
