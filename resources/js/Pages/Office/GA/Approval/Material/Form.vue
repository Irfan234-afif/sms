<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { units } from '@/Helpers/options';
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
      actionRoute: route('office.ga.approval.material.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        name: null,
        unit: null,
        quantity: 1,
        description: null,
      },
      field: {
        datetime: {
          label: 'Tanggal',
          rules: [fieldValidation.isRequired('Tanggal')],
          error: null,
          disabled: true,
        },
        name: {
          label: 'Barang',
          rules: [fieldValidation.isRequired('Barang')],
          error: null,
        },
        quantity: {
          label: 'Jumlah',
          rules: [fieldValidation.isRequired('Jumlah')],
          error: null,
        },
        unit: {
          label: 'Satuan',
          rules: [fieldValidation.isRequired('Satuan')],
          error: null,
          options: units,
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
      this.actionRoute = route('office.ga.approval.material.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      this.form.name = submission.material.items[0].name;
      this.form.unit = submission.material.items[0].unit;
      this.form.quantity = submission.material.items[0].quantity;
      this.form.description = submission.material.items[0].description;
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
          :label="field.name.label"
          :rules="field.name.rules"
          :error="field.name.error"
          prop="name"
        >
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.quantity.label"
          :rules="field.quantity.rules"
          :error="field.quantity.error"
          prop="quantity"
        >
          <el-input-number v-model="form.quantity" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.unit.label"
          :rules="field.unit.rules"
          :error="field.unit.error"
          prop="unit"
        >
          <el-select
            v-model="form.unit"
            :placeholder="`Pilih ${field.unit.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.unit.disabled"
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.unit.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
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
      <DefaultButton
        v-if="propertyModal.data.submission.status != 'APPROVED'"
        type="default"
        @click="submit('PENDING')"
        :disabled="process"
      >
        Simpan
      </DefaultButton>
    </div>
  </div>
</template>
