<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
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
      form: {
        faq_id: null,
        question: null,
        answer: null,
        status: 'PUBLISH',
      },
      field: {
        question: {
          label: 'Pertanyaan',
          rules: [fieldValidation.isRequired('Pertanyaan')],
          error: null,
        },
        answer: {
          label: 'Jawaban',
          rules: [fieldValidation.isRequired('Jawaban')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'faq-edit-form') {
      this.form.faq_id = this.propertyModal.data.faq?.uuid;
      this.form.question = this.propertyModal.data.faq?.question;
      this.form.answer = this.propertyModal.data.faq?.answer;
    }
  },
  methods: {
    submit() {
      this.$refs['faqForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.faq.save'), requestPayload, {
              headers: { 'Content-Type': 'application/json' },
            })
            .then((response) => {
              if (response.data.status === 'success') {
                ElNotification({
                  title: 'Berhasil',
                  message: response.data.message,
                  type: 'success',
                });
                setTimeout(() => {
                  this.close();
                  this.$inertia.reload();
                }, 2000);
              } else {
                ElNotification({
                  title: 'Error',
                  message: response.data.message,
                  type: 'error',
                });
              }
            })
            .catch((error) => {
              let message = 'Terjadi kesalahan';
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field][0];
                  this.$refs['faqForm'].validateField(field);
                  message = error.response.data.errors[field][0];
                }
              }

              ElNotification({
                title: 'Error',
                message: message,
                type: 'error',
              });
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
    close() {
      this.$emit('close');
    },
  },
};
</script>

<template>
  <div class="space-y-6 p-5">
    <h2 class="border-b pb-4 text-base font-medium text-gray-900">
      {{ propertyModal?.title }}
    </h2>
    <div class="px-2">
      <el-form v-if="loaded" ref="faqForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.question.label"
          :rules="field.question.rules"
          :error="field.question.error"
          prop="question"
        >
          <el-input type="textarea" v-model="form.question" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.answer.label"
          :rules="field.answer.rules"
          :error="field.answer.error"
          prop="answer"
        >
          <el-input type="textarea" v-model="form.answer" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
