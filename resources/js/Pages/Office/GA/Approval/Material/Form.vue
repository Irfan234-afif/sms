<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { units, materialStatuses } from '@/Helpers/options';
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
        quantity: 1,
        unit: null,
        price: 0,
        bill_amount: 0,
        purchase: 0,
        purchase_reference: null,
        due_date: null,
        description: null,
        item_status: 'DRAFT',
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
        price: {
          label: 'Harga',
          rules: [fieldValidation.isRequired('Harga')],
          error: null,
        },
        bill_amount: {
          label: 'Total Bayar',
          rules: [fieldValidation.isRequired('Total Bayar')],
          error: null,
        },
        purchase_reference: {
          label: 'Referensi Pembelian',
          rules: [],
          error: null,
        },
        due_date: {
          label: 'Tenggat Waktu',
          rules: [fieldValidation.isRequired('Tenggat Waktu')],
          error: null,
        },
        description: {
          label: 'Keterangan',
          rules: [],
          error: null,
        },
        item_status: {
          label: 'Status Barang',
          rules: [fieldValidation.isRequired('Status Barang')],
          error: null,
          options: materialStatuses,
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
      this.form.quantity = submission.material.items[0].quantity;
      this.form.unit = submission.material.items[0].unit;
      this.form.price = submission.material.items[0].price;
      this.form.bill_amount = submission.material.items[0].bill_amount;
      this.form.purchase_reference = submission.material.items[0].purchase_reference;
      this.form.due_date = submission.material.items[0].due_date;
      this.form.description = submission.material.items[0].description;
      this.form.item_status = submission.material.items[0].status;
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
      <el-form v-if="loaded" ref="submissionForm" label-position="top" :model="form" :disabled="false">
        <el-form-item
          class="font-medium"
          :label="field.datetime.label"
          :rules="field.datetime.rules"
          :error="field.datetime.error"
          prop="datetime"
        >
          <el-date-picker
            :disabled="true"
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
          <el-input :disabled="true" v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.quantity.label"
          :rules="field.quantity.rules"
          :error="field.quantity.error"
          prop="quantity"
        >
          <el-input-number :disabled="true" v-model="form.quantity" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.unit.label"
          :rules="field.unit.rules"
          :error="field.unit.error"
          prop="unit"
        >
          <el-select
            :disabled="true"
            v-model="form.unit"
            :placeholder="`Pilih ${field.unit.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
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
          :label="field.price.label"
          :rules="field.price.rules"
          :error="field.price.error"
          prop="price"
        >
          <el-input
            type="number"
            v-model.number="form.price"
            autocomplete="off"
            @input="form.bill_amount = form.quantity * form.price"
          >
            <template #prepend>Rp</template>
          </el-input>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.bill_amount.label"
          :rules="field.bill_amount.rules"
          :error="field.bill_amount.error"
          prop="bill_amount"
        >
          <el-input :disabled="true" type="number" v-model.number="form.bill_amount" autocomplete="off">
            <template #prepend>Rp</template>
          </el-input>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.purchase_reference.label"
          :rules="field.purchase_reference.rules"
          :error="field.purchase_reference.error"
          prop="purchase_reference"
        >
          <el-input :disabled="true" type="textarea" v-model="form.purchase_reference" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.due_date.label"
          :rules="field.due_date.rules"
          :error="field.due_date.error"
          prop="due_date"
        >
          <el-date-picker
            :disabled="true"
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
          <el-input :disabled="true" type="textarea" v-model="form.description" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.item_status.label"
          :rules="field.item_status.rules"
          :error="field.item_status.error"
          prop="item_status"
        >
          <el-select
            v-model="form.item_status"
            :placeholder="`Pilih ${field.item_status.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="false"
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.item_status.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit(propertyModal.data.submission.status)" :disabled="process">
        Simpan
      </DefaultButton>
    </div>
  </div>
</template>
