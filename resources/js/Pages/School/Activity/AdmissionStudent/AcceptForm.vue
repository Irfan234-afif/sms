<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import axios from 'axios';
import { ElNotification } from 'element-plus';
</script>
<script>
export default {
    props: {
        propertyModal: {
            type: Object,
            default: null,
        },
    },
    data() {
        return {
            process: false,
            loaded: true,
            isValid: false,
            mode: this.propertyModal.mode,
            actionUrl: this.propertyModal.data.actionUrl,
            content: this.propertyModal.data,
        };
    },
    watch: {
        //
    },
    methods: {
        submit() {
            this.process = true;

            axios
                .post(this.actionUrl, {
                    headers: { 'Content-Type': 'application/json' },
                })
                .then((response) => {
                    if (response.data.status === 'success') {
                        ElNotification({
                            title: 'Berhasil',
                            message: response.data.message,
                            type: 'success',
                        });

                        setTimeout(() => {
                            this.close();
                            this.$inertia.reload();
                        }, 2000);
                    } else if (response.data.status === 'error') {
                        ElNotification({
                            title: 'Error',
                            message: response.data.message,
                            type: 'error',
                        });
                    }
                })
                .catch((error) => {
                    let errorMessage = 'Terjadi kesalahan.';

                    if (error.response) {
                        switch (error.response.status) {
                            case 404:
                                errorMessage = error.response.data?.message || 'Data tidak ditemukan.';
                                break;
                            default:
                                errorMessage = error.response.data?.message || errorMessage;
                        }
                    }

                    ElNotification({ title: 'Error', message: errorMessage, type: 'error' });
                })
                .finally(() => {
                    this.process = false;
                });
        },
        close() {
            this.$emit('close');
        },
    },
};
</script>
<template>
    <div class="space-y-6 p-5 text-center">
        <svg
            class="mx-auto mb-4 h-10 w-10 text-gray-400 dark:text-gray-200"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 20 20"
        >
            <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
            />
        </svg>
        <h3 class="mb-5 text-base font-normal text-gray-500 dark:text-gray-400">
            {{ content.description }}
        </h3>
        <div class="flex justify-center space-x-3">
            <DefaultButton
                v-if="mode == 'enrolled-form'"
                type="green"
                class="w-full md:w-1/2"
                @click="submit()"
                :disabled="process"
            >
                Ya, Selesaikan Pendaftaran
            </DefaultButton>
            <DefaultButton
                v-if="mode == 'accepted-form'"
                type="green"
                class="w-full md:w-1/2"
                @click="submit()"
                :disabled="process"
            >
                Ya, Terima Sebagai Siswa
            </DefaultButton>
            <DefaultButton
                v-if="mode == 'rejected-form'"
                type="red"
                class="w-full md:w-1/2"
                @click="submit()"
                :disabled="process"
            >
                Ya, Tolak Sebagai Siswa
            </DefaultButton>
            <DefaultButton type="light" class="w-full md:w-1/2" @click="close" :disabled="process"
                >Tidak, Batalkan
            </DefaultButton>
        </div>
    </div>
</template>
