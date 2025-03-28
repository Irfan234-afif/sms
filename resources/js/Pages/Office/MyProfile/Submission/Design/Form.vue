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
      attachmentPreview: null,
      attachmentFile: null,
      actionRoute: route('office.myProfile.submission.design.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        title: null,
        attachment: null,
        due_date: moment().format('YYYY-MM-DD HH:mm:ss'),
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
          label: 'Desain',
          rules: [fieldValidation.isRequired('Desain')],
          error: null,
        },
        attachment: {
          label: 'Lampiran',
          rules: [],
          error: null,
        },
        due_date: {
          label: 'Batas Waktu',
          rules: [fieldValidation.isRequired('Batas Waktu')],
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
      this.actionRoute = route('office.myProfile.submission.design.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      if (submission.design.items[0].attachment) {
        this.attachmentPreview = submission.design.items[0].attachment_path;
      }
      this.form.title = submission.design.items[0].title;
      this.form.due_date = submission.design.items[0].due_date;
      this.form.description = submission.design.items[0].description;
    }
  },
  methods: {
    handleAttachmentFileChange(file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.attachmentPreview = e.target.result;
      };
      reader.readAsDataURL(file.raw);

      this.form.attachment = null;
      this.attachmentFile = file.raw;
    },
    submit(status) {
      this.$refs['submissionForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

          const formData = new FormData();
          formData.append('submission_id', requestPayload.submission_id);
          formData.append('datetime', requestPayload.datetime);
          formData.append('title', requestPayload.title);
          formData.append('due_date', requestPayload.due_date);
          formData.append('description', requestPayload.description);
          formData.append('attachment_file', this.attachmentFile);
          formData.append('status', status);

          axios
            .post(this.actionRoute, formData, {
              headers: { 'Content-Type': 'multipart/form-data' },
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
      <el-form v-if="loaded" ref="submissionForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.attachment.label"
          :rules="field.attachment.rules"
          :error="field.attachment.error"
          prop="attachment"
          style="width: 100%"
        >
          <el-upload action="#" :auto-upload="false" :show-file-list="false" :on-change="handleAttachmentFileChange">
            <img v-if="attachmentPreview" :src="attachmentPreview" class="h-36 rounded-lg object-cover" />
            <div v-else class="mx-auto flex h-36 w-64 items-center justify-center rounded-lg bg-gray-100">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-14 w-14 text-gray-500"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M15 8h.01" />
                <path d="M3 6a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v12a3 3 0 0 1 -3 3h-12a3 3 0 0 1 -3 -3v-12z" />
                <path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l5 5" />
                <path d="M14 14l1 -1c.928 -.893 2.072 -.893 3 0l3 3" />
              </svg>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.due_date.label"
          :rules="field.due_date.rules"
          :error="field.due_date.error"
          prop="due_date"
        >
          <el-date-picker
            :disabled="field.due_date.disabled"
            v-model="form.due_date"
            type="date"
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
      <DefaultButton type="light" @click="submit('DRAFT')" :disabled="process"> Simpan Draft </DefaultButton>
      <DefaultButton type="default" @click="submit('PENDING')" :disabled="process"> Kirim </DefaultButton>
    </div>
  </div>
</template>
