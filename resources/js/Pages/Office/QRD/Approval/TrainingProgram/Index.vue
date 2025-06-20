<script setup>
import Pagination from '@/Components/Pagination.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import ApprovalForm from '@/Components/ApprovalForm.vue';
// import SubmissionForm from './Form.vue';
import SubmissionFilter from '@/Components/SubmissionFilter.vue';
import ChatForm from '@/Components/ChatForm.vue';
import Badge from '@/Components/Badge.vue';
import {Link} from '@inertiajs/vue3';
import DefaultButton from '@/Components/DefaultButton.vue';

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Persetujuan Training Program', href: route('office.qrd.approval.trainingProgram') },
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
    formatCurrency(amount) {
      return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      }).format(amount);
    },
    formatDate(date) {
      if (!date) return '-';
      return new Date(date).toLocaleDateString('id-ID', {
        day: '2-digit',
        month: 'short',
        year: 'numeric',
      });
    },
    getTrainingTypeLabel(type) {
      return type === 'internal' ? 'Internal' : 'Eksternal';
    },
    getTrainingTitle(submission) {
      const trainingProgram = submission.training_program_submission;
      if (!trainingProgram) return '-';
      
      if (trainingProgram.training_type === 'internal' && trainingProgram.training_program) {
        return trainingProgram.training_program.name;
      }
      return trainingProgram.external_training_title || '-';
    },
    getTrainingProvider(submission) {
      const trainingProgram = submission.training_program_submission;
      if (!trainingProgram) return '-';
      
      if (trainingProgram.training_type === 'internal') {
        return 'Internal Training';
      }
      return trainingProgram.external_training_provider || '-';
    },
    getParticipantsCount(submission) {
      const trainingProgram = submission.training_program_submission;
      if (!trainingProgram || !trainingProgram.participants) return 0;
      return trainingProgram.participants.length;
    },
    getTotalBudget(submission) {
      const trainingProgram = submission.training_program_submission;
      if (!trainingProgram || !trainingProgram.budget_items) return 0;
      
      return trainingProgram.budget_items.reduce((total, item) => {
        return total + (item.quantity * item.unit_price);
      }, 0);
    },
  },
};
</script>

<template>
  <Head title="Persetujuan Training Program - QRD" />

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
          <!-- <DefaultButton
            @click="
              openModal({
                title: 'Buat Pengajuan Training Program',
                mode: 'submission-create-form',
                maxWidth: '5xl',
                data: {},
              })
            "
          >
            <div class="flex items-center space-x-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-4 w-4"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M12 5l0 14" />
                <path d="M5 12l14 0" />
              </svg>
              <span>Buat Pengajuan</span>
            </div>
          </DefaultButton> -->
        </div>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <section>
        <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800">
          <!-- table list -->
          <div class="overflow-x-auto">
            <table class="w-full text-left text-xs text-gray-500 dark:text-gray-400">
              <thead class="bg-gray-50 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                  <th scope="col" class="p-4">Nomor Pengajuan</th>
                  <th scope="col" class="p-4">Tanggal</th>
                  <th scope="col" class="p-4">Jenis Training</th>
                  <th scope="col" class="p-4">Judul Training</th>
                  <th scope="col" class="p-4">Provider</th>
                  <th scope="col" class="p-4">Peserta</th>
                  <th scope="col" class="p-4">Periode</th>
                  <th scope="col" class="p-4">Budget</th>
                  <th scope="col" class="p-4">Status</th>
                  <th scope="col" class="p-4"></th>
                </tr>
              </thead>
              <tbody class="text-xs">
                <tr
                  v-for="(submission, index) in submissions.data"
                  :key="index"
                  class="border-b hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-700"
                >
                  <th scope="row" class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      {{ submission.reference_number }}
                    </div>
                  </th>
                  <td class="whitespace-nowrap px-4 py-3 text-gray-900 dark:text-white">
                    {{ formatDate(submission.datetime) }}
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 text-gray-900 dark:text-white">
                    <div class="flex items-center">
                      <Badge 
                        :type="submission.training_program_submission?.training_type === 'internal' ? 'blue' : 'purple'"
                      >
                        {{ getTrainingTypeLabel(submission.training_program_submission?.training_type) }}
                      </Badge>
                    </div>
                  </td>
                  <td class="px-4 py-3 text-gray-900 dark:text-white">
                    <div class="max-w-xs truncate">
                      {{ getTrainingTitle(submission) }}
                    </div>
                  </td>
                  <td class="px-4 py-3 text-gray-900 dark:text-white">
                    <div class="max-w-xs truncate">
                      {{ getTrainingProvider(submission) }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 text-gray-900 dark:text-white">
                    <div class="flex items-center space-x-2">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="h-4 w-4"
                      >
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                        <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                      </svg>
                      <span>{{ getParticipantsCount(submission) }}</span>
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 text-gray-900 dark:text-white">
                    <div class="text-xs">
                      <div>{{ formatDate(submission.training_program_submission?.start_date) }}</div>
                      <div class="text-gray-500">
                        s/d {{ formatDate(submission.training_program_submission?.end_date) }}
                      </div>
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 text-gray-900 dark:text-white">
                    <div class="text-xs font-medium">
                      {{ formatCurrency(getTotalBudget(submission)) }}
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3">
                    <Badge v-if="submission.status == 'DRAFT'" type="dark">Draf</Badge>
                    <Badge v-else-if="submission.status == 'PENDING'" type="yellow">Menunggu</Badge>
                    <Badge v-else-if="submission.status == 'REJECTED'" type="red">Ditolak</Badge>
                    <Badge v-else-if="submission.status == 'APPROVED'" type="green">Disetujui</Badge>
                    <Badge v-else-if="submission.status == 'CANCELLED'" type="gray">Dibatalkan</Badge>
                  </td>
                  <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                    <div class="flex items-center justify-end space-x-2">
                      <Link :href="route('office.qrd.manage.training-program-submission.show', submission.training_program_submission.uuid)"
                        class="text-primary-600 hover:text-primary-900">
                        <OutlineButton type="primary" size="sm">
                          <div class="flex items-center space-x-1">
                            <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                              <path fill-rule="evenodd"
                                d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                                clip-rule="evenodd"></path>
                            </svg>
                            <span>Detail</span>
                          </div>
                        </OutlineButton>
                      </Link>
                      <OutlineButton
                        v-if="submission.status == 'DRAFT'"
                        type="default"
                        size="sm"
                        @click="
                          openModal({
                            title: 'Edit Pengajuan Training Program',
                            mode: 'submission-edit-form',
                            maxWidth: '5xl',
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
                            class="h-3 w-3"
                          >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1" />
                            <path d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z" />
                            <path d="M16 5l3 3" />
                          </svg>
                          <span>Edit</span>
                        </div>
                      </OutlineButton>
                      <OutlineButton
                        type="purple"
                        size="sm"
                        @click="
                          openModal({
                            title: `Chat Pengajuan ${submission.reference_number}`,
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
                            class="h-3 w-3"
                          >
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M21 14l-3 -3h-7a1 1 0 0 1 -1 -1v-6a1 1 0 0 1 1 -1h9a1 1 0 0 1 1 1v10" />
                            <path d="M14 15v2a1 1 0 0 1 -1 1h-7l-3 3v-10a1 1 0 0 1 1 -1h2" />
                          </svg>
                          <span>Chat</span>
                        </div>
                      </OutlineButton>
                      <OutlineButton
                        type="yellow"
                        size="sm"
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
                            class="h-3 w-3"
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
                          <span>Persetujuan</span>
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
          <!-- <SubmissionForm
            v-if="propertyModal?.mode == 'submission-edit-form' || propertyModal?.mode == 'submission-create-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          /> -->
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