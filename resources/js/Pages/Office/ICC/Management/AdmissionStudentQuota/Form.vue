<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
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
      admission_student_quotas: [],
      form: {
        school: this.propertyModal?.data?.school,
        school_year: null,
      },
      field: {
        school_year: {
          label: 'Tahun Ajaran',
          rules: [],
          error: null,
          disabled: false,
          loading: false,
          options: this.propertyModal?.data?.school_years,
        },
      },
    };
  },
  created() {
    if (this.propertyModal?.data?.admission_student_quotas) {
      this.admission_student_quotas = this.propertyModal.data.admission_student_quotas.map((item, index) => ({
        id: item.id,
        type: item.type,
        title: item.title,
        sort_number: index + 1,
      }));
    }
  },
  methods: {
    getStudentQuota() {
      if (this.form.school && this.form.school_year) {
        axios
          .get(
            route('office.icc.management.admissionStudentQuota.getStudentQuota', {
              school: this.form.school?.uuid,
              school_year: this.form.school_year?.uuid,
              school_grade: this.form.school_grade?.uuid,
            }),
          )
          .then((response) => {
            this.admission_student_quotas = [];
            let admission_student_quotas = response.data;
            if (admission_student_quotas) {
              admission_student_quotas.forEach((item) => {
                let obj = {
                  title: item.school_grade.title,
                  school_id: item.school_id,
                  school_year_id: item.school_year_id,
                  school_grade_id: item.school_grade_id,
                  max_quota: item.max_quota,
                  used_quota: item.used_quota,
                };

                this.admission_student_quotas.push(obj);
              });
            } else {
              let school = this.propertyModal?.data?.school;
              school_grades = school.level.grades;
              school_grades.forEach((item) => {
                let obj = {
                  title: item.title,
                  school_id: this.form.school.id,
                  school_year_id: this.form.school_year_id,
                  school_grade_id: item.id,
                  max_quota: 0,
                  used_quota: 0,
                };

                this.admission_student_quotas.push(obj);
              });
            }
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        this.admission_student_quotas = [];
      }
    },
    submit() {
      this.process = true;
      let requestPayload = {
        admission_student_quotas: this.admission_student_quotas,
      };

      axios
        .post(route('office.icc.management.admissionStudentQuota.save'), requestPayload, {
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
          let errorMessage = 'Terjadi kesalahan.';
          errorMessage = error.response.data?.message;

          ElNotification({ title: 'Error', message: errorMessage, type: 'error' });
        })
        .finally(() => {
          this.process = false;
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

    <el-form v-if="loaded" ref="admissionStageForm" label-position="top" :disabled="process">
      <h3 class="my-3 text-sm font-semibold text-gray-700">{{ field.school_year.label }}</h3>
      <el-select
        v-model="form.school_year"
        :placeholder="`Pilih ${field.school_year.label}`"
        loading-text="..."
        no-match-text="Data tidak ditemukan"
        no-data-text="Tidak ada data"
        :disabled="field.school_year.disabled"
        value-key="uuid"
        reserve-keyword
        clearable
        autocomplete="off"
        @change="getStudentQuota()"
      >
        <el-option
          v-for="option in field.school_year.options"
          :key="option.uuid"
          :label="option.name"
          :value="option"
        />
      </el-select>
      <div v-if="admission_student_quotas.length > 0">
        <h3 class="my-3 text-sm font-semibold text-gray-700">Kuota Pendaftaran</h3>
        <div class="mb-2 grid grid-cols-3 gap-3">
          <span class="text-xs font-medium text-gray-600">Kelas</span>
          <span class="text-xs font-medium text-gray-600">Kuota Maksimum</span>
          <span class="text-xs font-medium text-gray-600">Kuota Terpakai</span>
        </div>
        <div
          v-for="(admission_student_quota, index) in admission_student_quotas"
          :key="index"
          class="mt-2 flex items-center space-x-3"
        >
          <el-input disabled :value="`Kelas ${admission_student_quota.title}`" placeholder="Judul" />
          <el-input v-model.number="admission_student_quota.max_quota" />
          <el-input disabled v-model.number="admission_student_quota.used_quota" />
        </div>
      </div>
    </el-form>

    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton v-if="admission_student_quotas.length > 0" type="default" @click="submit" :disabled="process">
        Perbarui
      </DefaultButton>
    </div>
  </div>
</template>
