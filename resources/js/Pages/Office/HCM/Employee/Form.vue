<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { bloodTypes, employeeStatus, genders, maritalStatuses, religions } from '@/Helpers/options';
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
      actionRoute: route('office.hcm.employee.store'),
      modeForm: this.propertyModal.mode,
      form: {
        employee_id: null,
        national_id: null,
        name: null,
        birth_place: null,
        birth_date: null,
        gender: null,
        blood_type: null,
        religion: null,
        marital_status: null,
        phone: null,
        address: null,
        postal_code: null,
        identity_number: null,
        start_date: null,
        end_date: null,
        status: null,
        email: null,
        password: null,
        password_confirmation: null,
      },
      field: {
        national_id: {
          label: 'ID Kependudukan',
          rules: [fieldValidation.isRequired('ID Kependudukan')],
          error: null,
        },
        name: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
        },
        birth_place: {
          label: 'Tempat Lahir',
          rules: [fieldValidation.isRequired('Tempat Lahir')],
          error: null,
        },
        birth_date: {
          label: 'Tanggal Lahir',
          rules: [fieldValidation.isRequired('Tanggal Lahir')],
          error: null,
        },
        gender: {
          label: 'Jenis Kelamin',
          rules: [fieldValidation.isRequired('Jenis Kelamin')],
          error: null,
          options: genders,
        },
        blood_type: {
          label: 'Golongan Darah',
          rules: null,
          error: null,
          options: bloodTypes,
        },
        religion: {
          label: 'Agama',
          rules: null,
          error: null,
          options: religions,
        },
        marital_status: {
          label: 'Status Pernikahan',
          rules: [],
          error: null,
          options: maritalStatuses,
        },
        phone: {
          label: 'Telepon',
          rules: [fieldValidation.isRequired('Telepon')],
          error: null,
        },

        address: {
          label: 'Alamat',
          rules: [fieldValidation.isRequired('Alamat')],
          error: null,
        },
        postal_code: {
          label: 'Kode Pos',
          rules: [],
          error: null,
        },
        identity_number: {
          label: 'ID Karyawan',
          rules: [fieldValidation.isRequired('ID Karyawan')],
          error: null,
        },
        start_date: {
          label: 'Tanggal Mulai',
          rules: [fieldValidation.isRequired('Tanggal Mulai')],
          error: null,
        },
        end_date: {
          label: 'Tanggal Selesai',
          rules: [],
          error: null,
        },
        status: {
          label: 'Status',
          rules: [fieldValidation.isRequired('Status')],
          error: null,
          options: employeeStatus,
        },
        email: {
          label: 'Email',
          rules: [fieldValidation.isRequired('Email'), fieldValidation.isEmail('Email')],
          error: null,
        },
        password: {
          label: 'Kata Sandi',
          rules: [fieldValidation.isRequired('Kata Sandi')],
          error: null,
        },
        password_confirmation: {
          label: 'Konfirmasi Kata Sandi',
          rules: [fieldValidation.isRequired('Konfirmasi Kata Sandi')],
          error: null,
        },
      },
    };
  },
  created() {
    if (this.modeForm == 'employee-edit-form') {
      let employee = this.propertyModal.data.employee;
      this.actionRoute = route('office.hcm.employee.update');

      this.form.employee_id = employee.uuid;
      this.form.national_id = employee.profile.national_id;
      this.form.name = employee.profile.name;
      this.form.birth_place = employee.profile.birth_place;
      this.form.birth_date = employee.profile.birth_date;
      this.form.gender = employee.profile.gender;
      this.form.blood_type = employee.profile.blood_type;
      this.form.religion = employee.profile.religion;
      this.form.marital_status = employee.profile.marital_status;
      this.form.phone = employee.profile.phone;
      this.form.address = employee.profile.address;
      this.form.postal_code = employee.profile.postal_code;
      this.form.identity_number = employee.identity_number;
      this.form.start_date = employee.start_date;
      this.form.end_date = employee.end_date;
      this.form.status = employee.status;
      this.form.email = employee.profile.email;
    }
  },
  methods: {
    submit() {
      this.$refs['employeeForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

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
                  this.$refs['employeeForm'].validateField(field);
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
      <el-form
        v-if="loaded"
        ref="employeeForm"
        label-position="top"
        :model="form"
        :disabled="process"
        class="grid gap-3 md:grid-cols-3"
      >
        <div>
          <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">Data Personal</h2>
          <el-form-item
            class="font-medium"
            :label="field.national_id.label"
            :rules="field.national_id.rules"
            :error="field.national_id.error"
            prop="national_id"
          >
            <el-input v-model="form.national_id" autocomplete="off" />
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
            :label="field.birth_place.label"
            :rules="field.birth_place.rules"
            :error="field.birth_place.error"
            prop="birth_place"
          >
            <el-input v-model="form.birth_place" autocomplete="off" />
          </el-form-item>

          <el-form-item
            class="font-medium"
            :label="field.birth_date.label"
            :rules="field.birth_date.rules"
            :error="field.birth_date.error"
            prop="birth_date"
          >
            <el-date-picker v-model="form.birth_date" type="date" format="DD-MM-YYYY" value-format="YYYY-MM-DD" />
          </el-form-item>

          <el-form-item
            class="font-medium"
            :label="field.gender.label"
            :rules="field.gender.rules"
            :error="field.gender.error"
            prop="gender"
          >
            <el-radio-group v-model="form.gender">
              <el-radio v-for="option in field.gender.options" :key="option.value" :value="option.value">{{
                option.label
              }}</el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item class="font-medium" :label="field.blood_type.label" prop="blood_type">
            <el-select v-model="form.blood_type" :placeholder="`Pilih ${field.blood_type.label}`" clearable>
              <el-option v-for="option in field.blood_type.options" :key="option" :label="option" :value="option" />
            </el-select>
          </el-form-item>

          <el-form-item class="font-medium" :label="field.religion.label" prop="religion">
            <el-select v-model="form.religion" :placeholder="`Pilih ${field.religion.label}`" clearable>
              <el-option
                v-for="option in field.religion.options"
                :key="option.value"
                :label="option.label"
                :value="option.value"
              />
            </el-select>
          </el-form-item>

          <el-form-item class="font-medium" :label="field.marital_status.label" prop="marital_status">
            <el-radio-group v-model="form.marital_status">
              <el-radio v-for="option in field.marital_status.options" :key="option.value" :value="option.value">{{
                option.label
              }}</el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item
            class="font-medium"
            :label="field.phone.label"
            :rules="field.phone.rules"
            :error="field.phone.error"
            prop="phone"
          >
            <el-input v-model="form.phone" autocomplete="off" />
          </el-form-item>

          <el-form-item
            class="font-medium"
            :label="field.address.label"
            :rules="field.address.rules"
            :error="field.address.error"
            prop="address"
          >
            <el-input v-model="form.address" autocomplete="off" />
          </el-form-item>

          <el-form-item class="font-medium" :label="field.postal_code.label" prop="postal_code">
            <el-input v-model="form.postal_code" autocomplete="off" />
          </el-form-item>
        </div>
        <div>
          <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">Kontrak Karyawan</h2>
          <el-form-item
            class="font-medium"
            :label="field.identity_number.label"
            :rules="field.identity_number.rules"
            :error="field.identity_number.error"
            prop="identity_number"
          >
            <el-input v-model="form.identity_number" autocomplete="off" />
          </el-form-item>

          <el-form-item
            class="font-medium"
            :label="field.start_date.label"
            :rules="field.start_date.rules"
            :error="field.start_date.error"
            prop="start_date"
          >
            <el-date-picker v-model="form.start_date" type="date" format="DD-MM-YYYY" value-format="YYYY-MM-DD" />
          </el-form-item>

          <el-form-item class="font-medium" :label="field.end_date.label" prop="end_date">
            <el-date-picker v-model="form.end_date" type="date" format="DD-MM-YYYY" value-format="YYYY-MM-DD" />
          </el-form-item>

          <el-form-item class="font-medium" :label="field.status.label" prop="status">
            <el-select v-model="form.status" :placeholder="`Pilih ${field.status.label}`" clearable>
              <el-option
                v-for="option in field.status.options"
                :key="option.value"
                :label="option.label"
                :value="option.value"
              />
            </el-select>
          </el-form-item>
        </div>
        <div>
          <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">Akun</h2>
          <el-form-item
            class="font-medium"
            :label="field.email.label"
            :rules="field.email.rules"
            :error="field.email.error"
            prop="email"
          >
            <el-input v-model="form.email" autocomplete="off" />
          </el-form-item>

          <el-form-item
            v-if="modeForm == 'employee-create-form' || !propertyModal.data.employee?.profile?.user"
            class="font-medium"
            :label="field.password.label"
            :rules="field.password.rules"
            :error="field.password.error"
            prop="password"
          >
            <el-input v-model="form.password" type="password" autocomplete="off" />
          </el-form-item>

          <el-form-item
            v-if="modeForm == 'employee-create-form' || !propertyModal.data.employee?.profile?.user"
            class="font-medium"
            :label="field.password_confirmation.label"
            :rules="field.password_confirmation.rules"
            :error="field.password_confirmation.error"
            prop="password_confirmation"
          >
            <el-input v-model="form.password_confirmation" type="password" autocomplete="off" />
          </el-form-item>
        </div>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
