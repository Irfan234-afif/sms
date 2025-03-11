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
        operational_hour_id: null,
        operational_area_id: null,
        title: null,
        description: null,
      },
      field: {
        operational_area_id: {
          label: 'Area Operational',
          rules: [fieldValidation.isRequired('Area Operational')],
          error: null,
          disabled: false,
          options: [],
        },
        title: {
          label: 'Jam Operational',
          rules: [fieldValidation.isRequired('Jam Operational')],
          error: null,
        },
        description: {
          label: 'Keterangan',
          rules: [fieldValidation.isRequired('Keterangan')],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'operational-hour-edit-form') {
      this.form.operational_hour_id = this.propertyModal.data.operational_hour?.uuid;
      this.form.operational_area_id = this.propertyModal.data.operational_hour.group;
      this.field.operational_area_id.options = [this.propertyModal.data.operational_hour.group];
      this.form.title = this.propertyModal.data.operational_hour?.title;
      this.form.description = this.propertyModal.data.operational_hour?.description;
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
    submit() {
      this.$refs['operationalHourForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.operational_area_id = requestPayload.operational_area_id.uuid;

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
              ElNotification({
                title: 'Error',
                message: 'Terjadi kesalahan.',
                type: 'error',
              });
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field];
                  this.$refs['operationalHourForm'].validateField(field);
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
      <el-form v-if="loaded" ref="operationalHourForm" label-position="top" :model="form" :disabled="process">
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
              :label="option.title"
              :value="option"
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
          <el-input type="textarea" :rows="4" v-model="form.description" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
