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
      actionRoute: null,
      modeForm: this.propertyModal.mode,
      form: {
        area_id: null,
        employee_id: null,
        position_id: null,
      },
      field: {
        employee_id: {
          label: 'Karyawan',
          rules: [fieldValidation.isRequired('Karyawan')],
          error: null,
          disabled: false,
          options: [],
        },
        position_id: {
          label: 'Posisi',
          rules: [fieldValidation.isRequired('Posisi')],
          error: null,
          disabled: false,
          options: [],
        },
      },
    };
  },
  created() {
    let area = this.propertyModal.data.area;
    let employee_assignment = this.propertyModal.data.employee_assignment;

    this.actionRoute = route('office.hcm.placement.area.assign', {
      area_id: area.uuid,
    });
    this.form.area_id = area.uuid;
    if (area.positions) {
      this.field.position_id.options = area.positions;
    }

    if (employee_assignment) {
      this.form.employee_id = employee_assignment.employee;
      this.field.employee_id.options = [employee_assignment.employee];
      this.field.employee_id.disabled = true;
      this.form.position_id = employee_assignment.position;
    }
  },
  methods: {
    optionEmployee(search) {
      this.field.employee_id.loading = true;
      axios
        .get(
          route('office.hcm.placement.area.optionEmployee', {
            area_id: this.propertyModal.data.area.uuid,
            search: search,
          }),
        )
        .then((response) => {
          this.field.employee_id.options = response.data;
          this.field.employee_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.employee_id.loading = false;
        });
    },
    submit() {
      this.$refs['assignForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.employee_id = requestPayload.employee_id.uuid;
          requestPayload.position_id = requestPayload.position_id.uuid;

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
                  this.$refs['assignForm'].validateField(field);
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
    <h2 class="borde pb-2r-b mb-2 text-base font-medium text-gray-900">
      {{ propertyModal?.title }}
    </h2>
    <div class="px-2">
      <el-form v-if="loaded" ref="assignForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.employee_id.label"
          :rules="field.employee_id.rules"
          :error="field.employee_id.error"
          prop="employee_id"
        >
          <el-select
            v-model="form.employee_id"
            :placeholder="`Pilih ${field.employee_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.employee_id.disabled"
            :remote-method="optionEmployee"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.employee_id.options"
              :key="option.uuid"
              :label="option.profile.name"
              :value="option"
            />
          </el-select>
        </el-form-item>

        <el-form-item
          class="font-medium"
          :label="field.position_id.label"
          :rules="field.position_id.rules"
          :error="field.position_id.error"
          prop="position_id"
        >
          <el-select
            v-model="form.position_id"
            :placeholder="`Pilih ${field.position_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.position_id.disabled"
            value-key="uuid"
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.position_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
