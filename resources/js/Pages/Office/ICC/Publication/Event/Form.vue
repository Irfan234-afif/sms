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
        event_id: null,
        title: null,
        datetime_range: [],
        location: null,
        content: null,
      },
      field: {
        title: {
          label: 'Acara',
          rules: [fieldValidation.isRequired('Acara')],
          error: null,
        },
        datetime_range: {
          label: 'Waktu Acara',
          rules: [fieldValidation.isRequired('Waktu Acara')],
          error: null,
        },
        location: {
          label: 'Lokasi',
          rules: [fieldValidation.isRequired('Lokasi')],
          error: null,
        },
        content: {
          label: 'Keterangan',
          rules: [fieldValidation.isRequired('Keterangan')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'event-edit-form') {
      this.form.event_id = this.propertyModal.data.event?.uuid;
      this.form.title = this.propertyModal.data.event?.title;
      this.form.datetime_range = [
        this.propertyModal.data.event?.start_datetime,
        this.propertyModal.data.event?.end_datetime,
      ];
      this.form.location = this.propertyModal.data.event?.location;
      this.form.content = this.propertyModal.data.event?.content;
    }
  },
  methods: {
    submit() {
      this.$refs['EventForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = {
            ...this.form,
            start_datetime: this.form.datetime_range[0],
            end_datetime: this.form.datetime_range[1],
          };

          axios
            .post(route('office.icc.publication.event.save'), requestPayload, {
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
                  this.$refs['EventForm'].validateField(field);
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
      <el-form v-if="loaded" ref="EventForm" label-position="top" :model="form" :disabled="process">
        <el-form-item :label="field.title.label" :rules="field.title.rules" :error="field.title.error" prop="title">
          <el-input v-model="form.title" autocomplete="off" />
        </el-form-item>

        <el-form-item
          :label="field.datetime_range.label"
          :rules="field.datetime_range.rules"
          :error="field.datetime_range.error"
          prop="datetime_range"
        >
          <el-date-picker
            v-model="form.datetime_range"
            type="datetimerange"
            range-separator="to"
            start-placeholder="Mulai"
            end-placeholder="Selesai"
          />
        </el-form-item>

        <el-form-item
          :label="field.location.label"
          :rules="field.location.rules"
          :error="field.location.error"
          prop="location"
        >
          <el-input v-model="form.location" autocomplete="off" />
        </el-form-item>

        <el-form-item
          :label="field.content.label"
          :rules="field.content.rules"
          :error="field.content.error"
          prop="content"
        >
          <el-input type="textarea" v-model="form.content" rows="25" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
