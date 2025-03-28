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
      actionRoute: route('office.myProfile.approval.installRepair.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        assigned_id: null,
        name: null,
        unit: null,
        quantity: 1,
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
        assigned_id: {
          label: 'Petugas',
          rules: [fieldValidation.isRequired('Petugas')],
          error: null,
          loading: null,
          options: [],
        },
        name: {
          label: 'Instalasi & Perbaikan',
          rules: [fieldValidation.isRequired('Instalasi & Perbaikan')],
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
      this.actionRoute = route('office.myProfile.approval.installRepair.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      this.form.assigned_id = submission.install_repair.assigned?.uuid;
      if (submission.install_repair.assigned) {
        this.field.assigned_id.options = [submission.install_repair.assigned];
      }
      this.form.name = submission.install_repair.items[0].name;
      this.form.quantity = submission.install_repair.items[0].quantity;
      this.form.unit = submission.install_repair.items[0].unit;
      this.form.due_date = submission.install_repair.items[0].due_date;
      this.form.description = submission.install_repair.items[0].description;
    }
  },
  methods: {
    optionAssigned(search) {
      this.field.assigned_id.loading = true;
      axios
        .get(
          route('office.myProfile.approval.installRepair.optionAssigned', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.assigned_id.options = response.data;
          this.field.assigned_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.assigned_id.loading = false;
        });
    },
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
          :label="field.assigned_id.label"
          :rules="field.assigned_id.rules"
          :error="field.assigned_id.error"
          prop="assigned_id"
        >
          <el-select
            v-model="form.assigned_id"
            :placeholder="`Pilih ${field.assigned_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :remote-method="optionAssigned"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.assigned_id.options"
              :key="option.uuid"
              :label="option.profile.name"
              :value="option.uuid"
            />
          </el-select>
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
      <DefaultButton v-if="false" type="light" @click="submit('DRAFT')" :disabled="process">
        Simpan Draft
      </DefaultButton>
      <DefaultButton v-if="false" type="default" @click="submit('PENDING')" :disabled="process"> Kirim </DefaultButton>
    </div>
  </div>
</template>
