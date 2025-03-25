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
      actionRoute: route('office.icc.management.admissionStudentDiscount.store'),
      form: {
        discount_id: null,
        area_ids: null,
        name: null,
        code: null,
        description: null,
        type: 'FIXED',
        value: 0,
        datetime_range: [],
        quota: 0,
        used_quota: 0,
        is_active: false,
      },
      field: {
        area_ids: {
          label: 'Area',
          rules: [fieldValidation.isRequired('Area')],
          error: null,
          disabled: false,
          options: [],
        },
        name: {
          label: 'Formulir',
          rules: [fieldValidation.isRequired('Formulir')],
          error: null,
          disabled: false,
        },
        code: {
          label: 'Kode',
          rules: [fieldValidation.isRequired('Kode')],
          error: null,
          disabled: false,
        },
        description: {
          label: 'Keterangan',
          rules: [fieldValidation.isRequired('Keterangan')],
          error: null,
          disabled: false,
        },
        datetime_range: {
          label: 'Waktu Berlaku',
          rules: [fieldValidation.isRequired('Waktu Berlaku')],
          error: null,
        },
        value: {
          label: 'Nilai',
          rules: [fieldValidation.isRequired('Nilai')],
          error: null,
          disabled: false,
        },
        quota: {
          label: 'Kuota',
          rules: [fieldValidation.isRequired('Kuota')],
          error: null,
        },
        is_active: {
          label: 'Status',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'admission-student-discount-edit-form') {
      this.actionRoute = route('office.icc.management.admissionStudentDiscount.update');
      this.form.discount_id = this.propertyModal.data.discount?.uuid;
      this.form.area_ids = this.propertyModal.data.discount.usages;
      if (this.propertyModal.data.discount.usages) {
        this.field.area_ids.options = this.propertyModal.data.discount.usages;
      }
      this.form.name = this.propertyModal.data.discount?.name;
      this.form.code = this.propertyModal.data.discount?.code;
      this.form.type = this.propertyModal.data.discount?.type;
      this.form.description = this.propertyModal.data.discount?.description;
      this.form.value = Math.round(this.propertyModal.data.discount?.value);
      this.form.datetime_range = [
        this.propertyModal.data.discount?.starts_at,
        this.propertyModal.data.discount?.ends_at,
      ];
      this.form.quota = this.propertyModal.data.discount?.quota;
      this.form.is_active = this.propertyModal.data.discount?.is_active;
    }
  },
  methods: {
    optionArea(search) {
      this.field.area_ids.loading = true;
      axios
        .get(
          route('office.icc.management.admissionStudentDiscount.optionArea', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.area_ids.options = response.data;
          this.field.area_ids.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.area_ids.loading = false;
        });
    },
    submit() {
      this.$refs['admissionStudentDiscountForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          let area_ids = [];
          this.form.area_ids.forEach((area) => {
            area_ids.push(area.uuid);
          });

          requestPayload.area_ids = area_ids;
          requestPayload.starts_at = requestPayload.datetime_range[0];
          requestPayload.ends_at = requestPayload.datetime_range[1];

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
                  this.$refs['admissionStudentDiscountForm'].validateField(field);
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
      <el-form v-if="loaded" ref="admissionStudentDiscountForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.area_ids.label"
          :rules="field.area_ids.rules"
          :error="field.area_ids.error"
          prop="area_ids"
        >
          <el-select
            v-model="form.area_ids"
            :placeholder="`Pilih ${field.area_ids.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.area_ids.disabled"
            :remote-method="optionArea"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
            multiple
          >
            <el-option
              v-for="option in field.area_ids.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
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
          <el-input :disabled="field.name.disabled" v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.code.label"
          :rules="field.code.rules"
          :error="field.code.error"
          prop="code"
        >
          <el-input :disabled="field.code.disabled" v-model="form.code" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <el-input :disabled="field.description.disabled" v-model="form.description" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.value.label"
          :rules="field.value.rules"
          :error="field.value.error"
          prop="value"
        >
          <el-input type="number" v-model.number="form.value" autocomplete="off">
            <template #prepend>{{ form.type == 'FIXED' ? 'RP' : '%' }}</template>
            <template #append>
              <el-select @change="form.value = 0" v-model="form.type" placeholder="Pilih Type" style="width: 115px">
                <el-option label="Tetap" value="FIXED" />
                <el-option label="Persen" value="PERCENTAGE" />
              </el-select>
            </template>
          </el-input>
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
            value-format="YYYY-MM-DD HH:mm:ss"
            range-separator="to"
            start-placeholder="Mulai"
            end-placeholder="Berakhir"
          />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.quota.label"
          :rules="field.quota.rules"
          :error="field.quota.error"
          prop="quota"
        >
          <el-input type="number" v-model.number="form.quota" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.is_active.label"
          :rules="field.is_active.rules"
          :error="field.is_active.error"
          prop="is_active"
        >
          <el-checkbox border v-model="form.is_active" :label="form.is_active ? 'Aktif' : 'Tidak Aktif'" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
