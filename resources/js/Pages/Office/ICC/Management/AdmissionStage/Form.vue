<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
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
      school: this.propertyModal?.data?.school,
      admission_stages: [],
    };
  },
  created() {
    if (this.propertyModal?.data?.admission_stages) {
      this.admission_stages = this.propertyModal.data.admission_stages.map((item, index) => ({
        id: item.id,
        type: item.type,
        title: item.title,
        sort_number: index + 1,
      }));
    }
  },
  methods: {
    addNewAdmissionStage() {
      let newObj = {
        id: null,
        type: '',
        title: '',
        sort_number: this.admission_stages.length + 1,
      };
      this.admission_stages.push(newObj);
    },
    removeAdmissionStage(index) {
      this.admission_stages.splice(index, 1);
      this.renumberSortNumbers();
    },
    renumberSortNumbers() {
      this.admission_stages.forEach((item, index) => {
        item.sort_number = index + 1;
      });
    },
    submit() {
      this.process = true;
      let requestPayload = {
        school: this.school.uuid,
        admission_stages: this.admission_stages,
      };

      axios
        .post(route('office.icc.management.admissionStage.save'), requestPayload, {
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
      <h3 class="my-3 text-sm font-semibold text-gray-700">Tahap Pendaftaran</h3>
      <div v-for="(stage, index) in admission_stages" :key="index" class="mt-2 flex items-center space-x-3">
        <span class="w-6 text-center text-xs font-medium">{{ index + 1 }}</span>
        <el-input v-model="stage.title" placeholder="Judul" />
        <el-select v-model="stage.type" placeholder="Pilih tipe">
          <el-option label="Pra" value="PRE" />
          <el-option label="Pasca" value="POST" />
        </el-select>
        <OutlineButton
          type="red"
          @click="removeAdmissionStage(index)"
          class="flex space-x-1"
          :class="{
            invisible: index != admission_stages.length - 1,
          }"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="h-4"
          >
            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
            <path d="M4 7l16 0" />
            <path d="M10 11l0 6" />
            <path d="M14 11l0 6" />
            <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" />
            <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" />
          </svg>
        </OutlineButton>
      </div>

      <DefaultButton type="light" @click="addNewAdmissionStage" class="mt-3 flex space-x-1">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="1.5"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="h-4"
        >
          <path stroke="none" d="M0 0h24v24H0z" fill="none" />
          <path d="M12 5l0 14" />
          <path d="M5 12l14 0" />
        </svg>
        <div>Tahapan Pendaftaran Baru</div>
      </DefaultButton>
    </el-form>

    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Perbarui </DefaultButton>
    </div>
  </div>
</template>
