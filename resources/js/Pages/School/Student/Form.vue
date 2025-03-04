<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { bloodTypes, genders, religions } from '@/Helpers/options';
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
      actionRoute: route('school.student.update'),
      modeForm: this.propertyModal.mode,
      form: {
        student_id: null,
        name: null,
        birth_place: null,
        birth_date: null,
        gender: null,
        blood_type: null,
        religion: null,
        phone: null,
        address: null,
        postal_code: null,
        school_national_id: null,
        email: null,
        password: null,
        password_confirmation: null,
      },
      field: {
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
        school_national_id: {
          label: 'Nomor Induk Siswa',
          rules: [fieldValidation.isRequired('Nomor Induk Siswa')],
          error: null,
        },
        email: {
          label: 'Email',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    if (this.modeForm == 'student-edit-form') {
      let student = this.propertyModal.data.student;
      this.actionRoute = route('school.student.update');

      this.form.student_id = student.uuid;
      this.form.name = student.profile.name;
      this.form.birth_place = student.profile.birth_place;
      this.form.birth_date = student.profile.birth_date;
      this.form.gender = student.profile.gender;
      this.form.blood_type = student.profile.blood_type;
      this.form.religion = student.profile.religion;
      this.form.phone = student.profile.phone;
      this.form.address = student.profile.address;
      this.form.postal_code = student.profile.postal_code;
      this.form.school_national_id = student.school_national_id;
      this.form.email = student.profile.email;
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
              ElNotification({
                title: 'Error',
                message: 'Terjadi kesalahan.',
                type: 'error',
              });

              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field];
                  this.$refs['employeeForm'].validateField(field);
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
        class="grid gap-3 md:grid-cols-2"
      >
        <div>
          <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">Data Personal</h2>
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
          <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">Data Sekolah</h2>
          <el-form-item
            class="font-medium"
            :label="field.school_national_id.label"
            :rules="field.school_national_id.rules"
            :error="field.school_national_id.error"
            prop="school_national_id"
          >
            <el-input v-model="form.school_national_id" autocomplete="off" />
          </el-form-item>
          <el-form-item
            class="font-medium"
            :label="field.email.label"
            :rules="field.email.rules"
            :error="field.email.error"
            prop="email"
          >
            <el-input v-model="form.email" autocomplete="off" />
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
