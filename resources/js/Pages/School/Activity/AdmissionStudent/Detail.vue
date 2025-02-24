<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import StageForm from './StageForm.vue';
import Badge from '@/Components/Badge.vue';
import AcceptForm from './AcceptForm.vue';
</script>

<script>
export default {
  props: {
    admission_student: Object,
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
  <Head title="Sekolah" />

  <SchoolLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div
        class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
      >
        <div class="w-full md:w-1/3">
          <Search :search_params="search_params" />
        </div>
      </div>
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <!-- Data -->
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <!--  -->

          <div class="grid gap-4 py-2 sm:gap-8 md:grid-cols-2 md:py-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <div class="flex items-center space-x-4">
                  <img
                    v-if="admission_student.data.avatar_path"
                    :src="admission_student.data.avatar_path"
                    class="h-20 w-20 rounded-lg object-cover"
                  />
                  <div v-else class="flex h-20 w-20 items-center justify-center rounded-lg bg-gray-100">
                    <svg
                      class="h-16 w-16 text-gray-500"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      viewBox="0 0 24 24"
                    >
                      <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                      <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                      <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                    </svg>
                  </div>
                  <div>
                    <h2 class="text-base font-medium text-gray-900 dark:text-white">
                      {{ admission_student.data.name }}
                    </h2>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                      ID: {{ admission_student.data.registration_number }}
                    </p>
                  </div>
                </div>

                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.birth_place }},
                    {{ admission_student.data.birth_date }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Jenis Kelamin</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.gender }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.religion }}
                  </dd>
                </dl>
              </div>

              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.phone }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.address }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Kode Pos</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.postal_code }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Asal Sekolah Sebelumnya</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ admission_student.data.previous_school }}
                  </dd>
                </dl>
              </div>
            </div>
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Informasi Orang Tua</h2>
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_name }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Kependudukan Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_national_id }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_birth_place + ', ' + admission_student.data.father_birth_date }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_religion }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_phone }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_address }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Pekerjaan Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.father_occupation }}
                    </dd>
                  </dl>
                </div>

                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_name }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Kependudukan Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_national_id }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_birth_place + ', ' + admission_student.data.mother_birth_date }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_religion }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_phone }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_address }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Pekerjaan Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.mother_occupation }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Riwayat Kesehatan</h2>

              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Catatan Kesehatan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.health_info_remark }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Riwayat Kesehatan Keluarga</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.health_relate_family }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Menggunakan Asuransi?</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.use_insurance_label }}
                    </dd>
                  </dl>

                  <template v-if="admission_student.data.use_insurance">
                    <dl>
                      <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Asuransi</dt>
                      <dd class="text-xs text-gray-500 dark:text-gray-400">
                        {{ admission_student.data.insurance_name }}
                      </dd>
                    </dl>

                    <dl>
                      <dt class="text-xs font-medium text-gray-800 dark:text-white">Jaringan Asuransi</dt>
                      <dd class="text-xs text-gray-500 dark:text-gray-400">
                        {{ admission_student.data.insurance_network }}
                      </dd>
                    </dl>
                  </template>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Rumah Sakit Rekomendasi</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.recomended_hospital }}
                    </dd>
                  </dl>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Dokter</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.doctor_name }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Informasi Dukungan</h2>

              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Kontak Darurat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.emergency_name }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Telepon Darurat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.emergency_phone }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Hubungan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.emergency_relation }}
                    </dd>
                  </dl>
                </div>
              </div>

              <h2 class="text-base font-medium text-gray-900 dark:text-white">Informasi Penanggung Biaya</h2>
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Penanggung</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.payer_name }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Telepon</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.payer_phone }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Email</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.payer_email }}
                    </dd>
                  </dl>
                </div>
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Hubungan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.payer_relation }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ admission_student.data.payer_address }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Lampiran</h2>

              <div
                class="max-w-lg rounded-lg border border-gray-200 bg-white text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
              >
                <button
                  type="button"
                  class="relative inline-flex w-full items-center rounded-t-lg border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Kartu Keluarga
                </button>
                <button
                  type="button"
                  class="relative inline-flex w-full items-center border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Kartu Tanda Penduduk Ayah
                </button>
                <button
                  type="button"
                  class="relative inline-flex w-full items-center border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Kartu Tanda Penduduk Ibu
                </button>
                <button
                  type="button"
                  class="relative inline-flex w-full items-center border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Akta Kelahiran
                </button>
                <button
                  type="button"
                  class="relative inline-flex w-full items-center border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Raport Terakhir
                </button>
                <button
                  type="button"
                  class="relative inline-flex w-full items-center border-b border-gray-200 px-4 py-3 text-xs font-medium hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:text-blue-700 focus:ring-2 focus:ring-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:text-white dark:focus:ring-gray-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="me-2.5 h-4 w-4"
                  >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path
                      d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5"
                    />
                  </svg>
                  Surat Keterangan Sehat
                </button>
              </div>
            </div>
          </div>
          <hr class="my-4" />
          <!--  -->
          <div>
            <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-4">Tahapan Pendaftaran</h1>
            <ol class="relative mx-3 max-w-2xl border-s border-gray-200 dark:border-gray-700">
              <template v-for="(stage, index) in admission_student.data.stages" :key="index">
                <li
                  class="mb-10 ms-8"
                  v-if="
                    admission_student.data.status == 'ACCEPTED' ||
                    admission_student.data.status == 'REJECTED' ||
                    admission_student.data.status == 'ENROLLED' ||
                    stage.type == 'PRE'
                  "
                >
                  <span
                    class="absolute -start-4 flex h-7 w-7 items-center justify-center rounded-full bg-blue-100 ring-8 ring-white dark:bg-blue-900 dark:ring-gray-900"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="h-5 w-5 text-blue-800 dark:text-blue-300"
                    >
                      <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                      <path d="M4 5m0 2a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2z" />
                      <path d="M16 3l0 4" />
                      <path d="M8 3l0 4" />
                      <path d="M4 11l16 0" />
                      <path d="M8 15h2v2h-2z" />
                    </svg>
                  </span>
                  <h3 class="mb-1 flex items-center text-base font-medium text-gray-900 dark:text-white">
                    {{ stage.title }}
                    <Badge class="ml-3" type="default">
                      {{ stage.status.title }}
                    </Badge>
                  </h3>

                  <time class="mb-2 block text-xs font-normal leading-none text-gray-400 dark:text-gray-500">{{
                    stage.scheduled_at_label
                  }}</time>
                  <div v-if="stage.officer" class="my-3 flex items-center gap-4">
                    <div class="flex h-10 w-10 items-center justify-center rounded-full bg-gray-100">
                      <svg
                        class="h-6 w-6 text-gray-500"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        viewBox="0 0 24 24"
                      >
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                        <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                      </svg>
                    </div>
                    <div class="text-xs font-medium dark:text-white">
                      <div>{{ stage.officer.profile.name }}</div>
                      <div class="text-xs text-gray-500 dark:text-gray-400">-</div>
                    </div>
                  </div>
                  <p
                    class="mb-3 rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal text-gray-500 dark:text-gray-400"
                  >
                    {{ stage.description }}
                  </p>
                  <DefaultButton
                    type="light"
                    @click="
                      openModal({
                        title: stage.title,
                        mode: 'stage-form',
                        maxWidth: '2xl',
                        data: {
                          admission_student_stage: stage,
                        },
                      })
                    "
                    >Perbarui Status</DefaultButton
                  >
                </li>
              </template>
            </ol>
            <div
              v-if="
                admission_student.data.status != 'ACCEPTED' &&
                admission_student.data.status != 'REJECTED' &&
                admission_student.data.status != 'ENROLLED'
              "
              class="flex justify-start space-x-4"
            >
              <DefaultButton
                type="red"
                @click="
                  openModal({
                    title: 'Tolak Calon Siswa',
                    mode: 'rejected-form',
                    maxWidth: 'sm',
                    data: {
                      description: 'Ingin menolak Calon Siswa?',
                      actionUrl: route('school.activity.admissionStudent.updateStatus', {
                        registration_number: admission_student.data.registration_number,
                        status: 'REJECTED',
                      }),
                    },
                  })
                "
                >Tolak Calon Siswa</DefaultButton
              >
              <DefaultButton
                type="green"
                @click="
                  openModal({
                    title: 'Terima Calon Siswa',
                    mode: 'accepted-form',
                    maxWidth: 'sm',
                    data: {
                      description: 'Ingin menerima Calon Siswa?',
                      actionUrl: route('school.activity.admissionStudent.updateStatus', {
                        registration_number: admission_student.data.registration_number,
                        status: 'ACCEPTED',
                      }),
                    },
                  })
                "
                >Terima Calon Siswa</DefaultButton
              >
            </div>
            <div v-if="admission_student.data.status == 'ACCEPTED'" class="flex justify-start space-x-4">
              <DefaultButton
                type="green"
                @click="
                  openModal({
                    title: 'Selesaikan Pendaftaran',
                    mode: 'enrolled-form',
                    maxWidth: 'sm',
                    data: {
                      description: 'Selesaikan pendaftaran Siswa?',
                      actionUrl: route('school.activity.admissionStudent.updateStatus', {
                        registration_number: admission_student.data.registration_number,
                        status: 'ENROLLED ',
                      }),
                    },
                  })
                "
                >Selesaikan Pendaftaran</DefaultButton
              >
            </div>
          </div>
        </div>
      </section>
      <!-- Modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <AcceptForm
            v-if="
              propertyModal?.mode == 'accepted-form' ||
              propertyModal?.mode == 'rejected-form' ||
              propertyModal?.mode == 'enrolled-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <StageForm v-if="propertyModal?.mode == 'stage-form'" :propertyModal="propertyModal" @close="closeModal()" />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
