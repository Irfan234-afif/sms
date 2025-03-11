<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { testimonialTypes } from '@/Helpers/options';
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
        testimonial_id: null,
        type: null,
        name: null,
        relation: null,
        message: null,
      },
      field: {
        type: {
          label: 'Kategori',
          rules: [fieldValidation.isRequired('Kategori')],
          error: null,
          options: testimonialTypes,
        },
        name: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
        },
        relation: {
          label: 'Keterkaitan',
          rules: [fieldValidation.isRequired('Keterkaitan')],
          error: null,
        },
        message: {
          label: 'Testimoni',
          rules: [fieldValidation.isRequired('Testimoni')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'testimonial-edit-form') {
      this.form.testimonial_id = this.propertyModal.data.testimonial?.uuid;
      this.form.type = this.propertyModal.data.testimonial?.type;
      this.form.name = this.propertyModal.data.testimonial?.name;
      this.form.relation = this.propertyModal.data.testimonial?.relation;
      this.form.message = this.propertyModal.data.testimonial?.message;
    }
  },
  methods: {
    submit() {
      this.$refs['testimonialForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = this.form;

          axios
            .post(route('office.icc.publication.testimonial.save'), requestPayload, {
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
              ElNotification({
                title: 'Error',
                message: 'Terjadi kesalahan.',
                type: 'error',
              });
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field];
                  this.$refs['testimonialForm'].validateField(field);
                }
              }
            })
            .finally(() => {
              this.process = false;
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
      <el-form v-if="loaded" ref="testimonialForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.type.label"
          :rules="field.type.rules"
          :error="field.type.error"
          prop="type"
        >
          <el-radio-group v-model="form.type">
            <el-radio v-for="option in field.type.options" :key="option.value" :value="option.value">{{
              option.label
            }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.name.label"
          :rules="field.name.rules"
          :error="field.name.error"
          prop="name"
        >
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.relation.label"
          :rules="field.relation.rules"
          :error="field.relation.error"
          prop="relation"
        >
          <el-input v-model="form.relation" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.message.label"
          :rules="field.message.rules"
          :error="field.message.error"
          prop="message"
        >
          <el-input type="textarea" v-model="form.message" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
