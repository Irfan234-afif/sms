<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import Modal from '@/Components/Modal.vue';
import AttachmentForm from '@/Components/AttachmentForm.vue';
import AcademicForm from '@/Components/AcademicForm.vue';
import Dropdown from '@/Components/Dropdown.vue';
import CertificationForm from '@/Components/CertificationForm.vue';
import TrainingForm from '@/Components/TrainingForm.vue';
import SpecializationForm from '@/Components/SpecializationForm.vue';
import ExperienceForm from '@/Components/ExperienceForm.vue';
import LanguageSkillForm from '@/Components/LanguageSkillForm.vue';
import CommunityInvolvementForm from '@/Components/CommunityInvolvementForm.vue';
import FamilyForm from '@/Components/FamilyForm.vue';
import HonorPrizeForm from '@/Components/HonorPrizeForm.vue';
import { languageSkillLevel, familyRelationTypes } from '@/Helpers/options';
</script>

<script>
export default {
    props: {
        profile: {
            type: Object,
            required: true,
        }
    },
    data(){
        return {
            url: new URL(document.URL),
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
}
</script>
<template>
    <div>
        <!-- Lampiran -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Lampiran</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Lampiran Baru',
                            mode: 'create-attachment',
                            maxWidth: 'md',
                            data: {
                                model_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>

                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Jika tidak ada lampiran -->
                    <div v-if="!profile.attachments || profile.attachments.length === 0"
                        class="p-4 text-center text-gray-500">
                        Belum ada lampiran yang diunggah
                    </div>

                    <!-- Daftar lampiran -->
                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(attachment, index) in profile.attachments" :key="index"
                            class="flex items-center justify-between p-4 hover:bg-gray-50 dark:hover:bg-gray-800">
                            <div class="flex items-center space-x-4">
                                <!-- Icon Container -->
                                <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                    <svg class="w-6 h-6 text-blue-600 dark:text-blue-400" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                    </svg>
                                </div>
                                <div>
                                    <div class="text-sm font-medium text-gray-900 dark:text-white">{{ attachment.title
                                        }}
                                    </div>
                                    <div class="text-xs text-gray-500 dark:text-gray-400">{{
                                        attachment.file_name?.slice(-3)
                                        }}</div>
                                </div>
                            </div>
                            <Dropdown align="right" width="48">
                                <template #trigger>
                                    <span class="ml-auto">
                                        <button type="button"
                                            class="inline-flex items-center text-gray-500 group-hover:text-blue-600 border border-transparent">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24"
                                                stroke-width="2" stroke="currentColor" fill="none"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <path d="M12 12m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"></path>
                                                <path d="M12 19m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"></path>
                                                <path d="M12 5m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"></path>
                                            </svg>
                                        </button>
                                    </span>
                                </template>

                                <template #content>
                                    <button
                                        class="flex w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition duration-150 ease-in-out"
                                        @click="
                                            openModal({
                                                title: 'Edit Lampiran',
                                                mode: 'edit-attachment',
                                                maxWidth: 'lg',
                                                data: {
                                                    attachment: attachment,
                                                },
                                            })
                                            ">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 my-auto"
                                            viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>
                                            <path d="M13.5 6.5l4 4"></path>
                                        </svg>
                                        Edit
                                    </button>
                                </template>
                            </Dropdown>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Academic -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Akademik</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Akademik Baru',
                            mode: 'create-academic',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.academic_records?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar akademik yang diunggah
                    </div>

                    <!-- Academic List -->
                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(academic, index) in profile.academic_records" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <!-- Academic Info -->
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path fill="currentColor" fill-rule="evenodd"
                                                d="M9.465 2.82a5.92 5.92 0 0 1 5.07 0l6.692 3.138c1.052.493 1.523 1.564 1.523 2.542s-.47 2.05-1.523 2.543l-1.477.692v4.89c0 1.253-.628 2.463-1.772 3.097c-.752.416-1.74.917-2.78 1.316c-1.027.394-2.164.712-3.198.712s-2.171-.318-3.199-.712c-1.04-.399-2.027-.9-2.779-1.316c-1.144-.634-1.772-1.844-1.772-3.097V11.5q0-.062.01-.122a.75.75 0 0 1 1.059-.8l4.782 2.243a4.42 4.42 0 0 0 3.798 0l6.691-3.137c.403-.189.66-.64.66-1.184s-.257-.995-.66-1.184L13.9 4.179a4.42 4.42 0 0 0-3.798 0l-6.69 3.137a.75.75 0 0 1-.638-1.358zM5.75 12.439v4.187c0 .763.379 1.441.999 1.785c.716.396 1.638.862 2.59 1.227c.963.37 1.899.613 2.661.613s1.698-.243 2.662-.613a21 21 0 0 0 2.59-1.227c.62-.344.998-1.022.998-1.785v-4.187l-3.714 1.741a5.92 5.92 0 0 1-5.071 0z"
                                                clip-rule="evenodd" />
                                            <path fill="currentColor"
                                                d="M6.69 7.705a.75.75 0 0 1-.395.984L5.22 9.15c-.603.259-1 .43-1.292.594c-.276.155-.396.271-.472.387s-.135.27-.169.585c-.036.333-.037.766-.037 1.422V15a.75.75 0 0 1-1.5 0v-2.901c0-.607 0-1.12.046-1.544c.048-.45.154-.864.408-1.25c.255-.386.594-.646.989-.868c.37-.209.843-.411 1.4-.65l1.112-.476a.75.75 0 0 1 .984.394" />
                                        </svg>
                                        <!-- <svg
                        class="h-6 w-6 text-blue-600 dark:text-blue-400"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 6h16M4 12h16M4 18h16"/>
                      </svg> -->
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                            {{ academic.title }}
                                        </h3>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ academic.institution }}</span>
                                            <span class="hidden sm:block">•</span>
                                            <span>{{ academic.graduation_date }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Akademik',
                                                    mode: 'edit-academic',
                                                    maxWidth: 'lg',
                                                    data: { academic: academic },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Sertifikat -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Sertifikat</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Sertifikat Baru',
                            mode: 'create-certification',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.certifications?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar sertifikat yang diunggah
                    </div>

                    <!-- Academic List -->
                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(certification, index) in profile.certifications" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <!-- Academic Info -->
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg class="h-6 w-6 text-blue-600 dark:text-blue-400" stroke="currentColor"
                                            xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24">
                                            <path fill="currentColor" fill-rule="evenodd"
                                                d="M19 11c2.309 0 3.753 2.5 2.598 4.5a3 3 0 0 1-.598.736v4.955a.5.5 0 0 1-.724.447L19 21l-1.276.638a.5.5 0 0 1-.724-.447v-4.955c-1.721-1.54-1.13-4.365 1.064-5.086c.302-.099.618-.15.936-.15m-7-2H6a1 1 0 0 0-.117 1.993L6 11h6a1 1 0 0 0 .117-1.993zm-4 4H6a1 1 0 1 0 0 2h2a1 1 0 1 0 0-2"
                                                class="duoicon-primary-layer" />
                                            <path fill="currentColor" fill-rule="evenodd"
                                                d="M20 4a2 2 0 0 1 2 2v4c-3.079-2.309-7.504-.419-7.964 3.402A5 5 0 0 0 15 17v3H4a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2z"
                                                class="duoicon-secondary-layer" opacity="0.3" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                <span>
                                                    {{ certification.type }}
                                                </span>
                                            </h3>
                                            <span class="hidden sm:block">-</span>
                                            <span>
                                                {{ certification.subject }}
                                            </span>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ certification.institution }}</span>
                                            <span class="hidden sm:block">•</span>
                                            <span>{{ certification.certification_date }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Akademik',
                                                    mode: 'edit-certification',
                                                    maxWidth: 'lg',
                                                    data: { certification: certification },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Training -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Pelatihan</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Pelatihan Baru',
                            mode: 'create-training',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.training_records?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar pelatihan yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(training, index) in profile.training_records" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path fill="currentColor" fill-rule="evenodd"
                                                d="M9.465 2.82a5.92 5.92 0 0 1 5.07 0l6.692 3.138c1.052.493 1.523 1.564 1.523 2.542s-.47 2.05-1.523 2.543l-1.477.692v4.89c0 1.253-.628 2.463-1.772 3.097c-.752.416-1.74.917-2.78 1.316c-1.027.394-2.164.712-3.198.712s-2.171-.318-3.199-.712c-1.04-.399-2.027-.9-2.779-1.316c-1.144-.634-1.772-1.844-1.772-3.097V11.5q0-.062.01-.122a.75.75 0 0 1 1.059-.8l4.782 2.243a4.42 4.42 0 0 0 3.798 0l6.691-3.137c.403-.189.66-.64.66-1.184s-.257-.995-.66-1.184L13.9 4.179a4.42 4.42 0 0 0-3.798 0l-6.69 3.137a.75.75 0 0 1-.638-1.358zM5.75 12.439v4.187c0 .763.379 1.441.999 1.785c.716.396 1.638.862 2.59 1.227c.963.37 1.899.613 2.661.613s1.698-.243 2.662-.613a21 21 0 0 0 2.59-1.227c.62-.344.998-1.022.998-1.785v-4.187l-3.714 1.741a5.92 5.92 0 0 1-5.071 0z"
                                                clip-rule="evenodd" />
                                            <path fill="currentColor"
                                                d="M6.69 7.705a.75.75 0 0 1-.395.984L5.22 9.15c-.603.259-1 .43-1.292.594c-.276.155-.396.271-.472.387s-.135.27-.169.585c-.036.333-.037.766-.037 1.422V15a.75.75 0 0 1-1.5 0v-2.901c0-.607 0-1.12.046-1.544c.048-.45.154-.864.408-1.25c.255-.386.594-.646.989-.868c.37-.209.843-.411 1.4-.65l1.112-.476a.75.75 0 0 1 .984.394" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                            {{ training.title }}
                                        </h3>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ training.institution }}</span>
                                            <span class="hidden sm:block">•</span>
                                            <span>{{ training.completion_date }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Pelatihan',
                                                    mode: 'edit-training',
                                                    maxWidth: 'lg',
                                                    data: { training: training },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Experience -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Pengalaman</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Pengalaman Baru',
                            mode: 'create-experience',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.experiences?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar pengalaman yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(experience, index) in profile.experiences" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" fill="none"
                                            stroke="currentColor">
                                            <path fill="currentColor" d="M4 8h16v11H4z" opacity="0.3" />
                                            <path fill="currentColor"
                                                d="M20 6h-4V4c0-1.11-.89-2-2-2h-4c-1.11 0-2 .89-2 2v2H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2M10 4h4v2h-4zm10 15H4V8h16z" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                <span>
                                                    {{ experience.position }}
                                                </span>
                                            </h3>
                                            <span class="hidden sm:block">-</span>
                                            <span>
                                                {{ experience.institution }}
                                            </span>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ experience.start_date + ' - ' + experience.end_date }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Pengalaman',
                                                    mode: 'edit-experience',
                                                    maxWidth: 'lg',
                                                    data: { experience: experience },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Specialization -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Spesialisasi</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Spesialisasi Baru',
                            mode: 'create-specialization',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.specializations?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar spesialisasi yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(specialization, index) in profile.specializations" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" fill="none"
                                            stroke="currentColor">
                                            <path fill="currentColor"
                                                d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zm-3.42 14l-.95-4.08l3.16-2.73l-4.17-.36L12 6l-1.62 3.84l-4.17.36l3.16 2.73L8.42 17L12 14.84z" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                <span>
                                                    {{ specialization.type }}
                                                </span>
                                            </h3>
                                            <span class="hidden sm:block">-</span>
                                            <span>
                                                {{ specialization.major }}
                                            </span>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ specialization.minor }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Spesialisasi',
                                                    mode: 'edit-specialization',
                                                    maxWidth: 'lg',
                                                    data: { specialization: specialization },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Community Involvement -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Keterlibatan Komunitas</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Keterlibatan Komunitas Baru',
                            mode: 'create-community-involvement',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.community_involvements?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar keterlibatan komunitas yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(community_involvement, index) in profile.community_involvements" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" viewBox="0 0 28 28">
                                            <path fill="currentColor"
                                                d="M14 1.998a4.25 4.25 0 0 0-.75 8.434V13.5h-4.5a2.25 2.25 0 0 0-2.25 2.25v1.816a4.251 4.251 0 1 0 1.5 0V15.75a.75.75 0 0 1 .75-.75h10.5a.75.75 0 0 1 .75.75v1.816a4.251 4.251 0 1 0 1.5 0V15.75a2.25 2.25 0 0 0-2.25-2.25h-4.5v-3.068A4.251 4.251 0 0 0 14 1.998m-2.75 4.25a2.75 2.75 0 1 1 5.5 0a2.75 2.75 0 0 1-5.5 0M4.5 21.75a2.75 2.75 0 1 1 5.5 0a2.75 2.75 0 0 1-5.5 0M20.75 19a2.75 2.75 0 1 1 0 5.5a2.75 2.75 0 0 1 0-5.5" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                <span>
                                                    {{ community_involvement.position }}
                                                </span>
                                            </h3>
                                            <span class="hidden sm:block">-</span>
                                            <span>
                                                {{ community_involvement.title }}
                                            </span>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ community_involvement.start_date + ' - ' +
                                                community_involvement.end_date
                                                }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Keterlibatan Komunitas',
                                                    mode: 'edit-community-involvement',
                                                    maxWidth: 'lg',
                                                    data: { communityInvolvement: community_involvement },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Honor & Prizes -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Kehormatan dan Hadiah</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Kehormatan dan Hadiah Baru',
                            mode: 'create-honor-prize',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.honor_prizes?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar Kehormatan dan Hadiah yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(honor_prize, index) in profile.honor_prizes" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" viewBox="0 0 24 24">
                                            <path fill="currentColor"
                                                d="m20.87 17.25l-2.71-4.68A6.9 6.9 0 0 0 19 9.25a7 7 0 0 0-14 0a6.9 6.9 0 0 0 .84 3.32l-2.71 4.68a1 1 0 0 0 .87 1.5h2.87l1.46 2.46a1 1 0 0 0 .18.22a1 1 0 0 0 .69.28h.14a1 1 0 0 0 .73-.49L12 17.9l1.93 3.35a1 1 0 0 0 .73.48h.14a1 1 0 0 0 .7-.28a.9.9 0 0 0 .17-.21l1.46-2.46H20a1 1 0 0 0 .87-.5a1 1 0 0 0 0-1.03M9.19 18.78l-.89-1.49a1 1 0 0 0-.85-.49H5.72l1.43-2.48a7 7 0 0 0 3.57 1.84ZM12 14.25a5 5 0 1 1 5-5a5 5 0 0 1-5 5m4.55 2.55a1 1 0 0 0-.85.49l-.89 1.49l-1.52-2.65a7.06 7.06 0 0 0 3.56-1.84l1.43 2.48Z" />
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                <span>
                                                    {{ honor_prize.title }}
                                                </span>
                                            </h3>
                                            <span class="hidden sm:block">-</span>
                                            <span>
                                                {{ honor_prize.institution }}
                                            </span>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{ honor_prize.award_date }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Kehormatan dan Hadiah',
                                                    mode: 'edit-honor-prize',
                                                    maxWidth: 'lg',
                                                    data: { honorPrize: honor_prize },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Keterampilan Bahasa -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Keterampilan Bahasa</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Keterampilan Bahasa Baru',
                            mode: 'create-language-skill',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.language_skills?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar Keterampilan Bahasa yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(language_skill, index) in profile.language_skills" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" viewBox="0 0 24 24">
                                            <g fill="none" stroke="currentColor" stroke-linecap="round"
                                                stroke-width="2">
                                                <path stroke-linejoin="round"
                                                    d="M14 19c3.771 0 5.657 0 6.828-1.172S22 14.771 22 11s0-5.657-1.172-6.828S17.771 3 14 3h-4C6.229 3 4.343 3 3.172 4.172S2 7.229 2 11s0 5.657 1.172 6.828c.653.654 1.528.943 2.828 1.07" />
                                                <path
                                                    d="M14 19c-1.236 0-2.598.5-3.841 1.145c-1.998 1.037-2.997 1.556-3.489 1.225s-.399-1.355-.212-3.404L6.5 17.5" />
                                                <path stroke-linejoin="round"
                                                    d="m5.5 13.5l1-2m0 0l1.106-2.211a1 1 0 0 1 1.788 0L10.5 11.5m-4 0h4m0 0l1 2m1-6h1.982V9c0 .5-.496 1.5-1.487 1.5m3.964-3v2m0 0v4m0-4H18.5" />
                                            </g>
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                {{ language_skill.title }}
                                            </h3>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{languageSkillLevel.find(value => value.value ==
                                                language_skill.reading)?.label }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Keterampilan Bahasa',
                                                    mode: 'edit-language-skill',
                                                    maxWidth: 'lg',
                                                    data: { languageSkill: language_skill },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Keluarga -->
        <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
            <div class="px-4 2xl:px-0">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-base font-medium text-gray-900 dark:text-white md:mb-6">Keluarga</h1>
                    <DefaultButton type="default" @click="
                        openModal({
                            title: 'Keluarga Baru',
                            mode: 'create-family',
                            maxWidth: 'md',
                            data: {
                                profile_id: this.profile.id,
                            },
                        })
                        ">
                        <div class="flex items-center space-x-1 text-xs">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                                class="h-4">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M12 5l0 14" />
                                <path d="M5 12l14 0" />
                            </svg>
                            <div>Tambah</div>
                        </div>
                    </DefaultButton>
                </div>


                <!-- Content Section -->
                <div class="border border-gray-200 rounded-lg dark:border-gray-700">
                    <!-- Empty State -->
                    <div v-if="!profile.families?.length" class="p-4 text-center text-gray-500">
                        Belum ada daftar Keluarga yang diunggah
                    </div>

                    <div v-else class="divide-y divide-gray-200 dark:divide-gray-700">
                        <div v-for="(family, index) in profile.families" :key="index"
                            class="group transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <div class="flex items-center justify-between p-4">
                                <div class="flex flex-1 items-center gap-4">
                                    <!-- Icon Container -->
                                    <div class="p-2 rounded-lg bg-blue-50 dark:bg-gray-700">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-6 w-6 text-blue-600 dark:text-blue-400" viewBox="0 0 48 48">
                                            <g fill="none" stroke="currentColor" stroke-linecap="round"
                                                stroke-width="4">
                                                <path
                                                    d="M10 19s-5.143 2-6 9m34-9s5.143 2 6 9m-26-9s4.8 1.167 6 7m6-7s-4.8 1.167-6 7m-4 8s-4.2.75-6 6m14-6s4.2.75 6 6" />
                                                <circle cx="24" cy="31" r="5" stroke-linejoin="round" />
                                                <circle cx="34" cy="14" r="6" stroke-linejoin="round" />
                                                <circle cx="14" cy="14" r="6" stroke-linejoin="round" />
                                            </g>
                                        </svg>
                                    </div>

                                    <!-- Details -->
                                    <div class="flex-1 min-w-0">
                                        <div class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3">
                                            <h3 class="text-sm font-medium text-gray-900 dark:text-white">
                                                {{ family.name }}
                                            </h3>
                                        </div>
                                        <div
                                            class="mt-1 flex flex-col sm:flex-row sm:items-center sm:gap-3 text-xs text-gray-500 dark:text-gray-400">
                                            <span>{{familyRelationTypes.find(value => value.value ==
                                                family.relation)?.label
                                                }}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Dropdown Menu -->
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button type="button"
                                            class="ml-4 p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white">
                                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <button
                                            class="flex w-full items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600"
                                            @click="
                                                openModal({
                                                    title: 'Edit Keluarga',
                                                    mode: 'edit-family',
                                                    maxWidth: 'lg',
                                                    data: { family: family },
                                                })
                                                ">
                                            <svg class="h-4 w-4 mr-3 text-gray-500 dark:text-gray-400"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                            </svg>
                                            Edit
                                        </button>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
            <template v-slot="{ propertyModal }">
                <AttachmentForm
                    v-if="propertyModal?.mode == 'create-attachment' || propertyModal?.mode == 'edit-attachment'"
                    :propertyModal="propertyModal" @close="closeModal()"></AttachmentForm>
                <AcademicForm v-if="propertyModal?.mode == 'create-academic' || propertyModal?.mode == 'edit-academic'"
                    :propertyModal="propertyModal" @close="closeModal()"></AcademicForm>
                <CertificationForm
                    v-if="propertyModal?.mode == 'create-certification' || propertyModal?.mode == 'edit-certification'"
                    :propertyModal="propertyModal" @close="closeModal()"></CertificationForm>
                <TrainingForm v-if="propertyModal?.mode == 'create-training' || propertyModal?.mode == 'edit-training'"
                    :propertyModal="propertyModal" @close="closeModal()"></TrainingForm>
                <SpecializationForm
                    v-if="propertyModal?.mode == 'create-specialization' || propertyModal?.mode == 'edit-specialization'"
                    :propertyModal="propertyModal" @close="closeModal()"></SpecializationForm>
                <ExperienceForm
                    v-if="propertyModal?.mode == 'create-experience' || propertyModal?.mode == 'edit-experience'"
                    :propertyModal="propertyModal" @close="closeModal()"></ExperienceForm>
                <LanguageSkillForm
                    v-if="propertyModal?.mode == 'create-language-skill' || propertyModal?.mode == 'edit-language-skill'"
                    :propertyModal="propertyModal" @close="closeModal()"></LanguageSkillForm>
                <CommunityInvolvementForm
                    v-if="propertyModal?.mode == 'create-community-involvement' || propertyModal?.mode == 'edit-community-involvement'"
                    :propertyModal="propertyModal" @close="closeModal()"></CommunityInvolvementForm>
                <FamilyForm v-if="propertyModal?.mode == 'create-family' || propertyModal?.mode == 'edit-family'"
                    :propertyModal="propertyModal" @close="closeModal()"></FamilyForm>
                <HonorPrizeForm
                    v-if="propertyModal?.mode == 'create-honor-prize' || propertyModal?.mode == 'edit-honor-prize'"
                    :propertyModal="propertyModal" @close="closeModal()"></HonorPrizeForm>
            </template>
        </Modal>
    </div>

</template>