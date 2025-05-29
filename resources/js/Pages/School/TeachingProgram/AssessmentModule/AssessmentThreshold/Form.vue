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
        assessment_threshold_id: this.propertyModal.data?.assessment_threshold?.uuid,
        assessment_module_id: this.propertyModal.data.assessment_module.uuid,
        name: null,
        description: null,
        scales: [],
      },
      field: {
        name: {
          label: 'Kriteria Ketercapaian',
          rules: [fieldValidation.isRequired('Kriteria Ketercapaian')],
          error: null,
          disabled: false,
          options: [],
        },
        description: {
          label: 'Keterangan',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'assessment-threshold-edit-form') {
      this.form.name = this.propertyModal.data.assessment_threshold?.name;
      this.form.description = this.propertyModal.data.assessment_threshold?.description;
      this.propertyModal.data.assessment_threshold?.scales.map((item) => {
        this.addNewScale(item);
      });
    }
  },
  methods: {
    addNewScale(scale = null) {
      let newObj = {
        id: null,
        status: 'PASSED',
        score: 0,
        predicate: '',
        narrative: '',
      };

      if (scale) {
        newObj.id = scale.uuid;
        newObj.status = scale.status;
        newObj.score = scale.score;
        newObj.predicate = scale.predicate;
        newObj.narrative = scale.narrative;
      }

      this.form.scales.push(newObj);
    },
    removeScale(index) {
      this.form.scales.splice(index, 1);
    },
    submit() {
      this.$refs['assessmentThresholdForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));
          axios
            .post(route('school.teachingProgram.assessmentModule.assessmentThreshold.save'), requestPayload, {
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
                  this.$refs['assessmentThresholdForm'].validateField(field);
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
      <el-form v-if="loaded" ref="assessmentThresholdForm" label-position="top" :model="form" :disabled="process">
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
          :label="field.description.label"
          :rules="field.description.rules"
          :error="field.description.error"
          prop="description"
        >
          <el-input v-model="form.description" autocomplete="off" />
        </el-form-item>
        <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Skala</h2>
        <div class="space-y-3">
          <div
            v-for="(scale, index) in form.scales"
            :key="index"
            class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
          >
            <el-form-item class="font-medium" label="Status">
              <el-radio-group v-model="scale.status">
                <el-radio value="PASSED" label="Tuntas"></el-radio>
                <el-radio value="FAILED" label="Tidak Tuntas"></el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item class="font-medium" label="Skor">
              <el-input-number v-model="scale.score" autocomplete="off" />
            </el-form-item>
            <el-form-item class="font-medium" label="Predikat">
              <el-input v-model="scale.predicate" autocomplete="off" />
            </el-form-item>
            <el-form-item class="font-medium" label="Naratif">
              <el-input type="textarea" v-model="scale.narrative" autocomplete="off" />
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
