<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import OutlineButton from '@/Components/OutlineButton.vue';
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
        school_grade_id: null,
        school_subject_id: this.propertyModal.data.school_subject.uuid,
        minimum_value: 0,
        scales: [],
        narratives: [],
      },
      field: {
        school_grade_id: {
          label: 'Tingkat Kelas',
          rules: [fieldValidation.isRequired('Tingkat Kelas')],
          error: null,
          options: this.propertyModal.data.school_grades,
        },
        minimum_value: {
          label: 'Skor Minimum',
          rules: [fieldValidation.isRequired('Skor Minimum')],
          error: null,
        },
      },
    };
  },
  created() {},
  methods: {
    addNewScale(scale = null) {
      let newObj = {
        id: null,
        predicate: '',
        value: 0,
        narrative: '',
      };

      if (scale) {
        newObj.id = scale.uuid;
        newObj.predicate = scale.predicate;
        newObj.value = scale.value;
        newObj.narrative = scale.narrative;
      }

      this.form.scales.push(newObj);
    },
    removeScale(index) {
      this.form.scales.splice(index, 1);
    },
    addNewNarrative(narrative = null) {
      let newObj = {
        id: null,
        value: 0,
        narrative: '',
      };

      if (narrative) {
        newObj.id = narrative.uuid;
        newObj.value = narrative.value;
        newObj.narrative = narrative.narrative;
      }

      this.form.narratives.push(newObj);
    },
    removeNarrative(index) {
      this.form.narratives.splice(index, 1);
    },
    getSubjectTreshold() {
      axios
        .get(
          route('school.teachingProgram.subjectThreshold.getSubjectThreshold', {
            school_grade_id: this.form.school_grade_id,
            school_subject_id: this.form.school_subject_id,
          }),
        )
        .then((response) => {
          this.form.minimum_value = 0;
          this.form.scales = [];
          this.form.narratives = [];
          if (response.data) {
            this.form.minimum_value = response.data.minimum_value;
            response.data.scales.map((item) => {
              this.addNewScale(item);
            });
            response.data.narratives.map((item) => {
              this.addNewNarrative(item);
            });
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    submit() {
      this.$refs['subjectThresholdSetForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('school.teachingProgram.subjectThreshold.save'), requestPayload, {
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
                  this.$refs['subjectThresholdSetForm'].validateField(field);
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
      <el-form v-if="loaded" ref="subjectThresholdSetForm" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.school_grade_id.label"
          :rules="field.school_grade_id.rules"
          :error="field.school_grade_id.error"
          prop="school_grade_id"
        >
          <el-select
            v-model="form.school_grade_id"
            :placeholder="`Pilih ${field.school_grade_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            clearable
            autocomplete="off"
            @change="getSubjectTreshold()"
          >
            <el-option
              v-for="option in field.school_grade_id.options"
              :key="option.uuid"
              :label="`Kelas ${option.title}`"
              :value="option.uuid"
            />
          </el-select>
        </el-form-item>
        <template v-if="form.school_grade_id">
          <el-form-item
            class="font-medium"
            :label="field.minimum_value.label"
            :rules="field.minimum_value.rules"
            :error="field.minimum_value.error"
            prop="minimum_value"
          >
            <el-input-number v-model="form.minimum_value" autocomplete="off" />
          </el-form-item>
          <!-- scales -->
          <div>
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Deskripsi Predikat</h2>
            <div class="space-y-3">
              <div
                v-for="(scale, index) in form.scales"
                :key="index"
                class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
              >
                <el-form-item class="font-medium" :label="`Predikat ${index + 1}`">
                  <el-input v-model="scale.predicate" autocomplete="off" />
                </el-form-item>
                <el-form-item class="font-medium" label="Skor Minimum">
                  <el-input-number v-model="scale.value" autocomplete="off" />
                </el-form-item>
                <el-form-item class="font-medium" label="Naratif">
                  <el-input type="textarea" v-model="scale.narrative" autocomplete="off" />
                </el-form-item>
                <div class="flex items-center justify-end">
                  <OutlineButton class="my-auto" type="red" @click="removeScale(index)">Hapus</OutlineButton>
                </div>
              </div>
            </div>
            <DefaultButton type="light" @click="addNewScale()" class="mt-3">Tambah Deskripsi Predikat</DefaultButton>
          </div>
          <!-- narrative -->
          <div class="mt-3">
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Deskripsi Tidak Tuntas</h2>
            <div class="space-y-3">
              <div
                v-for="(narrative, index) in form.narratives"
                :key="index"
                class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
              >
                <el-form-item class="font-medium" label="Skor Minimum">
                  <el-input-number v-model="narrative.value" autocomplete="off" />
                </el-form-item>
                <el-form-item class="font-medium" label="Naratif">
                  <el-input type="textarea" v-model="narrative.narrative" autocomplete="off" />
                </el-form-item>
                <div class="flex items-center justify-end">
                  <OutlineButton class="my-auto" type="red" @click="removeNarrative(index)">Hapus</OutlineButton>
                </div>
              </div>
            </div>
            <DefaultButton type="light" @click="addNewNarrative()" class="mt-3"
              >Tambah Deskripsi Tidak Tuntas</DefaultButton
            >
          </div>
        </template>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton v-if="form.school_grade_id" type="default" @click="submit" :disabled="process">
        Simpan
      </DefaultButton>
    </div>
  </div>
</template>
