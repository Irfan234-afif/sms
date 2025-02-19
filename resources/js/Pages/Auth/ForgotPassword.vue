<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Lupa Kata Sandi" />

        <div
            class="w-full rounded-lg bg-white p-6 shadow dark:border dark:border-gray-700 dark:bg-gray-800 sm:max-w-md sm:p-8 md:mt-0"
        >
            <h1
                class="mb-1 text-lg font-bold leading-tight tracking-tight text-gray-900 dark:text-white md:text-xl"
            >
                Lupa kata sandi Anda?
            </h1>
            <p class="font-light text-gray-500 dark:text-gray-400">
                Lupa kata sandi Anda? Tidak masalah. Beri tahu kami alamat email
                Anda, dan kami akan mengirimkan tautan reset kata sandi yang
                memungkinkan Anda memilih kata sandi baru.
            </p>
            <div
                v-if="status"
                class="mt-4 text-sm font-medium text-green-600 dark:text-green-400"
            >
                {{ status }}
            </div>
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
