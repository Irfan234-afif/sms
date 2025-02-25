<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import midtrans from '@/Configs/midtrans';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
midtrans.init();
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
      student_quota: null,
      form: {
        name: null,
        birth_date: null,
        school: null,
        school_year: null,
        school_grade: null,
      },
      field: {
        name: {
          label: 'Nama Lengkap Siswa',
          rules: [fieldValidation.isRequired('Nama Lengkap Siswa')],
          error: null,
        },
        birth_date: {
          label: 'Tanggal Lahir',
          rules: [fieldValidation.isRequired('Tanggal Lahir')],
          error: null,
        },
        school: {
          label: 'Sekolah',
          rules: [fieldValidation.isRequired('Sekolah')],
          error: null,
          disabled: false,
          loading: false,
          options: [],
        },
        school_year: {
          label: 'Tahun Ajaran',
          rules: [fieldValidation.isRequired('Tahun Ajaran')],
          error: null,
          disabled: false,
          loading: false,
          options: [],
        },
        school_grade: {
          label: 'Kelas',
          rules: [fieldValidation.isRequired('Kelas')],
          error: null,
          disabled: true,
          loading: false,
          options: [],
        },
      },
      product: this.propertyModal?.data?.product,
    };
  },
  watch: {
    'form.school'() {
      if (this.form.school) {
        this.form.school_grade = null;
        this.field.school_grade.disabled = false;
        this.field.school_grade.options = this.form.school.grades;
      } else {
        this.form.school_grade = null;
        this.field.school_grade.disabled = true;
        this.field.school_grade.options = [];
      }
    },
  },
  methods: {
    optionSchool(search) {
      this.field.school.loading = true;
      axios
        .get(
          route('guardian.admissionStudent.optionSchool', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school.options = response.data;
          this.field.school.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school.loading = false;
        });
    },
    optionSchoolYear(search) {
      this.field.school_year.loading = true;
      axios
        .get(
          route('guardian.admissionStudent.optionSchoolYear', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.school_year.options = response.data;
          this.field.school_year.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.school_year.loading = false;
        });
    },
    getStudentQuota() {
      if (this.form.school && this.form.school_year && this.form.school_grade) {
        axios
          .get(
            route('guardian.admissionStudent.getStudentQuota', {
              school: this.form.school?.uuid,
              school_year: this.form.school_year?.uuid,
              school_grade: this.form.school_grade?.uuid,
            }),
          )
          .then((response) => {
            this.student_quota = response.data;
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        this.student_quota = null;
      }
    },
    submit() {
      this.$refs['checkoutForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));
          requestPayload.school = requestPayload.school?.uuid;
          requestPayload.school_year = requestPayload.school_year?.uuid;
          requestPayload.school_grade = requestPayload.school_grade?.uuid;

          axios
            .post(route('guardian.admissionStudent.checkout'), requestPayload, {
              headers: { 'Content-Type': 'application/json' },
            })
            .then((response) => {
              let transaction_payment = response.data.transaction_payment;
              let snap_token = response.data.snap_token;

              try {
                window.snap.pay(snap_token, {
                  onSuccess: (gateway_response) => {
                    this.processPayment(transaction_payment, gateway_response);

                    ElNotification({
                      title: 'Pembayaran Berhasil',
                      message: 'Terima kasih! Pembayaran Anda telah berhasil diproses.',
                      type: 'success',
                    });

                    this.process = false;
                  },
                  onPending: (gateway_response) => {
                    this.processPayment(transaction_payment, gateway_response);

                    ElNotification({
                      title: 'Menunggu Pembayaran',
                      message:
                        'Pembayaran Anda telah dimasukkan ke dalam tagihan. Silakan selesaikan transaksi segera.',
                      type: 'warning',
                    });

                    this.process = false;
                  },
                  onError: (gateway_response) => {
                    this.processPayment(transaction_payment, gateway_response);

                    ElNotification({
                      title: 'Pembayaran Gagal',
                      message: 'Terjadi kesalahan dalam proses pembayaran. Silakan coba lagi.',
                      type: 'error',
                    });

                    this.process = false;
                  },
                  onClose: (gateway_response) => {
                    console.log(gateway_response);

                    ElNotification({
                      title: 'Transaksi Ditutup',
                      message: 'Anda telah menutup pembayaran sebelum menyelesaikannya.',
                      type: 'info',
                    });

                    this.process = false;
                  },
                });
              } catch (error) {
                this.process = true;

                console.error(error);
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
                  this.$refs['checkoutForm'].validateField(field);
                }
              }
            })
            .finally(() => {
              this.process = false;
            });
        }
      });
    },
    processPayment(transaction_payment, gateway_response) {
      this.process = true;

      axios
        .post(
          route('guardian.transactionPayment.processPayment'),
          {
            transaction_payment: transaction_payment.uuid,
            gateway_response: gateway_response,
          },
          {
            headers: { 'Content-Type': 'application/json' },
          },
        )
        .then((response) => {
          console.log(response.data.status);
          if (response.data.status) {
            setTimeout(() => {
              this.close();
              this.$inertia.reload();
            }, 2000);
          }
        })
        .catch((error) => {
          ElNotification({
            title: 'Error',
            message: error,
            type: 'error',
          });
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
    <div class="px-2">
      <el-form v-if="loaded" ref="checkoutForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.birth_date.label"
          :rules="field.birth_date.rules"
          :error="field.birth_date.error"
          prop="birth_date"
        >
          <el-date-picker v-model="form.birth_date" type="date" format="DD-MM-YYYY" value-format="YYYY-MM-DD" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.school.label"
          :rules="field.school.rules"
          :error="field.school.error"
          prop="school"
        >
          <el-select
            v-model="form.school"
            :placeholder="`Pilih ${field.school.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school.disabled"
            :remote-method="optionSchool"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
            @change="getStudentQuota()"
          >
            <el-option
              v-for="option in field.school.options"
              :key="option.uuid"
              :label="option.area.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.school_year.label"
          :rules="field.school_year.rules"
          :error="field.school_year.error"
          prop="school_year"
        >
          <el-select
            v-model="form.school_year"
            :placeholder="`Pilih ${field.school_year.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_year.disabled"
            :remote-method="optionSchoolYear"
            value-key="uuid"
            remote
            filterable
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
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.school_grade.label"
          :rules="field.school_grade.rules"
          :error="field.school_grade.error"
          prop="school_grade"
        >
          <el-select
            v-model="form.school_grade"
            :placeholder="`Pilih ${field.school_grade.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.school_grade.disabled"
            value-key="uuid"
            clearable
            autocomplete="off"
            @change="getStudentQuota()"
          >
            <el-option
              v-for="option in field.school_grade.options"
              :key="option.uuid"
              :label="option.title"
              :value="option"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div
      v-if="student_quota"
      class="flex items-center rounded-lg bg-blue-50 p-4 text-blue-800 dark:bg-gray-800 dark:text-blue-300"
    >
      <svg
        class="h-4 w-4 shrink-0"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="currentColor"
        viewBox="0 0 20 20"
      >
        <path
          d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
        />
      </svg>
      <span class="sr-only">Info</span>
      <div class="ms-3 text-xs font-medium">
        Kuota Pendaftaran yang tersedia
        <span class="font-medium">{{ student_quota.max_quota - student_quota.used_quota }}</span>
      </div>
    </div>
    <div
      class="space-y-4 rounded-lg border border-gray-100 bg-gray-50 p-6 text-xs dark:border-gray-700 dark:bg-gray-800"
    >
      <div class="space-y-4">
        <dl class="flex items-center justify-between gap-4">
          <dt class="font-normal text-gray-500 dark:text-gray-400">Harga</dt>
          <dd class="font-medium text-gray-900 dark:text-white">IDR {{ product.price }}</dd>
        </dl>
        <dl class="flex items-center justify-between gap-4">
          <dt class="font-normal text-gray-500 dark:text-gray-400">Diskon</dt>
          <dd class="font-medium text-green-500 dark:text-white">-</dd>
        </dl>
      </div>
      <dl class="flex items-center justify-between gap-4 border-t border-gray-200 pt-2 text-base dark:border-gray-700">
        <dt class="font-medium text-gray-900 dark:text-white">Total</dt>
        <dd class="font-medium text-gray-900 dark:text-white">IDR {{ product.price }}</dd>
      </dl>
    </div>
    <div class="flex items-center rounded-lg bg-yellow-50 p-4 text-yellow-800 dark:bg-gray-800 dark:text-yellow-300">
      <svg
        class="h-4 w-4 shrink-0"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="currentColor"
        viewBox="0 0 20 20"
      >
        <path
          d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
        />
      </svg>
      <span class="sr-only">Info</span>
      <div class="ms-3 text-xs font-medium">
        Ingin mengetahui simulasi biaya sekolah?
        <a
          href="https://api.whatsapp.com/send?phone=081140001557&text=Halo%2C%20saya%20membutuhkan%20simulasi%20biaya%20sekolah%20untuk%20anak%20saya.%20Dapatkah%20Anda%20membantu%3F"
          target="_blank"
          class="font-medium underline hover:no-underline"
          >Hubungi kami</a
        >
      </div>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton class="w-full" type="light" @click="close" :disabled="process"> Batal </DefaultButton>

      <DefaultButton class="w-full" type="default" @click="submit" :disabled="process"> Beli Formulir </DefaultButton>
    </div>
  </div>
</template>
