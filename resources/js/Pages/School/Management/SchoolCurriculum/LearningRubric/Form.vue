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
        learning_rubric_id: this.propertyModal.data?.learning_rubric?.uuid,
        school_curriculum_id: this.propertyModal.data.school_curriculum.uuid,
        title: null,
        code: null,
        scales: [],
      },
      field: {
        title: {
          label: 'Nama',
          rules: [fieldValidation.isRequired('Nama')],
          error: null,
          disabled: false,
          options: [],
        },
        code: {
          label: 'Kode',
          rules: [fieldValidation.isRequired('Kode')],
          error: null,
          disabled: false,
          options: [],
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'learning-rubric-edit-form') {
      this.form.title = this.propertyModal.data.learning_rubric?.title;
      this.form.code = this.propertyModal.data.learning_rubric?.code;
      this.propertyModal.data.learning_rubric?.scales.map((item) => {
        this.addNewScale(item);
      });
    }
  },
  methods: {
    addNewScale(scale = null) {
      let newObj = {
        id: null,
        title: '',
        value: 0,
        narrative: '',
      };

      if (scale) {
        newObj.id = scale.uuid;
        newObj.title = scale.title;
        newObj.value = scale.value;
        newObj.narrative = scale.narrative;
      }

      this.form.scales.push(newObj);
    },
    removeScale(index) {
      this.form.scales.splice(index, 1);
    },
    submit() {
      this.$refs['learningRubricForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));
          axios
            .post(route('school.management.schoolCurriculum.learningRubric.save'), requestPayload, {
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
                  this.$refs['learningRubricForm'].validateField(field);
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
      <el-form v-if="loaded" ref="learningRubricForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.code.label"
          :rules="field.code.rules"
          :error="field.code.error"
          prop="code"
        >
          <el-input v-model="form.code" autocomplete="off" />
        </el-form-item>
        <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Skala</h2>
        <div class="space-y-3">
          <div
            v-for="(scales, index) in form.scales"
            :key="index"
            class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
          >
            <el-form-item class="font-medium" :label="`Skala ${index + 1}`">
              <el-input v-model="scales.title" autocomplete="off" />
            </el-form-item>
            <el-form-item class="font-medium" label="Nilai">
              <el-input-number v-model="scales.value" autocomplete="off" />
            </el-form-item>
            <el-form-item class="font-medium" label="Naratif">
              <el-input type="textarea" v-model="scales.narrative" autocomplete="off" />
            </el-form-item>
            <div class="flex items-center justify-end">
              <OutlineButton class="my-auto" type="red" @click="removeScale(index)">Hapus</OutlineButton>
            </div>
          </div>
        </div>
        <DefaultButton type="light" @click="addNewScale()" class="mt-3">Tambah Skala</DefaultButton>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
