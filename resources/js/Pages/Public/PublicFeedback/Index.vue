<script setup>
import { Head } from '@inertiajs/vue3';
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
</script>

<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';
export default {
  props: {
    canLogin: {
      type: Boolean,
    },
    canRegister: {
      type: Boolean,
    },
  },
  mounted() {
    initFlowbite();
  },
  data() {
    return {
      process: false,
      loaded: true,
      isValid: false,
      form: {
        name: null,
        email: null,
        phone: null,
        subject: null,
        message: null,
      },
      field: {
        name: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
        },
        email: {
          label: 'Email',
          rules: [fieldValidation.isRequired('Email'), fieldValidation.isEmail('Email')],
          error: null,
        },
        phone: {
          label: 'Telepon',
          rules: [fieldValidation.isRequired('Telepon')],
          error: null,
        },
        subject: {
          label: 'Subjek',
          rules: [fieldValidation.isRequired('Subjek')],
          error: null,
        },
        message: {
          label: 'Pesan',
          rules: [fieldValidation.isRequired('Pesan')],
          error: null,
        },
      },
    };
  },
  methods: {
    submit() {
      this.$refs['publicFeedbackForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          axios
            .post(route('savePublicFeedback'), this.form, {
              headers: { 'Content-Type': 'application/json' },
            })
            .then((response) => {
              if (response.data.status === 'success') {
                ElNotification({ title: 'Berhasil', message: response.data.message, type: 'success' });
                setTimeout(() => {
                  window.location.reload();
                }, 2000);
              } else {
                ElNotification({ title: 'Error', message: response.data.message, type: 'error' });
              }
            })
            .catch((error) => {
              let message = 'Terjadi kesalahan';
              if (error.response?.data?.errors) {
                Object.keys(error.response.data.errors).forEach((field) => {
                  this.field[field].error = error.response.data.errors[field][0];
                  this.$refs['publicFeedbackForm'].validateField(field);
                  message = error.response.data.errors[field][0];
                });
              }
              ElNotification({ title: 'Error', message, type: 'error' });
            })
            .finally(() => {
              this.process = false;
              this.loaded = false;
              this.$nextTick(() => {
                this.loaded = true;
              });
            });
        }
      });
    },
  },
};
</script>

<template>
  <Head title="Home" />
  <PublicLayout>
    <div class="min-h-screen">
      <section class="relative flex bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
        <div class="absolute inset-0 bg-gradient-to-b from-blue-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            Masukan Saran
          </h1>
        </div>
      </section>
      <section data-aos="fade-down">
        <div class="mx-auto max-w-7xl py-8 lg:py-16">
          <div class="mx-auto max-w-2xl">
            <div class="space-y-6 rounded-lg border bg-white p-5">
              <h2 class="border-b pb-4 text-base font-medium text-gray-900">Masukan Saran</h2>
              <div class="px-2">
                <el-form v-if="loaded" ref="publicFeedbackForm" label-position="top" :model="form" :disabled="process">
                  <el-form-item
                    :label="field.name.label"
                    :rules="field.name.rules"
                    :error="field.name.error"
                    prop="name"
                  >
                    <el-input v-model="form.name" autocomplete="off" />
                  </el-form-item>
                  <el-form-item
                    :label="field.email.label"
                    :rules="field.email.rules"
                    :error="field.email.error"
                    prop="email"
                  >
                    <el-input v-model="form.email" autocomplete="off" />
                  </el-form-item>
                  <el-form-item
                    :label="field.phone.label"
                    :rules="field.phone.rules"
                    :error="field.phone.error"
                    prop="phone"
                  >
                    <el-input v-model="form.phone" autocomplete="off" />
                  </el-form-item>
                  <el-form-item
                    :label="field.subject.label"
                    :rules="field.subject.rules"
                    :error="field.subject.error"
                    prop="subject"
                  >
                    <el-input v-model="form.subject" autocomplete="off" />
                  </el-form-item>
                  <el-form-item
                    :label="field.message.label"
                    :rules="field.message.rules"
                    :error="field.message.error"
                    prop="message"
                  >
                    <el-input v-model="form.message" type="textarea" autocomplete="off" />
                  </el-form-item>
                </el-form>
              </div>
              <div class="flex justify-end space-x-3">
                <DefaultButton type="default" @click="submit" :disabled="process">Kirim</DefaultButton>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </PublicLayout>
</template>
