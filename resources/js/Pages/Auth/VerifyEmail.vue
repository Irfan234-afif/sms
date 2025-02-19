<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
    status: {
        type: String,
    },
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'));
};

const verificationLinkSent = computed(
    () => props.status === 'verification-link-sent',
);
</script>

<template>
    <GuestLayout>
        <Head title="Email Verifikasi" />

        <div
            class="w-full rounded-lg bg-white p-6 shadow dark:border dark:border-gray-700 dark:bg-gray-800 sm:max-w-md sm:p-8 md:mt-0"
        >
            <h1
                class="mb-1 text-lg font-bold leading-tight tracking-tight text-gray-900 dark:text-white md:text-xl"
            >
                Verifikasi email Anda
            </h1>
            <p class="font-light text-gray-500 dark:text-gray-400">
                Terima kasih telah mendaftar! Sebelum memulai, bisakah Anda
                memverifikasi alamat email Anda dengan mengklik tautan yang baru
                saja kami kirimkan ke email Anda? Jika Anda tidak menerima email
                tersebut, kami dengan senang hati akan mengirimkan yang baru.
            </p>
            <div
                class="mb-4 text-sm font-medium text-green-600 dark:text-green-400"
                v-if="verificationLinkSent"
            >
                Tautan verifikasi baru telah dikirimkan ke alamat email yang
                Anda berikan saat pendaftaran.
            </div>
            <form
                @submit.prevent="submit"
                class="mt-4 space-y-4 md:space-y-5 lg:mt-5"
            >
                <PrimaryButton
                    class="w-full"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Kirim Ulang Verifikasi Email
                </PrimaryButton>
                <p class="text-sm font-light text-gray-500 dark:text-gray-400">
                    <Link
                        :href="route('logout')"
                        method="post"
                        as="button"
                        class="text-primary-600 dark:text-primary-500 font-medium hover:underline"
                        >Keluar</Link
                    >
                </p>
            </form>
        </div>
    </GuestLayout>
</template>
