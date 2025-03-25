<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { days } from '@/Helpers/options';
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
        operational_hour_id: null,
        operational_area_id: null,
        day: null,
        is_range: [null, null],
      },
      field: {
        operational_area_id: {
          label: 'Area Operasional',
          rules: [fieldValidation.isRequired('Area Operasional')],
          error: null,
          disabled: false,
          options: [],
        },
        day: {
          label: 'Hari',
          rules: [fieldValidation.isRequired('Hari')],
          error: null,
          options: days,
        },
        is_range: {
          label: 'Jam Operasional',
          rules: [fieldValidation.isRequired('Jam Operasional')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'operational-hour-edit-form') {
      this.form.operational_hour_id = this.propertyModal.data.operational_hour?.uuid;
      this.form.operational_area_id = this.propertyModal.data.operational_hour.area;
      this.field.operational_area_id.options = [this.propertyModal.data.operational_hour.area];
      this.form.day = this.propertyModal.data.operational_hour?.day;
      this.form.is_range = [
        new Date(`1970-01-01T${this.propertyModal.data.operational_hour?.open_time}`),
        new Date(`1970-01-01T${this.propertyModal.data.operational_hour?.closed_time}`),
      ];
    }
  },
  methods: {
    optionOperationalArea(search) {
      this.field.operational_area_id.loading = true;
      axios
        .get(
          route('office.icc.publication.operationalHour.optionOperationalArea', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.operational_area_id.options = response.data;
          this.field.operational_area_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.operational_area_id.loading = false;
        });
    },
    formatTime(date) {
      if (!date) return null;
      const parsedDate = date instanceof Date ? date : new Date(date);
      return parsedDate.toTimeString().split(' ')[0];
    },
    submit() {
      this.$refs['operationalHourForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));
          requestPayload.operational_area_id = requestPayload.operational_area_id.uuid;
          requestPayload.open_time = this.formatTime(requestPayload.is_range[0]);
          requestPayload.closed_time = this.formatTime(requestPayload.is_range[1]);

          axios
            .post(route('office.icc.publication.operationalHour.save'), requestPayload, {
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
                  this.$refs['operationalHourForm'].validateField(field);
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
      <el-form v-if="loaded" ref="operationalHourForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.day.label"
          :rules="field.day.rules"
          :error="field.day.error"
          prop="day"
        >
          <el-select v-model="form.day" :placeholder="`Pilih ${field.day.label}`" clearable>
            <el-option
              v-for="option in field.day.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.operational_area_id.label"
          :rules="field.operational_area_id.rules"
          :error="field.operational_area_id.error"
          prop="operational_area_id"
        >
          <el-select
            v-model="form.operational_area_id"
            :placeholder="`Pilih ${field.operational_area_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.operational_area_id.disabled"
            :remote-method="optionOperationalArea"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.operational_area_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item class="font-medium" :label="field.is_range.label" :rules="field.is_range.rules" prop="is_range">
          <el-time-picker v-model="form.is_range" is-range range-separator="to" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
