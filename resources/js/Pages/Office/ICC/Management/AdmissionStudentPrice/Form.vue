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
      actionRoute: route('office.icc.management.admissionStudentPrice.store'),
      form: {
        product_id: null,
        area_id: null,
        name: null,
        price: null,
        is_active: false,
      },
      field: {
        area_id: {
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
        price: {
          label: 'Harga',
          rules: [fieldValidation.isRequired('Harga')],
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
    if (mode == 'admission-student-price-edit-form') {
      this.actionRoute = route('office.icc.management.admissionStudentPrice.update');
      this.form.product_id = this.propertyModal.data.product?.uuid;
      this.form.area_id = this.propertyModal.data.product.area;
      if (this.propertyModal.data.product.area) {
        this.field.area_id.disabled = true;
        this.field.area_id.options = [this.propertyModal.data.product.area];
      }
      this.form.name = this.propertyModal.data.product?.name;
      this.form.price = Math.round(this.propertyModal.data.product?.price);
      this.form.is_active = this.propertyModal.data.product?.is_active;
    }
  },
  methods: {
    optionArea(search) {
      this.field.area_id.loading = true;
      axios
        .get(
          route('office.icc.management.admissionStudentPrice.optionArea', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.area_id.options = response.data;
          this.field.area_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.area_id.loading = false;
        });
    },
    submit() {
      this.$refs['admissionStudentPriceForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          requestPayload.area_id = requestPayload.area_id.uuid;

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
                  this.$refs['admissionStudentPriceForm'].validateField(field);
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
      <el-form v-if="loaded" ref="admissionStudentPriceForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.area_id.label"
          :rules="field.area_id.rules"
          :error="field.area_id.error"
          prop="area_id"
        >
          <el-select
            v-model="form.area_id"
            :placeholder="`Pilih ${field.area_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.area_id.disabled"
            :remote-method="optionArea"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.area_id.options"
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
          :label="field.price.label"
          :rules="field.price.rules"
          :error="field.price.error"
          prop="price"
        >
          <el-input type="number" v-model.number="form.price" autocomplete="off" />
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
