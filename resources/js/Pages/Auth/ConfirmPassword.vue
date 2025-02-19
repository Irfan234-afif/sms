<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, useForm } from '@inertiajs/vue3';

const form = useForm({
    password: '',
});

const submit = () => {
    form.post(route('password.confirm'), {
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Konfirmasi Kata Sandi" />

        <div
            class="w-full rounded-lg bg-white p-6 shadow dark:border dark:border-gray-700 dark:bg-gray-800 sm:max-w-md sm:p-8 md:mt-0"
        >
            <h1
                class="mb-1 text-lg font-bold leading-tight tracking-tight text-gray-900 dark:text-white md:text-xl"
            >
                Konfirmasi kata sandi Anda
            </h1>
            <p class="font-light text-gray-500 dark:text-gray-400">
                Ini adalah area yang aman dari aplikasi. Harap konfirmasi kata
                sandi Anda sebelum melanjutkan.
            </p>
            <form
                @submit.prevent="submit"
                class="mt-4 space-y-4 md:space-y-5 lg:mt-5"
            >
                <div>
                    <label
                        for="password"
                        class="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
                        >Kata Sandi</label
                    >
                    <input
                        type="password"
                        name="password"
                        id="password"
                        placeholder="••••••••"
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        v-model="form.password"
                        required
                        autocomplete="current-password"
                        autofocus
                    />
                    <InputError class="mt-2" :message="form.errors.password" />
                </div>
                <PrimaryButton
                    class="w-full"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Konfirmasi
                </PrimaryButton>
            </form>
        </div>
    </GuestLayout>
</template>
