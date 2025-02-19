<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import midtrans from '@/Configs/midtrans';
import axios from 'axios';
import { ElNotification } from 'element-plus';
midtrans.init();
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
            transaction: this.propertyModal?.data?.transaction,
        };
    },
    watch: {
        //
    },
    methods: {
        submit() {
            this.process = true;

            let transaction_payment = this.transaction.payments[0];

            if (transaction_payment.type == 'ONLINE') {
                let snap_token = transaction_payment.options.gateway_token;

                try {
                    window.snap.pay(snap_token, {
                        onSuccess: (gateway_response) => {
                            console.log(gateway_response);
                            this.processPayment(
                                transaction_payment,
                                gateway_response,
                            );

                            ElNotification({
                                title: 'Pembayaran Berhasil',
                                message:
                                    'Terima kasih! Pembayaran Anda telah berhasil diproses.',
                                type: 'success',
                            });

                            this.process = false;
                        },
                        onPending: (gateway_response) => {
                            console.log(gateway_response);
                            this.processPayment(
                                transaction_payment,
                                gateway_response,
                            );

                            ElNotification({
                                title: 'Menunggu Pembayaran',
                                message:
                                    'Pembayaran Anda tertunda. Silakan selesaikan transaksi segera.',
                                type: 'warning',
                            });

                            this.process = false;
                        },
                        onError: (gateway_response) => {
                            console.log(gateway_response);
                            this.processPayment(
                                transaction_payment,
                                gateway_response,
                            );

                            ElNotification({
                                title: 'Pembayaran Gagal',
                                message:
                                    'Terjadi kesalahan dalam proses pembayaran. Silakan coba lagi.',
                                type: 'error',
                            });

                            this.process = false;
                        },
                        onClose: (gateway_response) => {
                            console.log(gateway_response);

                            ElNotification({
                                title: 'Transaksi Ditutup',
                                message: 'Anda telah menutup pembayaran.',
                                type: 'info',
                            });

                            this.process = false;
                        },
                    });
                } catch (error) {
                    this.process = true;

                    console.error(error);
                }
            }
        },
        processPayment(transaction_payment, gateway_response) {
            this.process = true;

            axios
                .post(
                    route('guardian.transactionPayment.processPayment'),
                    {
                        transaction_payment: transaction_payment.uuid,
                        gateway_response: gateway_response,
                    },
                    {
                        headers: { 'Content-Type': 'application/json' },
                    },
                )
                .then((response) => {
                    console.log(response.data.status);
                    if (response.data.status) {
                        setTimeout(() => {
                            this.close();
                            this.$inertia.reload();
                        }, 2000);
                    }
                })
                .catch((error) => {
                    ElNotification({
                        title: 'Error',
                        message: error,
                        type: 'error',
                    });
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
    <div class="space-y-6 p-5">
        <h2 class="border-b pb-4 text-lg font-bold text-gray-900">
            {{ propertyModal?.title }}
        </h2>
        <div class="space-y-4">
            <div class="space-y-4 border-gray-200 dark:border-gray-700">
                <h4
                    class="text-base font-semibold text-gray-900 dark:text-white"
                >
                    Informasi
                </h4>
                <div
                    class="space-y-4 rounded-lg border border-gray-100 bg-gray-50 p-6 text-sm dark:border-gray-700 dark:bg-gray-800 md:mb-8"
                >
                    <dl class="items-center justify-between gap-4 sm:flex">
                        <dt
                            class="mb-1 font-normal text-gray-500 dark:text-gray-400 sm:mb-0"
                        >
                            Order ID
                        </dt>
                        <dd
                            class="font-medium text-gray-900 dark:text-white sm:text-end"
                        >
                            {{ transaction.reference_number }}
                        </dd>
                    </dl>
                    <dl class="items-center justify-between gap-4 sm:flex">
                        <dt
                            class="mb-1 font-normal text-gray-500 dark:text-gray-400 sm:mb-0"
                        >
                            Jenis Transaksi
                        </dt>
                        <dd
                            class="font-medium text-gray-900 dark:text-white sm:text-end"
                        >
                            {{ transaction.sub_type_label }}
                        </dd>
                    </dl>
                    <dl class="items-center justify-between gap-4 sm:flex">
                        <dt
                            class="mb-1 font-normal text-gray-500 dark:text-gray-400 sm:mb-0"
                        >
                            Tempo Pembayaran
                        </dt>
                        <dd
                            class="font-medium text-gray-900 dark:text-white sm:text-end"
                        >
                            {{ transaction.due_date_label }}
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="space-y-4">
                <h4
                    class="text-base font-semibold text-gray-900 dark:text-white"
                >
                    Tagihan
                </h4>
                <div
                    class="space-y-4 rounded-lg border border-gray-100 bg-gray-50 p-6 text-sm dark:border-gray-700 dark:bg-gray-800"
                >
                    <dl class="flex items-center justify-between gap-4">
                        <dt
                            class="font-normal text-gray-500 dark:text-gray-400"
                        >
                            Harga
                        </dt>
                        <dd class="font-medium text-gray-900 dark:text-white">
                            IDR {{ transaction.total_amount }}
                        </dd>
                    </dl>
                    <dl class="flex items-center justify-between gap-4">
                        <dt
                            class="font-normal text-gray-500 dark:text-gray-400"
                        >
                            Diskon
                        </dt>
                        <dd class="font-medium text-green-500 dark:text-white">
                            -
                        </dd>
                    </dl>
                    <dl
                        class="flex items-center justify-between gap-4 border-t border-gray-200 pt-2 text-base dark:border-gray-700"
                    >
                        <dt class="font-bold text-gray-900 dark:text-white">
                            Total
                        </dt>
                        <dd class="font-bold text-gray-900 dark:text-white">
                            IDR {{ transaction.bill_amount }}
                        </dd>
                    </dl>
                </div>
            </div>
            <div
                v-if="transaction.is_paid_off"
                class="mb-4 flex items-center rounded-lg bg-green-50 p-4 text-sm text-green-800 dark:bg-gray-800 dark:text-green-400"
                role="alert"
            >
                <svg
                    class="me-3 inline h-4 w-4 shrink-0"
                    aria-hidden="true"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                >
                    <path
                        d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
                    />
                </svg>
                <span class="sr-only">Info</span>
                <div>
                    <span class="t font-medium">Tagihan lunas!</span>
                    Pembayaran telah diterima. Terima kasih telah menyelesaikan
                    pembayaran.
                </div>
            </div>
        </div>

        <div class="flex justify-end space-x-3" v-if="!transaction.is_paid_off">
            <DefaultButton
                class="w-full"
                type="light"
                @click="close"
                :disabled="process"
            >
                Batal
            </DefaultButton>

            <DefaultButton
                class="w-full"
                type="default"
                @click="submit"
                :disabled="process"
            >
                Selesaikan Pembayaran
            </DefaultButton>
        </div>
        <div class="flex justify-end space-x-3" v-else>
            <DefaultButton class="w-full" type="default" @click="close">
                Tutup
            </DefaultButton>
        </div>
    </div>
</template>
