<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import StageForm from './StageForm.vue';
import AcceptForm from './AcceptForm.vue';
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
        <template #sidebar>
            <SchoolSidebar />
        </template>
        <template #content>
            <!-- Data -->
            <section class="rounded-lg bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
                <div class="px-4 2xl:px-0">
                    <!--  -->
                    <h1 class="text-lg font-semibold text-gray-900 dark:text-white md:pb-2">
                        {{ student.data.profile.name }}
                    </h1>
                    <div class="grid gap-4 py-2 sm:gap-8 md:grid-cols-2 md:py-4">
                        <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                            <div class="space-y-4">
                                <div class="flex items-center space-x-4">
                                    <img
                                        v-if="student.data.avatar_path"
                                        :src="student.data.avatar_path"
                                        class="h-20 w-20 rounded-lg object-cover"
                                    />
                                    <div
                                        v-else
                                        class="flex h-20 w-20 items-center justify-center rounded-lg bg-gray-100"
                                    >
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
                                        <h2 class="text-base font-bold text-gray-900 dark:text-white">
                                            {{ student.data.profile.name }}
                                        </h2>
                                        <p class="text-xs text-gray-500 dark:text-gray-400">
                                            ID: {{ student.data.school_national_id }}
                                        </p>
                                    </div>
                                </div>

                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                        Tempat, Tanggal Lahir
                                    </dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.birth_place }},
                                        {{ student.data.profile.birth_date }}
                                    </dd>
                                </dl>
                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">Jenis Kelamin</dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.gender }}
                                    </dd>
                                </dl>
                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">Agama</dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.religion }}
                                    </dd>
                                </dl>
                            </div>

                            <div class="space-y-4">
                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">Nomor Telepon</dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.phone }}
                                    </dd>
                                </dl>
                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">Alamat</dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.address }}
                                    </dd>
                                </dl>
                                <dl>
                                    <dt class="text-xs font-semibold text-gray-700 dark:text-white">Kode Pos</dt>
                                    <dd class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ student.data.profile.postal_code }}
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <h2 class="text-base font-bold text-gray-900 dark:text-white">Informasi Orang Tua</h2>
                            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Nama Ayah</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nomor Kependudukan Ayah
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Tempat, Tanggal Lahir Ayah
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' + ', ' + '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Agama Ayah</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nomor Telepon Ayah
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Alamat Ayah</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Pekerjaan Ayah
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>

                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Nama Ibu</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nomor Kependudukan Ibu
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Tempat, Tanggal Lahir Ibu
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' + ', ' + '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Agama Ibu</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nomor Telepon Ibu
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Alamat Ibu</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Pekerjaan Ibu
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <h2 class="text-base font-bold text-gray-900 dark:text-white">Riwayat Kesehatan</h2>

                            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Catatan Kesehatan
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Riwayat Kesehatan Keluarga
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Menggunakan Asuransi?
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <!-- Hanya tampil jika menggunakan asuransi -->
                                    <template>
                                        <dl>
                                            <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                                Nama Asuransi
                                            </dt>
                                            <dd class="text-xs text-gray-500 dark:text-gray-400">
                                                {{ '-' }}
                                            </dd>
                                        </dl>

                                        <dl>
                                            <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                                Jaringan Asuransi
                                            </dt>
                                            <dd class="text-xs text-gray-500 dark:text-gray-400">
                                                {{ '-' }}
                                            </dd>
                                        </dl>
                                    </template>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Rumah Sakit Rekomendasi
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>

                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Nama Dokter</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <h2 class="text-base font-bold text-gray-900 dark:text-white">Informasi Dukungan</h2>

                            <!-- Informasi Darurat -->
                            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nama Kontak Darurat
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Telepon Darurat
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Hubungan</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>
                            </div>

                            <!-- Informasi Penanggung Biaya -->
                            <h2 class="text-base font-bold text-gray-900 dark:text-white">
                                Informasi Penanggung Biaya
                            </h2>
                            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">
                                            Nama Penanggung
                                        </dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Telepon</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Email</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>
                                <div class="space-y-4">
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Hubungan</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt class="text-xs font-semibold text-gray-700 dark:text-white">Alamat</dt>
                                        <dd class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ '-' }}
                                        </dd>
                                    </dl>
                                </div>
                            </div>
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
                    <StageForm
                        v-if="propertyModal?.mode == 'stage-form'"
                        :propertyModal="propertyModal"
                        @close="closeModal()"
                    />
                </template>
            </Modal>
        </template>
    </SchoolLayout>
</template>
