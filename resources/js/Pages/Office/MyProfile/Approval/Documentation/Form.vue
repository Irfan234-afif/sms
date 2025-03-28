<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import moment from 'moment';
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
      actionRoute: route('office.myProfile.approval.documentation.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        title: null,
        place: null,
        date_range: [],
        description: null,
      },
      field: {
        datetime: {
          label: 'Tanggal',
          rules: [fieldValidation.isRequired('Tanggal')],
          error: null,
          disabled: true,
        },
        title: {
          label: 'Dokumentasi',
          rules: [fieldValidation.isRequired('Dokumentasi')],
          error: null,
        },
        place: {
          label: 'Lokasi',
          rules: [fieldValidation.isRequired('Lokasi')],
          error: null,
        },
        date_range: {
          label: 'Waktu',
          rules: [fieldValidation.isRequired('Waktu')],
          error: null,
        },
        description: {
          label: 'Keterangan',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    if (this.propertyModal.mode == 'submission-edit-form') {
      let submission = this.propertyModal.data.submission;
      this.actionRoute = route('office.myProfile.approval.documentation.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      this.form.title = submission.documentation.title;
      this.form.place = submission.documentation.place;
      this.form.date_range = [submission.documentation.start_date, submission.documentation.end_date];
      this.form.description = submission.documentation.description;
    }
  },
  methods: {
    submit(status) {
      this.$refs['submissionForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));
          requestPayload.status = status;

          axios
            .post(this.actionRoute, requestPayload, {
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
                  this.$refs['submissionForm'].validateField(field);
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
      <el-form v-if="loaded" ref="submissionForm" label-position="top" :model="form" :disabled="true">
        <el-form-item
          class="font-medium"
          :label="field.datetime.label"
          :rules="field.datetime.rules"
          :error="field.datetime.error"
          prop="datetime"
        >
          <el-date-picker
            :disabled="field.datetime.disabled"
            v-model="form.datetime"
            type="date"
            format="DD-MM-YYYY"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.title.label"
          :rules="field.title.rules"
          :error="field.title.error"
          prop="title"
        >
          <el-input v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.place.label"
          :rules="field.place.rules"
          :error="field.place.error"
          prop="place"
        >
          <el-input v-model="form.place" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.date_range.label"
          :rules="field.date_range.rules"
          :error="field.date_range.error"
          prop="date_range"
        >
          <el-date-picker
            v-model="form.date_range"
            type="daterange"
            range-separator="to"
            start-placeholder="Mulai"
            end-placeholder="Selesai"
            format="DD-MM-YYYY"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <el-input type="textarea" v-model="form.description" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton v-if="false" type="light" @click="submit('DRAFT')" :disabled="process">
        Simpan Draft
      </DefaultButton>
      <DefaultButton v-if="false" type="default" @click="submit('PENDING')" :disabled="process"> Kirim </DefaultButton>
    </div>
  </div>
</template>
