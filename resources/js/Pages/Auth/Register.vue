<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const form = useForm({
  name: '',
  email: '',
  phone: '',
  password: '',
  password_confirmation: '',
});

const submit = () => {
  form.post(route('register'), {
    onFinish: () => form.reset('password', 'password_confirmation'),
  });
};
</script>

<template>
  <GuestLayout>
    <Head title="Daftar" />

    <div class="space-y-4 p-6 sm:p-8 md:space-y-6">
      <h1 class="text-base font-medium leading-tight tracking-tight text-gray-900 dark:text-white md:text-lg">
        Buat akun
      </h1>
      <form @submit.prevent="submit" class="space-y-4 md:space-y-6">
        <div>
          <label for="name" class="mb-2 block text-xs font-medium text-gray-900 dark:text-white">Nama Anda</label>
          <input
            name="name"
            id="name"
            class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-xs text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            placeholder="Carla"
            v-model="form.name"
            required
            autocomplete="user"
          />
          <InputError class="mt-2" :message="form.errors.name" />
        </div>
        <div>
          <label for="email" class="mb-2 block text-xs font-medium text-gray-900 dark:text-white">Email Anda</label>
          <input
            type="email"
            name="email"
            id="email"
            class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-xs text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            placeholder="carla@mail.com"
            v-model="form.email"
            required
            autocomplete="username"
          />
          <InputError class="mt-2" :message="form.errors.email" />
        </div>
        <div>
          <label for="phone" class="mb-2 block text-xs font-medium text-gray-900 dark:text-white"
            >Nomor Telepon / Whatsapp Anda</label
          >
          <input
            name="phone"
            id="phone"
            class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-xs text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            placeholder="+62"
            v-model="form.phone"
            required
            autocomplete="username"
          />
          <InputError class="mt-2" :message="form.errors.phone" />
        </div>
        <div>
          <label for="password" class="mb-2 block text-xs font-medium text-gray-900 dark:text-white">Kata Sandi</label>
          <input
            type="password"
            name="password"
            id="password"
            placeholder="••••••••"
            class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-xs text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            v-model="form.password"
            required
            autocomplete="new-password"
          />
          <InputError class="mt-2" :message="form.errors.password" />
        </div>
        <div>
          <label for="confirm-password" class="mb-2 block text-xs font-medium text-gray-900 dark:text-white"
            >Konfirmasi Kata Sandi</label
          >
          <input
            type="password"
            name="confirm-password"
            id="confirm-password"
            placeholder="••••••••"
            class="focus:ring-primary-600 focus:border-primary-600 block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-xs text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            v-model="form.password_confirmation"
            required
            autocomplete="new-password"
          />

          <InputError class="mt-2" :message="form.errors.password_confirmation" />
        </div>

        <PrimaryButton class="w-full" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
          Buat akun
        </PrimaryButton>
        <p class="text-xs font-light text-gray-500 dark:text-gray-400">
          Sudah punya akun?
          <Link :href="route('login')" class="text-primary-600 dark:text-primary-500 font-medium hover:underline">
            Masuk di sini
          </Link>
        </p>
      </form>
    </div>
  </GuestLayout>
</template>
