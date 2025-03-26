<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import ICCSidebar from '@/Layouts/Sidebars/ICCSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import SubmissionApproverForm from './Form.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import DeleteConfirm from '@/Components/DeleteConfirm.vue';
const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'ICC', href: route('office.icc') },
  { label: 'Petugas Persetujuan', href: route('office.icc.setting.submissionApprover') },
];
</script>

<script>
export default {
  props: {
    submission_groups: Object,
    areas: Object,
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
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="grid gap-3 lg:grid-cols-4">
          <div v-for="(submission_group, index) in submission_groups.data" :key="index">
            <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-2">
              {{ submission_group.name_label }}
            </h1>
            <div
              class="mt-2 w-full max-w-lg rounded-lg border border-gray-200 bg-white px-4 py-2 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:px-4"
            >
              <div class="flow-root">
                <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                  <li v-for="(area, index) in areas.data" :key="index" class="py-3">
                    <div class="flex items-center space-x-2">
                      <div class="flex-1">
                        <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                          {{ area.name }}
                        </p>
                      </div>
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: `Atur Petugas ${submission_group.name_label} (${area.name})`,
                            mode: 'submission-approver-edit-form',
                            maxWidth: '2xl',
                            data: {
                              submission_group: submission_group,
                              area: area,
                            },
                          })
                        "
                      >
                        Atur Petugas
                      </OutlineButton>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <SubmissionApproverForm
            v-if="propertyModal?.mode == 'submission-approver-edit-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DeleteConfirm
            v-if="propertyModal?.mode == 'submission-approver-delete-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </OfficeLayout>
</template>
