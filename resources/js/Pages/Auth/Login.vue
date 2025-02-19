<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Masuk" />

        <div v-if="status" class="mb-4 text-sm font-medium text-green-600">
            {{ status }}
        </div>
        <div class="space-y-4 p-6 sm:p-8 md:space-y-6">
            <h1
                class="text-lg font-bold leading-tight tracking-tight text-gray-900 dark:text-white md:text-xl"
            >
                Masuk ke akun Anda
            </h1>
            <form @submit.prevent="submit" class="space-y-4 md:space-y-6">
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
                        autofocus
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        v-model="form.email"
                        placeholder="carla@mail.com"
                        required
                    />
                    <InputError class="mt-2" :message="form.errors.email" />
                </div>
                <div>
                    <label
                        for="password"
                        class="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
                        >Kata sandi</label
                    >
                    <input
                        type="password"
                        name="password"
                        id="password"
                        placeholder="••••••••"
                        v-model="form.password"
                        class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
                        required
                    />
                    <InputError class="mt-2" :message="form.errors.password" />
                </div>
                <div class="flex items-center justify-between">
                    <div class="flex items-start">
                        <div class="flex h-5 items-center">
                            <input
                                id="remember"
                                name="remember"
                                aria-describedby="remember"
                                type="checkbox"
                                v-model="form.remember"
                                class="focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 h-4 w-4 rounded border border-gray-300 bg-gray-50 dark:border-gray-600 dark:bg-gray-700 dark:ring-offset-gray-800"
                            />
                        </div>
                        <div class="ml-3 text-sm">
                            <label
                                for="remember"
                                class="text-gray-500 dark:text-gray-300"
                                >Ingat saya</label
                            >
                        </div>
                    </div>
                    <Link
                        v-if="canResetPassword"
                        :href="route('password.request')"
                        class="text-primary-600 dark:text-primary-500 text-sm font-medium hover:underline"
                    >
                        Lupa kata sandi?
                    </Link>
                </div>
                <InputError class="mt-2" :message="form.errors.password" />
                <PrimaryButton
                    class="w-full"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Masuk
                </PrimaryButton>
                <p class="text-sm font-light text-gray-500 dark:text-gray-400">
                    Belum punya akun?
                    <Link
                        :href="route('register')"
                        class="text-primary-600 dark:text-primary-500 font-medium hover:underline"
                        >Daftar</Link
                    >
                </p>
            </form>
        </div>
    </GuestLayout>
</template>
