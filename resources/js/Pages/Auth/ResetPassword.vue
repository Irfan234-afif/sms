<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, useForm } from '@inertiajs/vue3';

const props = defineProps({
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
    },
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('password.store'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Ubah Kata Sandi" />

        <div
            class="w-full rounded-lg bg-white p-6 shadow dark:border dark:border-gray-700 dark:bg-gray-800 sm:max-w-md sm:p-8 md:mt-0"
        >
            <h2
                class="mb-1 text-lg font-bold leading-tight tracking-tight text-gray-900 dark:text-white md:text-xl"
            >
                Ubah Kata Sandi
            </h2>
            <form
                @submit.prevent="submit"
                class="mt-4 space-y-4 md:space-y-5 lg:mt-5"
            >
                <div>
                    <label
                        for="email"
                        class="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
                        >Email Anda</label
                    >
                    <input
                        type="email"
                        name="email"
                        id="email"
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        placeholder="carla@mail.com"
                        v-model="form.email"
                        required
                        autofocus
                        autocomplete="username"
                    />
                    <InputError class="mt-2" :message="form.errors.email" />
                </div>
                <div>
                    <label
                        for="password"
                        class="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
                        >Kata Sandi Baru</label
                    >
                    <input
                        type="password"
                        name="password"
                        id="password"
                        placeholder="••••••••"
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        v-model="form.password"
                        required
                        autocomplete="new-password"
                    />
                    <InputError class="mt-2" :message="form.errors.password" />
                </div>
                <div>
                    <label
                        for="confirm-password"
                        class="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
                        >Konfirmasi Kata Sandi</label
                    >
                    <input
                        type="confirm-password"
                        name="confirm-password"
                        id="confirm-password"
                        placeholder="••••••••"
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        v-model="form.password_confirmation"
                        required
                        autocomplete="new-password"
                    />
                    <InputError
                        class="mt-2"
                        :message="form.errors.password_confirmation"
                    />
                </div>
                <PrimaryButton
                    class="w-full"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Atur Ulang Kata Sandi
                </PrimaryButton>
            </form>
        </div>
    </GuestLayout>
</template>
