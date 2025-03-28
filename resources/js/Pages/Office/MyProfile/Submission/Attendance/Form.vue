<script setup>
import CKEditor from '@/Components/CKEditor.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { attendanceTypes } from '@/Helpers/options';
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
      actionRoute: route('office.myProfile.submission.attendance.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        type: null,
        date: moment().format('YYYY-MM-DD HH:mm:ss'),
        attachment: null,
        description: '',
      },
      field: {
        datetime: {
          label: 'Tanggal',
          rules: [fieldValidation.isRequired('Tanggal')],
          error: null,
          disabled: true,
        },
        type: {
          label: 'Absensi',
          rules: [fieldValidation.isRequired('Absensi')],
          error: null,
          options: attendanceTypes,
        },
        date: {
          label: 'Tanggal',
          rules: [fieldValidation.isRequired('Tanggal')],
          error: null,
        },
        attachment: {
          label: 'Lampiran',
          rules: [],
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
      this.actionRoute = route('office.myProfile.submission.attendance.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      this.form.type = submission.attendance.type;
      this.form.date = submission.attendance.date;
      this.form.attachment = submission.attendance.attachment;
      if (submission.attendance.attachment) {
        this.attachmentPreview = submission.attendance.attachment_path;
      }
      this.form.description = submission.attendance.description;
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
          formData.append('type', requestPayload.type);
          formData.append('date', requestPayload.date);
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
          :label="field.type.label"
          :rules="field.type.rules"
          :error="field.type.error"
          prop="type"
        >
          <el-select
            v-model="form.type"
            :placeholder="`Pilih ${field.type.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.type.disabled"
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.type.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.attachment.label"
          :rules="field.attachment.rules"
          :error="field.attachment.error"
          prop="attachment"
          style="width: 100%"
        >
          <div>
            <el-upload action="#" :auto-upload="false" :show-file-list="false" :on-change="handleAttachmentFileChange">
              <div v-if="attachmentFile || attachmentPreview">
                <DefaultButton type="default"> {{ attachmentFile?.name ?? form.attachment }}</DefaultButton>
              </div>
              <div v-else>
                <DefaultButton type="alternative"> Pilih File </DefaultButton>
              </div>
            </el-upload>
            <div class="mt-1 text-xs text-gray-500 dark:text-gray-300">PNG, JPG atau PDF (maks. 1mb).</div>
          </div>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <div style="width: 100%">
            <CKEditor v-model="form.description" />
          </div>
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
