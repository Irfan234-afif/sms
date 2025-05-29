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
        assessment_module_id: null,
        name: null,
        type: 'SUBJECT',
        description: null,
      },
      field: {
        name: {
          label: 'Modul',
          rules: [fieldValidation.isRequired('Modul')],
          error: null,
        },
        type: {
          label: 'Kategory',
          rules: [fieldValidation.isRequired('Kategory')],
          error: null,
          options: [
            {
              label: 'Mata Pelajaran',
              value: 'SUBJECT',
              disabled: false,
            },
            {
              label: 'Ekstrakurikuler',
              value: 'EXTRACURRICULAR',
              disabled: true,
            },
            {
              label: 'Pengembangan Diri',
              value: 'PERSONAL_DEVELOPMENT',
              disabled: true,
            },
          ],
        },
        description: {
          label: 'Keterangan',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'assessment-module-edit-form') {
      this.form.assessment_module_id = this.propertyModal.data.assessment_module.uuid;
      this.form.name = this.propertyModal.data.assessment_module.name;
      this.form.type = this.propertyModal.data.assessment_module.type;
      this.form.description = this.propertyModal.data.assessment_module.description;
    }
  },
  methods: {
    submit() {
      this.$refs['assessmentModuleForm'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('school.teachingProgram.assessmentModule.save'), requestPayload, {
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
                  this.$refs['assessmentModuleForm'].validateField(field);
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
      <el-form v-if="loaded" ref="assessmentModuleForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.type.label"
          :rules="field.type.rules"
          :error="field.type.error"
          prop="type"
        >
          <el-select v-model="form.type" :placeholder="`Pilih ${field.type.label}`" clearable>
            <el-option
              v-for="option in field.type.options"
              :key="option.value"
              :label="option.label"
              :disabled="option.disabled"
              :value="option.value"
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
          <el-input type="textarea" v-model="form.description" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
