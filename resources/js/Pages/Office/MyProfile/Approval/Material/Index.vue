<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import ApprovalForm from '@/Components/ApprovalForm.vue';
import SubmissionForm from './Form.vue';
import SubmissionFilter from '@/Components/SubmissionFilter.vue';
import ChatForm from '@/Components/ChatForm.vue';
import Badge from '@/Components/Badge.vue';
import DefaultButton from '@/Components/DefaultButton.vue';

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'My Profile', href: route('office.myProfile') },
  { label: 'Persetujuan Material', href: route('office.myProfile.approval.material') },
];
</script>

<script>
export default {
  props: {
    search_params: Object,
    submissions: Object,
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
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
      >
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" />
        </div>
        <div
          class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0"
        >
          <a v-if="search_params.take" :href="route('office.myProfile.approval.material.export')">
            <DefaultButton type="green">
              <div class="flex items-center space-x-1 text-xs">
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
                  <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                  <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
                  <path d="M9 15h6" />
                  <path d="M12.5 17.5l2.5 -2.5l-2.5 -2.5" />
                </svg>
                <div>Ekspor Data</div>
              </div>
            </DefaultButton>
          </a>
          <DefaultButton
            type="light"
            @click="
              openModal({
                title: 'Saring',
                mode: 'submission-filter',
                maxWidth: 'md',
                data: {
                  searchParams: search_params,
                },
              })
            "
          >
            <div class="flex items-center space-x-1 text-xs">
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
                <path
                  d="M4 4h16v2.172a2 2 0 0 1 -.586 1.414l-4.414 4.414v7l-6 2v-8.5l-4.48 -4.928a2 2 0 0 1 -.52 -1.345v-2.227z"
                />
              </svg>
              <div>Saring</div>
            </div>
          </DefaultButton>
        </div>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <section>
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800">
          <!-- table list -->
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
                  <th scope="col" class="whitespace-nowrap p-4">Nomor Permintaan</th>
                  <th scope="col" class="whitespace-nowrap p-4">Pengaju</th>
                  <th scope="col" class="whitespace-nowrap p-4">Area</th>
                  <th scope="col" class="whitespace-nowrap p-4">Tanggal</th>
                  <th scope="col" class="whitespace-nowrap p-4">Barang</th>
                  <th scope="col" class="whitespace-nowrap p-4">Kode Barang</th>
                  <th scope="col" class="whitespace-nowrap p-4">Jumlah</th>
                  <th scope="col" class="whitespace-nowrap p-4">Harga</th>
                  <th scope="col" class="whitespace-nowrap p-4">Total Harga</th>
                  <th scope="col" class="whitespace-nowrap p-4">Referensi Pembelian</th>
                  <th scope="col" class="whitespace-nowrap p-4">Tenggat Waktu</th>
                  <th scope="col" class="whitespace-nowrap p-4">Status Persetujuan</th>
                  <th scope="col" class="whitespace-nowrap p-4">Status Barang</th>
                  <th scope="col" class="whitespace-nowrap p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(submission, index) in submissions.data"
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
                      {{ submission.reference_number }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.submitter.profile.name }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.area.name }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.datetime_label }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].name }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].reference_number }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].quantity }} {{ submission.material.items[0].unit_label }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].price_label }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].bill_amount_label }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].purchase_reference }}
                    </div>
                  </th>
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.material.items[0].due_date }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3">
                    <Badge v-if="submission.status == 'DRAFT'" type="dark">Draf</Badge>
                    <Badge v-else-if="submission.status == 'PENDING'" type="yellow">Menunggu</Badge>
                    <Badge v-else-if="submission.status == 'REJECTED'" type="red">Ditolak</Badge>
                    <Badge v-else-if="submission.status == 'APPROVED'" type="green">Disetujui</Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <div v-if="submission.status == 'APPROVED'">
                      <Badge v-if="submission.material.items[0].status == 'DRAFT'" type="dark">Draf</Badge>
                      <Badge v-else-if="submission.material.items[0].status == 'PENDING'" type="yellow">Menunggu</Badge>
                      <Badge v-else-if="submission.material.items[0].status == 'REJECTED'" type="red">Ditolak</Badge>
                      <Badge v-else-if="submission.material.items[0].status == 'ORDERED'" type="default">Dipesan</Badge>
                      <Badge v-else-if="submission.material.items[0].status == 'DELIVERED'" type="purple"
                        >Dikirim</Badge
                      >
                      <Badge v-else-if="submission.material.items[0].status == 'RECEIVED'" type="green">Diterima</Badge>
                      <Badge v-else-if="submission.material.items[0].status == 'CANCELED'" type="gray"
                        >Dibatalkan</Badge
                      >
                    </div>
                    <div v-else>-</div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-3">
                      <OutlineButton
                        type="default"
                        @click="
                          openModal({
                            title: 'Sunting Permintaan',
                            mode: 'submission-edit-form',
                            maxWidth: 'md',
                            data: {
                              submission: submission,
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
                      <OutlineButton
                        type="purple"
                        @click="
                          openModal({
                            title: `Permintaan Material ${submission.reference_number}`,
                            mode: 'chat-form',
                            maxWidth: '3xl',
                            data: {
                              user: $page.props.auth.user,
                              model_id: submission.id,
                              model_type: `App\\Models\\Submission`,
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
                            <path d="M21 14l-3 -3h-7a1 1 0 0 1 -1 -1v-6a1 1 0 0 1 1 -1h9a1 1 0 0 1 1 1v10" />
                            <path d="M14 15v2a1 1 0 0 1 -1 1h-7l-3 3v-10a1 1 0 0 1 1 -1h2" />
                          </svg>
                          <div>Chat</div>
                        </div>
                      </OutlineButton>
                      <OutlineButton
                        type="yellow"
                        @click="
                          openModal({
                            title: 'Persetujuan',
                            mode: 'approval-form',
                            maxWidth: 'xl',
                            data: {
                              approvals: submission.approvals,
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
                            <path d="M4 12h.01" />
                            <path d="M4 6h.01" />
                            <path d="M4 18h.01" />
                            <path d="M8 18h2" />
                            <path d="M8 12h2" />
                            <path d="M8 6h2" />
                            <path d="M14 6h6" />
                            <path d="M14 12h6" />
                            <path d="M14 18h6" />
                          </svg>
                          <div>Persetujuan</div>
                        </div>
                      </OutlineButton>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- pagination -->
          <Pagination :search_params="search_params" :meta="submissions.meta" :links="submissions.links" />
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <SubmissionFilter
            v-if="propertyModal?.mode == 'submission-filter'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <SubmissionForm
            v-if="propertyModal?.mode == 'submission-edit-form' || propertyModal?.mode == 'submission-create-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <ApprovalForm
            v-if="propertyModal?.mode == 'approval-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <ChatForm v-if="propertyModal?.mode == 'chat-form'" :propertyModal="propertyModal" @close="closeModal()" />
        </template>
      </Modal>
    </template>
  </OfficeLayout>
</template>
