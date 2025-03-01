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
        admission_stage_id: item.uuid,
        type: item.type,
        title: item.title,
        sort_number: index + 1,
        statuses:
          item.statuses?.map((status, statusIndex) => ({
            admission_stage_status_id: status.uuid,
            title: status.title,
            is_finished: status.is_finished || false,
            sort_number: statusIndex + 1,
          })) || [],
      }));
    }
  },
  methods: {
    addNewAdmissionStage() {
      let newObj = {
        admission_stage_id: null,
        type: '',
        title: '',
        sort_number: this.admission_stages.length + 1,
        statuses: [],
      };
      this.admission_stages.push(newObj);
    },
    addNewStatus(index) {
      this.admission_stages[index].statuses.push({
        admission_stage_status_id: null,
        title: '',
        is_finished: false,
        sort_number: this.admission_stages[index].statuses.length + 1,
      });
    },
    removeAdmissionStage(index) {
      this.admission_stages.splice(index, 1);
      this.renumberSortNumbers();
    },
    removeStatus(stageIndex, statusIndex) {
      this.admission_stages[stageIndex].statuses.splice(statusIndex, 1);
      this.renumberStatusNumbers(stageIndex);
    },
    renumberSortNumbers() {
      this.admission_stages.forEach((item, index) => {
        item.sort_number = index + 1;
      });
    },
    renumberStatusNumbers(stageIndex) {
      this.admission_stages[stageIndex].statuses.forEach((status, index) => {
        status.sort_number = index + 1;
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

    <el-form v-if="loaded" ref="admissionStageForm" label-position="top" :disabled="process" class="space-y-4">
      <template v-for="(stage, index) in admission_stages" :key="index">
        <div class="rounded-lg border p-4 shadow-sm">
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">
            {{ 'Tahap Pendaftaran ' + stage.sort_number }}
          </h2>
          <el-form-item class="w-full font-medium md:w-1/2" label="Tahap Pendaftaran">
            <el-input v-model="stage.title" autocomplete="off" />
          </el-form-item>
          <el-form-item class="w-full font-medium md:w-1/4" label="Jenis Tahapan">
            <el-select v-model="stage.type" placeholder="Pilih Jenis">
              <el-option label="Pra" value="PRE" />
              <el-option label="Pasca" value="POST" />
            </el-select>
          </el-form-item>
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Status</h2>
          <div v-for="(status, statusIndex) in stage.statuses" :key="statusIndex" class="grid space-x-4 md:grid-cols-3">
            <el-form-item class="font-medium" label="Judul Status">
              <el-input v-model="status.title" autocomplete="off" />
            </el-form-item>
            <el-form-item class="font-medium" label="Dianggap selesai">
              <el-checkbox v-model="status.is_finished" :label="status.is_finished ? 'Ya' : 'Tidak'" />
            </el-form-item>
            <div class="flex items-center justify-end">
              <OutlineButton class="my-auto" type="red" @click="removeStatus(index, statusIndex)"
                >Hapus Status</OutlineButton
              >
            </div>
          </div>
          <DefaultButton type="light" @click="addNewStatus(index)" class="mt-3">Tambah Status Baru</DefaultButton>
          <div
            v-if="index == admission_stages.length - 1"
            class="mt-3 flex items-center justify-end space-x-3 border-t pt-3"
          >
            <OutlineButton type="red" @click="removeAdmissionStage(index)" class="flex space-x-1">
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
              <div>Hapus Tahapan</div>
            </OutlineButton>
          </div>
        </div>
      </template>
      <DefaultButton type="default" @click="addNewAdmissionStage(index)">Tambah Tahapan Baru</DefaultButton>
    </el-form>

    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Perbarui </DefaultButton>
    </div>
  </div>
</template>
