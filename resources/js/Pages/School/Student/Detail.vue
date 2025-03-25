<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Siswa', href: route('school.student') },
  { label: 'Lihat', href: '#' },
];
</script>

<script>
export default {
  props: {
    student: Object,
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
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <!--  -->
          <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-2">
            {{ student.data.profile.name }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <!-- personal data -->
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <div class="flex items-center space-x-4">
                  <img
                    v-if="student.data.profile.avatar_path"
                    :src="student.data.profile.avatar_path"
                    class="h-20 w-20 rounded-lg object-cover"
                  />
                  <div v-else class="flex h-20 w-20 items-center justify-center rounded-lg bg-gray-100">
                    <svg
                      class="h-14 w-14 text-gray-500"
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
                      {{ student.data.profile.name ?? '-' }}
                    </h2>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                      ID: {{ student.data.school_national_id ?? '-' }}
                    </p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.school.area.name }} > Kelas
                      {{ student.data.school_grade.title }}
                    </p>
                  </div>
                </div>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.birth_place ?? '-' }},
                    {{ student.data.profile.birth_date ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Jenis Kelamin</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.gender_label ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.religion_label ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Bahasa Yang Digunakan</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    <span v-if="student.data.admission.languages && student.data.admission.languages.length">
                      <span v-for="(language, index) in student.data.admission.languages" :key="index">
                        {{ language }}<span v-if="index < student.data.admission.languages.length - 1">,</span>
                      </span>
                    </span>
                    <span v-else>Tidak diketahui</span>
                  </dd>
                </dl>
              </div>
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.phone ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.address ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Kode Pos</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ student.data.profile.postal_code ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
            <!-- parent information -->
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Informasi Orang Tua</h2>
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_name ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Kependudukan Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_national_id ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{
                        student.data.admission.father_birth_place ??
                        '-' + ', ' + student.data.admission.father_birth_date
                      }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_religion_label ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Bahasa Yang Digunakan Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      <span
                        v-if="student.data.admission.father_languages && student.data.admission.father_languages.length"
                      >
                        <span v-for="(language, index) in student.data.admission.father_languages" :key="index">
                          {{ language }}<span v-if="index < student.data.admission.father_languages.length - 1">,</span>
                        </span>
                      </span>
                      <span v-else>Tidak diketahui</span>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_phone ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_address ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Pekerjaan Ayah</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.father_occupation ?? '-' }}
                    </dd>
                  </dl>
                </div>
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_name ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Kependudukan Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_national_id ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Tempat, Tanggal Lahir Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{
                        student.data.admission.mother_birth_place ??
                        '-' + ', ' + student.data.admission.mother_birth_date
                      }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Agama Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_religion_label ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Bahasa Yang Digunakan Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      <span
                        v-if="student.data.admission.father_languages && student.data.admission.mother_languages.length"
                      >
                        <span v-for="(language, index) in student.data.admission.mother_languages" :key="index">
                          {{ language }}<span v-if="index < student.data.admission.mother_languages.length - 1">,</span>
                        </span>
                      </span>
                      <span v-else>Tidak diketahui</span>
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nomor Telepon Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_phone ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_address ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Pekerjaan Ibu</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.mother_occupation ?? '-' }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
            <!-- health information -->
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Riwayat Kesehatan</h2>
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Catatan Kesehatan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.health_info_remark ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Riwayat Kesehatan Keluarga</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.health_relate_family ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Menggunakan Asuransi?</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.use_insurance_label ?? '-' }}
                    </dd>
                  </dl>

                  <template v-if="student.data.admission.use_insurance">
                    <dl>
                      <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Asuransi</dt>
                      <dd class="text-xs text-gray-500 dark:text-gray-400">
                        {{ student.data.admission.insurance_name ?? '-' }}
                      </dd>
                    </dl>

                    <dl>
                      <dt class="text-xs font-medium text-gray-800 dark:text-white">Jaringan Asuransi</dt>
                      <dd class="text-xs text-gray-500 dark:text-gray-400">
                        {{ student.data.admission.insurance_network ?? '-' }}
                      </dd>
                    </dl>
                  </template>

                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Rumah Sakit Rekomendasi</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.recomended_hospital ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Dokter</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.doctor_name ?? '-' }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
            <!-- support information -->
            <div class="space-y-4">
              <h2 class="text-base font-medium text-gray-900 dark:text-white">Informasi Dukungan</h2>
              <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Nama Kontak Darurat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.emergency_name ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Telepon Darurat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.emergency_phone ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Hubungan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.emergency_relation ?? '-' }}
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
                      {{ student.data.admission.payer_name ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Telepon</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.payer_phone ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Email</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.payer_email ?? '-' }}
                    </dd>
                  </dl>
                </div>
                <div class="space-y-4">
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Hubungan</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.payer_relation ?? '-' }}
                    </dd>
                  </dl>
                  <dl>
                    <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                      {{ student.data.admission.payer_address ?? '-' }}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }"> </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
