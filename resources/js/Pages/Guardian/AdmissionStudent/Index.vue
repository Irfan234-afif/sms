<script setup>
import Pagination from '@/Components/Pagination.vue';
import Badge from '@/Components/Badge.vue';
import Search from '@/Components/Search.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import GuardianLayout from '@/Layouts/GuardianLayout.vue';
import GuardianSidebar from '@/Layouts/Sidebars/GuardianSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import CheckoutForm from '../AdmissionStudent/CheckoutForm.vue';
</script>

<script>
export default {
    props: {
        search_params: Object,
        product: Object,
        admission_students: Object,
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
                <div class="relative overflow-hidden bg-white shadow-md dark:bg-gray-800 sm:rounded-lg">
                    <div
                        class="flex flex-col space-y-3 p-4 md:flex-row md:items-center md:justify-between md:space-x-4 md:space-y-0"
                    >
                        <div class="flex flex-1 items-center space-x-2">
                            <h5>
                                <span class="text-lg font-bold text-gray-900">Pendaftaran Siswa Baru</span>
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
                        <div
                            class="flex w-full flex-shrink-0 flex-col items-stretch justify-end space-y-2 md:w-auto md:flex-row md:items-center md:space-x-3 md:space-y-0"
                        >
                            <DefaultButton
                                type="default"
                                @click="
                                    openModal({
                                        title: 'Beli Formulir',
                                        mode: 'purchase-form',
                                        maxWidth: 'md',
                                        data: {
                                            product: product.data,
                                        },
                                    })
                                "
                            >
                                <div class="flex items-center space-x-1 text-sm">
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
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                                        <path
                                            d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"
                                        />
                                        <path d="M9 17h6" />
                                        <path d="M9 13h6" />
                                    </svg>
                                    <div>Beli Formulir</div>
                                </div>
                            </DefaultButton>
                            <button
                                v-if="false"
                                id="filterDropdownButton"
                                data-dropdown-toggle="filterDropdown"
                                class="hover:text-primary-700 flex w-full items-center justify-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-900 hover:bg-gray-100 focus:z-10 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:border-gray-600 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-700 md:w-auto"
                                type="button"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    aria-hidden="true"
                                    class="-ml-1 mr-1.5 h-4 w-4 text-gray-400"
                                    viewbox="0 0 20 20"
                                    fill="currentColor"
                                >
                                    <path
                                        fill-rule="evenodd"
                                        d="M3 3a1 1 0 011-1h12a1 1 0 011 1v3a1 1 0 01-.293.707L12 11.414V15a1 1 0 01-.293.707l-2 2A1 1 0 018 17v-5.586L3.293 6.707A1 1 0 013 6V3z"
                                        clip-rule="evenodd"
                                    />
                                </svg>
                                Opsi Saring
                                <svg
                                    class="-mr-1 ml-1.5 h-5 w-5"
                                    fill="currentColor"
                                    viewbox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg"
                                    aria-hidden="true"
                                >
                                    <path
                                        clip-rule="evenodd"
                                        fill-rule="evenodd"
                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                    />
                                </svg>
                            </button>
                            <div
                                id="filterDropdown"
                                class="right-0 z-10 hidden w-80 rounded-lg bg-white px-3 pt-1 shadow dark:bg-gray-700"
                            >
                                <div class="flex items-center justify-between pt-2">
                                    <h6 class="text-sm font-medium text-black dark:text-white">Filters</h6>
                                    <div class="flex items-center space-x-3">
                                        <a
                                            href="#"
                                            class="text-primary-600 dark:text-primary-500 flex items-center text-sm font-medium hover:underline"
                                            >Save view</a
                                        >
                                        <a
                                            href="#"
                                            class="text-primary-600 dark:text-primary-500 flex items-center text-sm font-medium hover:underline"
                                            >Clear all</a
                                        >
                                    </div>
                                </div>
                                <div class="pb-2 pt-3">
                                    <label for="input-group-search" class="sr-only">Search</label>
                                    <div class="relative">
                                        <div
                                            class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4"
                                        >
                                            <svg
                                                class="h-4 w-4 text-gray-500 dark:text-gray-400"
                                                aria-hidden="true"
                                                fill="currentColor"
                                                viewbox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                                                    clip-rule="evenodd"
                                                />
                                            </svg>
                                        </div>
                                        <input
                                            type="text"
                                            id="input-group-search"
                                            class="focus:ring-primary-500 focus:border-primary-500 dark:focus:ring-primary-500 dark:focus:border-primary-500 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2 pl-10 text-sm text-gray-900 dark:border-gray-500 dark:bg-gray-600 dark:text-white dark:placeholder-gray-400"
                                            placeholder="Search keywords..."
                                        />
                                    </div>
                                </div>
                                <div
                                    id="accordion-flush"
                                    data-accordion="collapse"
                                    data-active-classes="text-black dark:text-white"
                                    data-inactive-classes="text-gray-500 dark:text-gray-400"
                                >
                                    <!-- Category -->
                                    <h2 id="category-heading">
                                        <button
                                            type="button"
                                            class="flex w-full items-center justify-between border-b border-gray-200 px-1.5 py-2 text-left text-sm font-medium text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700"
                                            data-accordion-target="#category-body"
                                            aria-expanded="true"
                                            aria-controls="category-body"
                                        >
                                            <span>Category</span>
                                            <svg
                                                aria-hidden="true"
                                                data-accordion-icon=""
                                                class="h-5 w-5 shrink-0 rotate-180"
                                                fill="currentColor"
                                                viewbox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                />
                                            </svg>
                                        </button>
                                    </h2>
                                    <div id="category-body" class="hidden" aria-labelledby="category-heading">
                                        <div class="border-b border-gray-200 py-2 font-light dark:border-gray-600">
                                            <ul class="space-y-2">
                                                <li class="flex items-center">
                                                    <input
                                                        id="apple"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="apple"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Apple (56)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="microsoft"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="microsoft"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Microsoft (45)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="logitech"
                                                        type="checkbox"
                                                        value=""
                                                        checked=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="logitech"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Logitech (97)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="sony"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="sony"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Sony (234)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="asus"
                                                        type="checkbox"
                                                        value=""
                                                        checked=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="asus"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Asus (97)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="dell"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="dell"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Dell (56)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="msi"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="msi"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >MSI (97)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="canon"
                                                        type="checkbox"
                                                        value=""
                                                        checked=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="canon"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Canon (49)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="benq"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="benq"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >BenQ (23)</label
                                                    >
                                                </li>
                                                <li class="flex items-center">
                                                    <input
                                                        id="razor"
                                                        type="checkbox"
                                                        value=""
                                                        class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 rounded border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-500 dark:bg-gray-600 dark:ring-offset-gray-700"
                                                    />
                                                    <label
                                                        for="razor"
                                                        class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100"
                                                        >Razor (49)</label
                                                    >
                                                </li>
                                                <a
                                                    href="#"
                                                    class="text-primary-600 dark:text-primary-500 flex items-center text-sm font-medium hover:underline"
                                                    >View all</a
                                                >
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- Price -->
                                    <h2 id="price-heading">
                                        <button
                                            type="button"
                                            class="flex w-full items-center justify-between border-b border-gray-200 px-1.5 py-2 text-left text-sm font-medium text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700"
                                            data-accordion-target="#price-body"
                                            aria-expanded="true"
                                            aria-controls="price-body"
                                        >
                                            <span>Price</span>
                                            <svg
                                                aria-hidden="true"
                                                data-accordion-icon=""
                                                class="h-5 w-5 shrink-0 rotate-180"
                                                fill="currentColor"
                                                viewbox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                />
                                            </svg>
                                        </button>
                                    </h2>
                                    <div id="price-body" class="hidden" aria-labelledby="price-heading">
                                        <div
                                            class="flex items-center space-x-3 border-b border-gray-200 py-2 font-light dark:border-gray-600"
                                        >
                                            <select
                                                id="price-from"
                                                class="focus:ring-primary-500 focus:border-primary-500 dark:focus:ring-primary-500 dark:focus:border-primary-500 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
                                            >
                                                <option disabled="" selected="">From</option>
                                                <option>$500</option>
                                                <option>$2500</option>
                                                <option>$5000</option></select
                                            ><select
                                                id="price-to"
                                                class="focus:ring-primary-500 focus:border-primary-500 dark:focus:ring-primary-500 dark:focus:border-primary-500 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
                                            >
                                                <option disabled="" selected="">To</option>
                                                <option>$500</option>
                                                <option>$2500</option>
                                                <option>$5000</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- Worldwide Shipping -->
                                    <h2 id="worldwide-shipping-heading">
                                        <button
                                            type="button"
                                            class="flex w-full items-center justify-between border-b border-gray-200 px-1.5 py-2 text-left text-sm font-medium text-gray-500 hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700"
                                            data-accordion-target="#worldwide-shipping-body"
                                            aria-expanded="true"
                                            aria-controls="worldwide-shipping-body"
                                        >
                                            <span>Worldwide Shipping</span>
                                            <svg
                                                aria-hidden="true"
                                                data-accordion-icon=""
                                                class="h-5 w-5 shrink-0 rotate-180"
                                                fill="currentColor"
                                                viewbox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                />
                                            </svg>
                                        </button>
                                    </h2>
                                    <div
                                        id="worldwide-shipping-body"
                                        class="hidden"
                                        aria-labelledby="worldwide-shipping-heading"
                                    >
                                        <div
                                            class="space-y-2 border-b border-gray-200 py-2 font-light dark:border-gray-600"
                                        >
                                            <label class="relative flex cursor-pointer items-center">
                                                <input
                                                    type="checkbox"
                                                    value=""
                                                    class="peer sr-only"
                                                    name="shipping"
                                                    checked=""
                                                />
                                                <div
                                                    class="peer-focus:ring-primary-300 dark:peer-focus:ring-primary-800 peer-checked:bg-primary-600 peer h-5 w-9 rounded-full bg-gray-200 after:absolute after:left-[2px] after:top-[2px] after:h-4 after:w-4 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 dark:border-gray-600 dark:bg-gray-700"
                                                ></div>
                                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300"
                                                    >North America</span
                                                >
                                            </label>
                                            <label class="relative flex cursor-pointer items-center">
                                                <input type="checkbox" value="" class="peer sr-only" name="shipping" />
                                                <div
                                                    class="peer-focus:ring-primary-300 dark:peer-focus:ring-primary-800 peer-checked:bg-primary-600 peer h-5 w-9 rounded-full bg-gray-200 after:absolute after:left-[2px] after:top-[2px] after:h-4 after:w-4 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 dark:border-gray-600 dark:bg-gray-700"
                                                ></div>
                                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300"
                                                    >South America</span
                                                >
                                            </label>
                                            <label class="relative flex cursor-pointer items-center">
                                                <input type="checkbox" value="" class="peer sr-only" name="shipping" />
                                                <div
                                                    class="peer-focus:ring-primary-300 dark:peer-focus:ring-primary-800 peer-checked:bg-primary-600 peer h-5 w-9 rounded-full bg-gray-200 after:absolute after:left-[2px] after:top-[2px] after:h-4 after:w-4 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 dark:border-gray-600 dark:bg-gray-700"
                                                ></div>
                                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300"
                                                    >Asia</span
                                                >
                                            </label>
                                            <label class="relative flex cursor-pointer items-center">
                                                <input
                                                    type="checkbox"
                                                    value=""
                                                    class="peer sr-only"
                                                    name="shipping"
                                                    checked=""
                                                />
                                                <div
                                                    class="peer-focus:ring-primary-300 dark:peer-focus:ring-primary-800 peer-checked:bg-primary-600 peer h-5 w-9 rounded-full bg-gray-200 after:absolute after:left-[2px] after:top-[2px] after:h-4 after:w-4 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 dark:border-gray-600 dark:bg-gray-700"
                                                ></div>
                                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300"
                                                    >Australia</span
                                                >
                                            </label>
                                            <label class="relative flex cursor-pointer items-center">
                                                <input type="checkbox" value="" class="peer sr-only" name="shipping" />
                                                <div
                                                    class="peer-focus:ring-primary-300 dark:peer-focus:ring-primary-800 peer-checked:bg-primary-600 peer h-5 w-9 rounded-full bg-gray-200 after:absolute after:left-[2px] after:top-[2px] after:h-4 after:w-4 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 dark:border-gray-600 dark:bg-gray-700"
                                                ></div>
                                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300"
                                                    >Europe</span
                                                >
                                            </label>
                                        </div>
                                    </div>
                                    <!-- Rating -->
                                    <h2 id="rating-heading">
                                        <button
                                            type="button"
                                            class="flex w-full items-center justify-between px-1.5 py-2 text-left text-sm font-medium text-gray-500 hover:bg-gray-50 dark:text-gray-400 dark:hover:bg-gray-700"
                                            data-accordion-target="#rating-body"
                                            aria-expanded="true"
                                            aria-controls="rating-body"
                                        >
                                            <span>Rating</span>
                                            <svg
                                                aria-hidden="true"
                                                data-accordion-icon=""
                                                class="h-5 w-5 shrink-0 rotate-180"
                                                fill="currentColor"
                                                viewbox="0 0 20 20"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                />
                                            </svg>
                                        </button>
                                    </h2>
                                    <div id="rating-body" class="hidden" aria-labelledby="rating-heading">
                                        <div
                                            class="space-y-2 border-b border-gray-200 py-2 font-light dark:border-gray-600"
                                        >
                                            <div class="flex items-center">
                                                <input
                                                    id="five-stars"
                                                    type="radio"
                                                    value=""
                                                    name="rating"
                                                    class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-700"
                                                />
                                                <label for="five-stars" class="ml-2 flex items-center">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>First star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Second star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Third star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fourth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fifth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                </label>
                                            </div>
                                            <div class="flex items-center">
                                                <input
                                                    id="four-stars"
                                                    type="radio"
                                                    value=""
                                                    name="rating"
                                                    class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-700"
                                                />
                                                <label for="four-stars" class="ml-2 flex items-center">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>First star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Second star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Third star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fourth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fifth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                </label>
                                            </div>
                                            <div class="flex items-center">
                                                <input
                                                    id="three-stars"
                                                    type="radio"
                                                    value=""
                                                    name="rating"
                                                    checked=""
                                                    class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-700"
                                                />
                                                <label for="three-stars" class="ml-2 flex items-center">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>First star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Second star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Third star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fourth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fifth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                </label>
                                            </div>
                                            <div class="flex items-center">
                                                <input
                                                    id="two-stars"
                                                    type="radio"
                                                    value=""
                                                    name="rating"
                                                    class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-700"
                                                />
                                                <label for="two-stars" class="ml-2 flex items-center">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>First star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Second star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Third star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fourth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fifth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                </label>
                                            </div>
                                            <div class="flex items-center">
                                                <input
                                                    id="one-star"
                                                    type="radio"
                                                    value=""
                                                    name="rating"
                                                    class="text-primary-600 focus:ring-primary-500 dark:focus:ring-primary-600 h-4 w-4 border-gray-300 bg-gray-100 focus:ring-2 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-700"
                                                />
                                                <label for="one-star" class="ml-2 flex items-center">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-yellow-400"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>First star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Second star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Third star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fourth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                    <svg
                                                        aria-hidden="true"
                                                        class="h-5 w-5 text-gray-300 dark:text-gray-500"
                                                        fill="currentColor"
                                                        viewbox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <title>Fifth star</title>
                                                        <path
                                                            d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                                        />
                                                    </svg>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div v-if="false" class="flex w-full items-center space-x-3 md:w-auto">
                                <button
                                    id="actionsDropdownButton"
                                    data-dropdown-toggle="actionsDropdown"
                                    class="hover:text-primary-700 flex w-full items-center justify-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-900 hover:bg-gray-100 focus:z-10 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-700 md:w-auto"
                                    type="button"
                                >
                                    Actions
                                    <svg
                                        class="-mr-1 ml-1.5 h-5 w-5"
                                        fill="currentColor"
                                        viewbox="0 0 20 20"
                                        xmlns="http://www.w3.org/2000/svg"
                                        aria-hidden="true"
                                    >
                                        <path
                                            clip-rule="evenodd"
                                            fill-rule="evenodd"
                                            d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                        />
                                    </svg>
                                </button>
                                <div
                                    id="actionsDropdown"
                                    class="z-10 hidden w-44 divide-y divide-gray-100 rounded bg-white shadow dark:divide-gray-600 dark:bg-gray-700"
                                >
                                    <ul
                                        class="py-1 text-sm text-gray-700 dark:text-gray-200"
                                        aria-labelledby="actionsDropdownButton"
                                    >
                                        <li>
                                            <a
                                                href="#"
                                                class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                                                >Mass Edit</a
                                            >
                                        </li>
                                    </ul>
                                    <div class="py-1">
                                        <a
                                            href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-600 dark:hover:text-white"
                                            >Delete all</a
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Table List -->
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm text-gray-500 dark:text-gray-400">
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
                                            <label for="checkbox-all" class="sr-only">checkbox</label>
                                        </div>
                                    </th>
                                    <th scope="col" class="p-4">Siswa</th>
                                    <th scope="col" class="p-4">Nomor Pendaftaran</th>
                                    <th scope="col" class="p-4">Terdaftar di Sekolah</th>
                                    <th scope="col" class="p-4">Tanggal Terdaftar</th>
                                    <th scope="col" class="p-4">Terakhir di Perbarui</th>
                                    <th scope="col" class="p-4">Status</th>
                                    <th scope="col" class="p-4"></th>
                                </tr>
                            </thead>
                            <tbody class="text-xs">
                                <tr
                                    v-for="(admission_student, index) in admission_students.data"
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
                                    <th
                                        scope="row"
                                        class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white"
                                    >
                                        <div class="flex items-center">
                                            {{ admission_student.name }}
                                        </div>
                                    </th>
                                    <td class="whitespace-nowrap px-4 py-3">
                                        <div
                                            class="bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-300 rounded py-0.5 font-medium"
                                        >
                                            {{ admission_student.registration_number }}
                                        </div>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                                        <div class="flex items-center">
                                            {{ admission_student.school.area.name }}
                                            > Kelas
                                            {{ admission_student.school_grade.title }}
                                        </div>
                                        <div>
                                            {{ admission_student.school_year.name }}
                                        </div>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                                        <div v-if="admission_student.submitted_at">
                                            {{ admission_student.submitted_at_label }}
                                        </div>
                                        <div v-else>
                                            <Badge type="dark">Belum Terdaftar</Badge>
                                        </div>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3">
                                        {{ admission_student.updated_at }}
                                    </td>
                                    <td class="px-4 py-3">
                                        <Badge v-if="admission_student.status == 'NEW'" type="default">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'DRAFT'" type="dark">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'PENDING'" type="yellow">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'VERIFIED'" type="purple">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'UNVERIFIED'" type="red">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'ACCEPTED'" type="green">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'REJECTED'" type="red">{{
                                            admission_student.status_label
                                        }}</Badge>
                                        <Badge v-if="admission_student.status == 'ENROLLED'" type="dark">{{
                                            admission_student.status_label
                                        }}</Badge>
                                    </td>
                                    <td class="whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white">
                                        <div class="flex items-center justify-end space-x-3">
                                            <Link
                                                v-if="
                                                    admission_student.status == 'NEW' ||
                                                    admission_student.status == 'DRAFT' ||
                                                    admission_student.status == 'UNVERIFIED'
                                                "
                                                :href="
                                                    route('guardian.admissionStudent.form', {
                                                        registration_number: admission_student.registration_number,
                                                    })
                                                "
                                            >
                                                <OutlineButton type="default">
                                                    <div class="flex items-center space-x-1">
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
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                            <path
                                                                d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1"
                                                            />
                                                            <path
                                                                d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z"
                                                            />
                                                            <path d="M16 5l3 3" />
                                                        </svg>
                                                        <div>Sunting</div>
                                                    </div>
                                                </OutlineButton>
                                            </Link>
                                            <Link
                                                :href="
                                                    route('guardian.admissionStudent.detail', {
                                                        registration_number: admission_student.registration_number,
                                                    })
                                                "
                                            >
                                                <OutlineButton type="yellow">
                                                    <div class="flex items-center space-x-1">
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
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                            <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
                                                            <path d="M21 21l-6 -6" />
                                                        </svg>
                                                        <div>Lihat</div>
                                                    </div>
                                                </OutlineButton>
                                            </Link>
                                            <OutlineButton type="red">
                                                <div class="flex items-center space-x-1">
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
                                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                        <path d="M3 12a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" />
                                                        <path d="M18.364 5.636l-12.728 12.728" />
                                                    </svg>
                                                    <div>Batalkan</div>
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
                        :meta="admission_students.meta"
                        :links="admission_students.links"
                    />
                </div>
            </section>
            <!-- Modal -->
            <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
                <template v-slot="{ propertyModal }">
                    <CheckoutForm
                        v-if="propertyModal?.mode == 'purchase-form'"
                        :propertyModal="propertyModal"
                        @close="closeModal()"
                    />
                </template>
            </Modal>
        </template>
    </GuardianLayout>
</template>
