<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import { participantTypes, transportationTypes, units } from '@/Helpers/options';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import moment from 'moment';
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
      actionRoute: route('office.ga.approval.event.store'),
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        title: null,
        place: null,
        datetime_range: null,
        description: null,
        bill_amount: 0,
        objectives: [],
        participants: [],
        transportations: [],
        items: [],
      },
      field: {
        datetime: {
          label: 'Tanggal',
          rules: [fieldValidation.isRequired('Tanggal')],
          error: null,
          disabled: true,
        },
        title: {
          label: 'Acara',
          rules: [fieldValidation.isRequired('Acara')],
          error: null,
        },
        place: {
          label: 'Lokasi',
          rules: [fieldValidation.isRequired('Lokasi')],
          error: null,
        },
        datetime_range: {
          label: 'Waktu',
          rules: [fieldValidation.isRequired('Waktu')],
          error: null,
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
    if (this.propertyModal.mode == 'submission-edit-form') {
      let submission = this.propertyModal.data.submission;
      this.actionRoute = route('office.ga.approval.event.update');

      this.form.submission_id = submission.uuid;
      this.form.datetime = submission.datetime;
      this.form.status = submission.status;
      this.form.title = submission.event.title;
      this.form.place = submission.event.place;
      this.form.datetime_range = [submission.event.start_datetime, submission.event.end_datetime];
      this.form.description = submission.event.description;
      this.form.bill_amount = submission.event.bill_amount;

      submission.event.items.map((item) => {
        this.addNewItem(item);
      });

      submission.event.participants.map((item) => {
        this.addNewParticipant(item);
      });

      submission.event.transportations.map((item) => {
        this.addNewTransportation(item);
      });

      submission.event.objectives.map((item) => {
        this.addNewObjective(item);
      });
    }
  },
  methods: {
    addNewObjective(item) {
      let newObj = {
        sub_event_objective_id: item?.uuid,
        title: item?.title,
        description: item?.description,
        remark: item?.remark,
      };
      this.form.objectives.push(newObj);
    },
    removeObjective(index) {
      this.form.objectives.splice(index, 1);
    },
    addNewParticipant(item) {
      let newObj = {
        sub_event_participant_id: item?.uuid,
        type: item?.type,
        quantity: item?.quantity ?? 0,
      };
      this.form.participants.push(newObj);
    },
    removeParticipant(index) {
      this.form.participants.splice(index, 1);
    },
    addNewTransportation(item) {
      let newObj = {
        sub_event_transportation_id: item?.uuid,
        type: item?.type,
        quantity: item?.quantity ?? 0,
        unit_cost: item?.unit_cost ?? 0,
      };
      this.form.transportations.push(newObj);
    },
    removeTransportation(index) {
      this.form.transportations.splice(index, 1);
    },
    addNewItem(item) {
      let newObj = {
        sub_event_item_id: item?.uuid,
        name: item?.name,
        quantity: item?.quantity ?? 0,
        unit: item?.unit,
        price: item?.price ?? 0,
        bill_amount: item?.bill_amount ?? 0,
        description: item?.description,
      };
      this.form.items.push(newObj);
    },
    removeItem(index) {
      this.form.items.splice(index, 1);
    },
    submit() {
      this.$refs['submissionForm'].validate((valid) => {
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
              let message = 'Terjadi kesalahan';

              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field][0];
                  this.$refs['submissionForm'].validateField(field);
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
      <el-form
        v-if="loaded"
        ref="submissionForm"
        label-position="top"
        :model="form"
        :disabled="process"
        class="grid grid-cols-3 gap-4"
      >
        <div class="col-span-1">
          <el-form-item
            class="font-medium"
            :label="field.datetime.label"
            :rules="field.datetime.rules"
            :error="field.datetime.error"
            prop="datetime"
          >
            <el-date-picker
              :disabled="field.datetime.disabled"
              v-model="form.datetime"
              type="date"
              format="DD-MM-YYYY"
              value-format="YYYY-MM-DD"
            />
          </el-form-item>
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
            :label="field.place.label"
            :rules="field.place.rules"
            :error="field.place.error"
            prop="place"
          >
            <el-input type="textarea" v-model="form.place" autocomplete="off" />
          </el-form-item>
          <el-form-item
            :label="field.datetime_range.label"
            :rules="field.datetime_range.rules"
            :error="field.datetime_range.error"
            prop="datetime_range"
          >
            <el-date-picker
              v-model="form.datetime_range"
              type="datetimerange"
              range-separator="to"
              start-placeholder="Mulai"
              end-placeholder="Selesai"
              format="DD-MM-YYYY HH:mm:ss"
              value-format="YYYY-MM-DD HH:mm:ss"
            />
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
        </div>
        <div class="col-span-2 space-y-4">
          <div>
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Tujuan Acara</h2>
            <div v-for="(objective, index) in form.objectives" :key="index" class="grid gap-4 md:grid-cols-4">
              <el-form-item class="font-medium" label="Tujuan Acara">
                <el-input v-model="objective.title" autocomplete="off" />
              </el-form-item>
              <el-form-item class="font-medium" label="Keterangan">
                <el-input v-model="objective.description" autocomplete="off" />
              </el-form-item>
              <el-form-item class="font-medium" label="Catatan">
                <el-input v-model="objective.remark" autocomplete="off" />
              </el-form-item>
            </div>
          </div>
          <div>
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Peserta</h2>
            <div v-for="(participant, index) in form.participants" :key="index" class="grid gap-4 md:grid-cols-3">
              <el-form-item class="font-medium" label="Peserta">
                <el-select
                  v-model="participant.type"
                  placeholder="Peserta"
                  loading-text="..."
                  no-match-text="Data tidak ditemukan"
                  no-data-text="Tidak ada data"
                  clearable
                  autocomplete="off"
                >
                  <el-option
                    v-for="option in participantTypes"
                    :key="option.value"
                    :label="option.label"
                    :value="option.value"
                  />
                </el-select>
              </el-form-item>
              <el-form-item class="font-medium" label="Jumlah Peserta">
                <el-input-number v-model="participant.quantity" autocomplete="off" />
              </el-form-item>
            </div>
          </div>
          <div>
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Transportasi</h2>
            <div v-for="(transportation, index) in form.transportations" :key="index" class="grid gap-4 md:grid-cols-4">
              <el-form-item class="font-medium" label="Jenis Transportasi">
                <el-select
                  v-model="transportation.type"
                  placeholder="Pilih Transportasi"
                  loading-text="..."
                  no-match-text="Data tidak ditemukan"
                  no-data-text="Tidak ada data"
                  clearable
                  autocomplete="off"
                >
                  <el-option
                    v-for="option in transportationTypes"
                    :key="option.value"
                    :label="option.label"
                    :value="option.value"
                  />
                </el-select>
              </el-form-item>
              <el-form-item class="font-medium" label="Jumlah Unit">
                <el-input-number v-model="transportation.quantity" autocomplete="off" />
              </el-form-item>
              <el-form-item class="font-medium" label="Biaya Per Unit">
                <el-input type="number" v-model.number="transportation.unit_cost" autocomplete="off" />
              </el-form-item>
            </div>
          </div>
          <div>
            <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Item</h2>
            <div v-for="(item, index) in form.items" :key="index" class="grid gap-4 md:grid-cols-4">
              <el-form-item class="font-medium" label="Item">
                <el-input v-model="item.name" autocomplete="off" />
              </el-form-item>
              <el-form-item class="font-medium" label="Jumlah">
                <el-input-number
                  v-model="item.quantity"
                  autocomplete="off"
                  @change="item.bill_amount = item.quantity * item.price"
                />
              </el-form-item>
              <el-form-item class="font-medium" label="Satuan">
                <el-select
                  v-model="item.unit"
                  placeholder="Pilih Satuan"
                  loading-text="..."
                  no-match-text="Data tidak ditemukan"
                  no-data-text="Tidak ada data"
                  clearable
                  autocomplete="off"
                >
                  <el-option v-for="option in units" :key="option.value" :label="option.label" :value="option.value" />
                </el-select>
              </el-form-item>
              <el-form-item class="font-medium" label="Biaya Satuan">
                <el-input
                  type="number"
                  v-model.number="item.price"
                  autocomplete="off"
                  @input="item.bill_amount = item.quantity * item.price"
                />
              </el-form-item>
              <el-form-item class="font-medium" label="Biaya Total">
                <el-input disabled type="number" v-model.number="item.bill_amount" autocomplete="off" />
              </el-form-item>
              <el-form-item class="font-medium" label="Keterangan">
                <el-input type="textarea" v-model="item.description" autocomplete="off" />
              </el-form-item>
            </div>
          </div>
        </div>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton
        v-if="propertyModal.data.submission.status != 'APPROVED'"
        type="default"
        @click="submit()"
        :disabled="process"
      >
        Simpan
      </DefaultButton>
    </div>
  </div>
</template>
