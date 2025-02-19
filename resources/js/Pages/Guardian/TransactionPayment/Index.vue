<script setup>
import Pagination from '@/Components/Pagination.vue';
import Badge from '@/Components/Badge.vue';
import Search from '@/Components/Search.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import GuardianLayout from '@/Layouts/GuardianLayout.vue';
import GuardianSidebar from '@/Layouts/Sidebars/GuardianSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import PaymentForm from '../TransactionPayment/PaymentForm.vue';
</script>

<script>
export default {
    props: {
        search_params: Object,
        transactions: Object,
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
    <Head title="Wali" />

    <GuardianLayout>
        <template #sidebar>
            <GuardianSidebar />
        </template>
        <template #content>
            <!-- Data -->
            <section class="bg-gray-50 antialiased dark:bg-gray-900">
                <div
                    class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg"
                >
                    <div
                        class="flex flex-col space-y-3 p-4 md:flex-row md:items-center md:justify-between md:space-x-4 md:space-y-0"
                    >
                        <div class="flex flex-1 items-center space-x-2">
                            <h5>
                                <span class="text-lg font-bold text-gray-900"
                                    >Tagihan & Pembayaran</span
                                >
                            </h5>
                        </div>
                    </div>
                    <!-- Filter Search -->
                    <div
                        class="mx-4 flex flex-col items-stretch justify-between space-y-3 border-t py-4 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0"
                    >
                        <div class="w-full md:w-1/2">
                            <Search :search_params="search_params" />
                        </div>
                    </div>
                    <!-- Table List -->
                    <div class="overflow-x-auto">
                        <table
                            class="w-full text-left text-sm text-gray-500 dark:text-gray-400"
                        >
                            <thead
                                class="bg-gray-50 text-xs uppercase text-gray-700 dark:bg-gray-700 dark:text-gray-400"
                            >
                                <tr>
                                    <th scope="col" class="p-4" v-if="false">
                                        <div class="flex items-center">
                                            <input
                                                id="checkbox-all"
                                                type="checkbox"
                                                class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                                            />
                                            <label
                                                for="checkbox-all"
                                                class="sr-only"
                                                >checkbox</label
                                            >
                                        </div>
                                    </th>
                                    <th scope="col" class="p-4">Order ID</th>
                                    <th scope="col" class="p-4">
                                        Jenis Transaksi
                                    </th>
                                    <th scope="col" class="p-4">
                                        Total Tagihan
                                    </th>
                                    <th scope="col" class="p-4">
                                        Tempo Pembayaran
                                    </th>
                                    <th scope="col" class="p-4">Status</th>
                                    <th scope="col" class="p-4"></th>
                                </tr>
                            </thead>
                            <tbody class="text-xs">
                                <tr
                                    v-for="(
                                        transaction, index
                                    ) in transactions.data"
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
                                            <label
                                                for="checkbox-table-search"
                                                class="sr-only"
                                                >checkbox</label
                                            >
                                        </div>
                                    </td>
                                    <th
                                        scope="row"
                                        class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                                    >
                                        <div class="flex items-center">
                                            {{ transaction.reference_number }}
                                        </div>
                                    </th>
                                    <td class="whitespace-nowrap px-4 py-3">
                                        <div
                                            class="bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-300 rounded py-0.5 font-medium"
                                        >
                                            {{ transaction.sub_type_label }}
                                        </div>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3">
                                        <div
                                            class="bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-300 rounded py-0.5 font-medium"
                                        >
                                            IDR {{ transaction.bill_amount }}
                                        </div>
                                    </td>
                                    <td
                                        class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                                    >
                                        <div v-if="transaction.due_date">
                                            {{ transaction.due_date_label }}
                                        </div>
                                        <div v-else>
                                            <Badge type="dark">-</Badge>
                                        </div>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3">
                                        <Badge
                                            v-if="transaction.is_paid_off"
                                            type="green"
                                            >{{
                                                transaction.paid_off_label
                                            }}</Badge
                                        >
                                        <Badge v-else type="yellow">{{
                                            transaction.paid_off_label
                                        }}</Badge>
                                    </td>
                                    <td
                                        class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                                    >
                                        <div
                                            class="flex items-center justify-end space-x-3"
                                        >
                                            <OutlineButton
                                                type="yellow"
                                                @click="
                                                    openModal({
                                                        title: 'Tagihan Pembayaran',
                                                        mode: 'payment-form',
                                                        maxWidth: 'lg',
                                                        data: {
                                                            transaction:
                                                                transaction,
                                                        },
                                                    })
                                                "
                                            >
                                                <div
                                                    class="flex items-center space-x-1"
                                                >
                                                    <svg
                                                        xmlns="http://www.w3.org/2000/svg"
                                                        viewBox="0 0 24 24"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        stroke-width="2"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round"
                                                        class="h-4"
                                                    >
                                                        <path
                                                            stroke="none"
                                                            d="M0 0h24v24H0z"
                                                            fill="none"
                                                        />
                                                        <path
                                                            d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0"
                                                        />
                                                        <path
                                                            d="M21 21l-6 -6"
                                                        />
                                                    </svg>
                                                    <div>Lihat</div>
                                                </div>
                                            </OutlineButton>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- Pagination -->
                    <Pagination
                        :search_params="search_params"
                        :meta="transactions.meta"
                        :links="transactions.links"
                    />
                </div>
            </section>
            <!-- Modal -->
            <Modal
                :show="showModal"
                :property="propertyModal"
                :maxWidth="propertyModal?.maxWidth"
                @close="closeModal"
            >
                <template v-slot="{ propertyModal }">
                    <PaymentForm
                        v-if="propertyModal?.mode == 'payment-form'"
                        :propertyModal="propertyModal"
                        @close="closeModal()"
                    />
                </template>
            </Modal>
        </template>
    </GuardianLayout>
</template>
