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
      submission_group: this.propertyModal?.data?.submission_group,
      area: this.propertyModal?.data?.area,
      submission_approvers: [],
    };
  },
  created() {
    this.getSubmissionApprover();
  },
  methods: {
    getSubmissionApprover() {
      axios
        .get(
          route('office.qrd.setting.submissionApprover.getSubmissionApprover', {
            submission_group_id: this.submission_group.uuid,
            area_id: this.area.uuid,
          }),
        )
        .then((response) => {
          let submission_approvers = response.data;

          if (submission_approvers) {
            this.submission_approvers = submission_approvers.map((item, index) => ({
              submission_approver_id: item.uuid,
              approver_id: item.approver.uuid,
              approver_id_options: [item.approver],
              sort_number: index + 1,
              delegates:
                item.delegates?.map((delegate, delegateIndex) => ({
                  submission_approval_delegate_id: delegate.uuid,
                  delegate_id: delegate.delegate.uuid,
                  delegate_id_options: [delegate.delegate],
                  sort_number: delegateIndex + 1,
                })) || [],
            }));
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionApprover(search, index) {
      axios
        .get(
          route('office.qrd.setting.submissionApprover.optionEmployee', {
            search: search,
          }),
        )
        .then((response) => {
          this.submission_approvers[index].approver_id_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionDelegate(search, index, subIndex) {
      axios
        .get(
          route('office.qrd.setting.submissionApprover.optionEmployee', {
            search: search,
          }),
        )
        .then((response) => {
          this.submission_approvers[index].delegates[subIndex].delegate_id_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    addSubmissionApprover() {
      let newObj = {
        submission_approver_id: null,
        approver_id: null,
        approver_id_options: [],
        sort_number: this.submission_approvers.length + 1,
        delegates: [],
      };
      this.submission_approvers.push(newObj);
    },
    addNewDelegate(index) {
      this.submission_approvers[index].delegates.push({
        submission_approval_delegate_id: null,
        delegate_id: null,
        delegate_id_options: [],
        sort_number: this.submission_approvers[index].delegates.length + 1,
      });
    },
    removeApprover(index) {
      this.submission_approvers.splice(index, 1);
      this.renumberSortNumbers();
    },
    removeDelegate(stageIndex, delegateIndex) {
      this.submission_approvers[stageIndex].delegates.splice(delegateIndex, 1);
      this.renumberStatusNumbers(stageIndex);
    },
    renumberSortNumbers() {
      this.submission_approvers.forEach((item, index) => {
        item.sort_number = index + 1;
      });
    },
    renumberStatusNumbers(stageIndex) {
      this.submission_approvers[stageIndex].delegates.forEach((status, index) => {
        status.sort_number = index + 1;
      });
    },
    submit() {
      this.process = true;
      let requestPayload = {
        submission_group_id: this.submission_group.uuid,
        area_id: this.area.uuid,
        submission_approvers: this.submission_approvers,
      };

      axios
        .post(route('office.qrd.setting.submissionApprover.save'), requestPayload, {
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
      <template v-for="(submission_approver, index) in submission_approvers" :key="index">
        <div class="rounded-lg border p-4 shadow-sm">
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">
            {{ 'Petugas Persetujuan Tahap ' + submission_approver.sort_number }}
          </h2>
          <el-form-item class="w-full font-medium md:w-1/2" label="Petugas Persetujuan">
            <el-select
              v-model="submission_approver.approver_id"
              placeholder="Pilih Petugas"
              loading-text="..."
              no-match-text="Data tidak ditemukan"
              no-data-text="Tidak ada data"
              :remote-method="(search) => optionApprover(search, index)"
              remote
              filterable
              reserve-keyword
              clearable
              autocomplete="off"
            >
              <el-option
                v-for="option in submission_approver.approver_id_options"
                :key="option.uuid"
                :label="option.profile.name"
                :value="option.uuid"
              />
            </el-select>
          </el-form-item>
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Petugas Perwakilan</h2>
          <div
            v-for="(delegate, delegateIndex) in submission_approver.delegates"
            :key="delegateIndex"
            class="grid space-x-4 md:grid-cols-2"
          >
            <el-form-item class="font-medium" label="Petugas">
              <el-select
                v-model="delegate.delegate_id"
                placeholder="Pilih Petugas"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="(search) => optionDelegate(search, index, delegateIndex)"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
              >
                <el-option
                  v-for="option in delegate.delegate_id_options"
                  :key="option.uuid"
                  :label="option.profile.name"
                  :value="option.uuid"
                />
              </el-select>
            </el-form-item>
            <div class="flex items-center justify-end">
              <OutlineButton class="my-auto flex space-x-1" type="red" @click="removeDelegate(index, delegateIndex)">
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
                <div>Hapus Petugas Perwakilan</div>
              </OutlineButton>
            </div>
          </div>
          <DefaultButton type="light" @click="addNewDelegate(index)" class="mt-3"
            >Tambah Petugas Perwakilan</DefaultButton
          >
          <div
            v-if="index == submission_approvers.length - 1"
            class="mt-3 flex items-center justify-end space-x-3 border-t pt-3"
          >
            <OutlineButton type="red" @click="removeApprover(index)" class="flex space-x-1">
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
              <div>Hapus Petugas Persetujuan</div>
            </OutlineButton>
          </div>
        </div>
      </template>
      <DefaultButton type="default" @click="addSubmissionApprover(index)">Tambah Petugas Persetujuan</DefaultButton>
    </el-form>

    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>